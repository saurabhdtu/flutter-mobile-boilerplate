package com.zinc.money

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Base64
import android.util.Log
import android.widget.Toast
import com.google.android.gms.auth.api.identity.GetPhoneNumberHintIntentRequest
import com.google.android.gms.auth.api.identity.Identity
import com.google.android.gms.auth.api.phone.SmsRetriever
import com.zinc.money.tools.SmsBroadcastReceiver
import com.scottyab.rootbeer.RootBeer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

class MainActivity : FlutterActivity(), MethodCallHandler, SmsBroadcastReceiver.SmsListener {
    private var platformChannel: MethodChannel? = null
    private var localScreenChannel: MethodChannel? = null
    private val TAG = "Native activity"
    private val PHONE_NUMBER_HINT_REQUEST_CODE = 1001
    private var startedSmsRetriever = false
    private var methodChannelResult: MethodChannel.Result? = null
    private var smsBroadcastReceiver: SmsBroadcastReceiver? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        smsBroadcastReceiver = SmsBroadcastReceiver()
        smsBroadcastReceiver?.setListener(this)
        showToast((getAppSignatures(this)).first().substring(0, 11))
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        platformChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.zinc.money/platform")
        localScreenChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.zinc.money/screen")
        platformChannel?.setMethodCallHandler(this)
        localScreenChannel?.setMethodCallHandler(this)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                PHONE_NUMBER_HINT_REQUEST_CODE -> {
                    if (data != null) {
                        val phoneNumberHint = Identity.getSignInClient(this)
                            .getPhoneNumberFromIntent(data)
                        methodChannelResult?.success(phoneNumberHint)
                    } else {
                        methodChannelResult?.error("Not found", null, null)
                        Log.e(TAG, "Phone number hint request failed")
                    }
                }
            }
        }
    }

    override fun onStart() {
        super.onStart()
        val intentFilter = IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            registerReceiver(smsBroadcastReceiver, intentFilter, RECEIVER_EXPORTED)
        } else {
            registerReceiver(smsBroadcastReceiver, intentFilter)
        }
    }

    override fun onStop() {
        smsBroadcastReceiver?.let { unregisterReceiver(it) }
        super.onStop()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        methodChannelResult = result
        when (call.method) {
            "get_config" -> {
                result.success(
                    mapOf(
                        "base_url" to BuildConfig.BASE_URL,
                        "version_code" to BuildConfig.VERSION_CODE.toString(),
                        "version_name" to BuildConfig.VERSION_NAME,
                        "app_id" to BuildConfig.APPLICATION_ID,
                        "mixpanel_token" to BuildConfig.MIXPANEL_TOKEN,
                        "moengage_id" to BuildConfig.MOENGAGE_ID,
                        "hv_app_id" to BuildConfig.HV_APP_ID,
                        "hv_api_key" to BuildConfig.HV_API_KEY
                    )
                )
            }
            "jailbroken" -> {
                val rootBeer = RootBeer(this)
                result.success(rootBeer.isRooted)
            }
            "developerMode" -> {
                result.success(isDevMode())
            }
            "phone_number_hint" -> {
                val request: GetPhoneNumberHintIntentRequest =
                    GetPhoneNumberHintIntentRequest.builder().build()
                Identity.getSignInClient(this)
                    .getPhoneNumberHintIntent(request)
                    .addOnSuccessListener { pi ->
                        try {
                            startIntentSenderForResult(
                                pi.intentSender,
                                PHONE_NUMBER_HINT_REQUEST_CODE,
                                null,
                                0,
                                0,
                                0
                            )
                        } catch (e: Exception) {
                            Log.e(TAG, "Launching the PendingIntent failed")
                        }
                    }
                    .addOnFailureListener {
                        Log.e(TAG, "Phone Number Hint failed")
                    }
            }
            "start_sms_retriever" -> {
                val client = SmsRetriever.getClient(this)
                val task = client.startSmsRetriever()
                task.addOnSuccessListener {
                    startedSmsRetriever = true
                    CoroutineScope(Dispatchers.IO).launch {
                        delay(5 * 60 * 1000) // after 5 minutes initialize again
                        startedSmsRetriever = false
                    }
                }
                task.addOnFailureListener {
                    startedSmsRetriever = false
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun isDevMode(): Boolean {
        return Settings.Secure.getInt(
            contentResolver,
            Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0
        ) != 0
    }

    override fun onSmsReceived(message: String) {
        showToast(message)
        localScreenChannel?.invokeMethod("on_sms_received", message)
    }

    override fun onSmsTimeOut() {
    }

    private fun showToast(message: String) =
        if (BuildConfig.DEBUG) Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
        else Unit

    private fun getAppSignatures(context: Context): List<String> {
        val appSignatures: MutableList<String> = ArrayList()
        try {
            val packageInfo = context.packageManager
                .getPackageInfo(context.packageName, PackageManager.GET_SIGNATURES)
            for (signature in packageInfo.signatures) {
                val hash = getHash(context.packageName, signature.toCharsString())
                if (hash != null) {
                    appSignatures.add(hash)
                }
            }
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }
        return appSignatures
    }

    private fun getHash(packageName: String, signature: String): String? {
        val appInfo = "$packageName $signature"
        try {
            val messageDigest = MessageDigest.getInstance("SHA-256")
            messageDigest.update(appInfo.toByteArray())
            val hashSignature = messageDigest.digest()
            val truncatedHashSignature = ByteArray(9)
            System.arraycopy(hashSignature, 0, truncatedHashSignature, 0, 9)
            return Base64.encodeToString(truncatedHashSignature, Base64.NO_PADDING or Base64.NO_WRAP)
        } catch (e: NoSuchAlgorithmException) {
            e.printStackTrace()
        }
        return null
    }
}

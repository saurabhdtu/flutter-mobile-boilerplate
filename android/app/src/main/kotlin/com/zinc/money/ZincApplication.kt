package com.zinc.money

import android.app.Application
import com.facebook.FacebookSdk
import com.facebook.LoggingBehavior
import com.moengage.core.DataCenter
import com.moengage.core.LogLevel
import com.moengage.core.MoEngage
import com.moengage.core.config.LogConfig
import com.moengage.flutter.MoEInitializer
import com.moengage.core.config.NotificationConfig
import com.zinc.money.BuildConfig
import com.zinc.money.R

class ZincApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        FacebookSdk.fullyInitialize()
        FacebookSdk.setAutoInitEnabled(true)
        FacebookSdk.setAdvertiserIDCollectionEnabled(true)
        FacebookSdk.setIsDebugEnabled(BuildConfig.DEBUG);
        FacebookSdk.addLoggingBehavior(LoggingBehavior.APP_EVENTS);
        val moEngage: MoEngage.Builder =
            MoEngage.Builder(this, BuildConfig.MOENGAGE_ID, DataCenter.DATA_CENTER_3).configureLogs(
                LogConfig(
                    LogLevel.VERBOSE, BuildConfig.DEBUG
                )
            ).configureNotificationMetaData(
                   NotificationConfig(R.mipmap.ic_launcher, R.mipmap.ic_launcher)
            )
//        MoEngage.initialiseDefaultInstance(moEngage.build())
        MoEInitializer.initialiseDefaultInstance(context = this, builder = moEngage)
    }
}
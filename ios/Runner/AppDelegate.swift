import UIKit
import Flutter
import moengage_flutter_ios
import MoEngageSDK
import FBSDKCoreKit
import IOSSecuritySuite
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        let moengageID = (Bundle.main.infoDictionary?["MoengageID"] as? String) ?? ""
        let sdkConfig = MoEngageSDKConfig(appId: moengageID, dataCenter: MoEngageDataCenter.data_center_03)
        sdkConfig.consoleLogConfig = MoEngageConsoleLogConfig(isLoggingEnabled: true, loglevel: MoEngageLoggerType.debug)
        sdkConfig.updateConfigForTestEnvironment()
        MoEngageInitializer.sharedInstance.initializeDefaultInstance(sdkConfig, launchOptions: launchOptions)
        MoEngageSDKMessaging.sharedInstance.registerForRemoteNotification(withCategories: nil, andUserNotificationCenterDelegate: self)

        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        let platformChannel = FlutterMethodChannel(name: "com.zinc.money/platform", binaryMessenger: flutterViewController.binaryMessenger)
        platformChannel.setMethodCallHandler { [weak self] (call, result) in
            if call.method == "get_config" {
                if let plist = Bundle.main.infoDictionary {
                    let baseURL = plist["BaseURL"] as? String ?? ""
                    let mixpanelToken = plist["MixPanelToken"] as? String ?? ""
                    let hvAppId = plist["HvAppID"] as? String ?? ""
                    let hvApiKey = plist["HvApiKey"] as? String ?? ""
                    let appleId = Bundle.main.object(forInfoDictionaryKey: "AppStoreID") as? String
                    let buildVersionCode = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
                    let buildVersionName = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
                    let bundleIdentifier = Bundle.main.bundleIdentifier ?? ""

                        let configDict: [String: Any] = [
                            "base_url": baseURL,
                            "mixpanel_token": mixpanelToken,
                            "version_code": buildVersionCode,
                            "version_name": buildVersionName,
                            "app_id": bundleIdentifier,
                            "apple_id": appleId,
                            "hv_app_id": hvAppId,
                            "hv_api_key": hvApiKey,
                            "moengage_id": moengageID

                        ]
                            result(configDict)
                        } else {
                            result(FlutterError(code: "CONFIG_ERROR", message: "Configuration values not found", details: nil))
                        }
                }
            }
      
      let localScreenChannel = FlutterMethodChannel(name: "com.zinc.money/screen", binaryMessenger: flutterViewController.binaryMessenger)
      localScreenChannel.setMethodCallHandler { [weak self] (call, result) in
          if call.method == "method_name" {
            
          }
      }

  // jail broken detection

    let jailBrokenChannel = FlutterMethodChannel(name: "flutter_jailbreak_detection", binaryMessenger:  flutterViewController.binaryMessenger)
       jailBrokenChannel.setMethodCallHandler {[weak self] (call, result) in
        switch call.method {
        case "jailbroken":
            let check2 = IOSSecuritySuite.amIJailbroken()
            result(check2)
        case "developerMode":
            result(IOSSecuritySuite.amIRunInEmulator())
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)

            // Set the push registration token for Freshchat
            let freshchatSdkPlugin = FreshchatSdkPlugin()
            freshchatSdkPlugin.setPushRegistrationToken(deviceToken)
        }

        override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            let freshchatSdkPlugin = FreshchatSdkPlugin()

            if freshchatSdkPlugin.isFreshchatNotification(userInfo) {
                freshchatSdkPlugin.handlePushNotification(userInfo)
            }

            super.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }

        override func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey: Any] = [:]
        ) -> Bool {
            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
            return true
        }
}

import Flutter
import UIKit
import Firebase
import FirebaseMessaging
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCNo-8Abz5f1OBssDg_476sfsJNM6OxaWI")
    GeneratedPluginRegistrant.register(with: self)

    // set up remote notification
    if #available(iOS 10.0, *) {
       UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
       let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
       UNUserNotificationCenter.current().requestAuthorization(
         options: authOptions,
         completionHandler: {_, _ in })
     } else {
       let settings: UIUserNotificationSettings =
       UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
       application.registerUserNotificationSettings(settings)
     }

    application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication,
   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
     Messaging.messaging().apnsToken = deviceToken
     super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
   }
}

import UIKit
import Flutter
import GoogleMaps
// import Firebase
// import FirebaseCore
// import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   GMSServices.provideAPIKey("AIzaSyCflsZnyywCyrdFJhGoFbpab60hKwgFHFQ")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

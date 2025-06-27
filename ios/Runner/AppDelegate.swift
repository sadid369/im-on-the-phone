import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let audioRouteChannel = FlutterMethodChannel(name: "audio_route",
                                                 binaryMessenger: controller.binaryMessenger)
    audioRouteChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "routeToEarpiece" {
        do {
          let session = AVAudioSession.sharedInstance()
          try session.setCategory(.playAndRecord, options: [.allowBluetooth])
          try session.setActive(true)
          try session.overrideOutputAudioPort(.none) // Force earpiece
          result(nil)
        } catch {
          result(FlutterError(code: "AUDIO_SESSION_ERROR", message: error.localizedDescription, details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let SCREENSHOT_CHANNEL = "com.example.app/screenshot"
  private var snapshotView: UIView?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let screenshotChannel = FlutterMethodChannel(name: SCREENSHOT_CHANNEL, binaryMessenger: controller.binaryMessenger)

    screenshotChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard call.method == "preventScreenshots" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.preventScreenshots(arguments: call.arguments as? Bool ?? false)
      result(nil)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func preventScreenshots(arguments: Bool) {
    if arguments {
      let snapshotView = UIView(frame: UIScreen.main.bounds)
      snapshotView.backgroundColor = UIColor.white // You can set any color you like
      window?.addSubview(snapshotView)
        self.snapshotView = snapshotView
    } else {
      self.snapshotView?.removeFromSuperview()
      self.snapshotView = nil
    }
  }
}

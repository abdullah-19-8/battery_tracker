import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "battery",
                                              binaryMessenger: controller.binaryMessenger)
    
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "getBatteryLevel" {
        result(self.getBatteryLevel())
      } else if call.method == "getChargingStatus" {
        result(self.getChargingStatus())
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getBatteryLevel() -> Int {
    UIDevice.current.isBatteryMonitoringEnabled = true
    return Int(UIDevice.current.batteryLevel * 100)
  }

  private func getChargingStatus() -> String {
    let state = UIDevice.current.batteryState
    return if state == .charging {
      "Charging"
    } else if state == .full {
      "Full"
    } else if state == .unplugged {
      "Unplugged"
    } else {
      "Unknown"
    }
  }
}

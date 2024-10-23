package com.example.battery_tracker

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel



class MainActivity: FlutterActivity() {
    private val CHANNEL = "battery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }
                }
                "getChargingStatus" -> {
                    val chargingStatus = getChargingStatus()
                    result.success(chargingStatus)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            -1
        }
    }

    private fun getChargingStatus(): String {
        val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        val batteryStatus = registerReceiver(null, intentFilter)
        val status = batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        print(status)
        return if (status == BatteryManager.BATTERY_STATUS_CHARGING) {
            "Charging"
        } else if(status == BatteryManager.BATTERY_STATUS_NOT_CHARGING) {
            "Not charging"
        } else if(status == BatteryManager.BATTERY_STATUS_DISCHARGING) {
            "Discharging"
        } else if(status == BatteryManager.BATTERY_STATUS_FULL) {
            "Full"
        } else {
            "UnKnown"
        }
    }
}

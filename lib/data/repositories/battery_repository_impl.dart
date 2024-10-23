import 'package:flutter/services.dart';
import '../../domain/repositories/battery_repository.dart';

class BatteryRepositoryImpl implements BatteryRepository {
  static const platform = MethodChannel('battery');

  @override
  Future<int> getBatteryLevel() async {
    try {
      final int batteryLevel = await platform.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } catch (e) {
      throw Exception('Failed to get battery level');
    }
  }

  @override
  Future<String> getChargingStatus() async {
    try {
      final String chargingStatus =
          await platform.invokeMethod('getChargingStatus');
      return chargingStatus;
    } catch (e) {
      throw Exception('Failed to get charging status');
    }
  }
}
abstract class BatteryRepository {
  Future<int> getBatteryLevel();
  Future<String> getChargingStatus();
}
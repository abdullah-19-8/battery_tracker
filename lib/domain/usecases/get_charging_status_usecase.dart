import '../repositories/battery_repository.dart';

class GetChargingStatusUseCase {
  final BatteryRepository repository;

  GetChargingStatusUseCase(this.repository);

  Future<String> call() async {
    return await repository.getChargingStatus();
  }
}
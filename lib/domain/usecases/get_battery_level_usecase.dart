import '../repositories/battery_repository.dart';

class GetBatteryLevelUseCase {
  final BatteryRepository repository;

  GetBatteryLevelUseCase(this.repository);

  Future<int> call() async {
    return await repository.getBatteryLevel();
  }
}
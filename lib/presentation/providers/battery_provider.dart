import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/battery_repository_impl.dart';
import '../../domain/repositories/battery_repository.dart';
import '../../domain/usecases/get_battery_level_usecase.dart';
import '../../domain/usecases/get_charging_status_usecase.dart';

class BatteryState {
  final String batteryLevel;
  final String chargingStatus;
  final String errorMessage;

  BatteryState({
    required this.batteryLevel,
    required this.chargingStatus,
    required this.errorMessage,
  });

  factory BatteryState.initial() {
    return BatteryState(
      batteryLevel: 'Unknown',
      chargingStatus: 'Unknown',
      errorMessage: '',
    );
  }
}

class BatteryNotifier extends StateNotifier<BatteryState> {
  final GetBatteryLevelUseCase getBatteryLevelUseCase;
  final GetChargingStatusUseCase getChargingStatusUseCase;

  BatteryNotifier(
    this.getBatteryLevelUseCase,
    this.getChargingStatusUseCase,
  ) : super(BatteryState.initial());

  Future<void> refreshBatteryInfo() async {
    try {
      final batteryLevel = await getBatteryLevelUseCase();
      final chargingStatus = await getChargingStatusUseCase();
      state = BatteryState(
        batteryLevel: '$batteryLevel%',
        chargingStatus: chargingStatus,
        errorMessage: '',
      );
    } catch (e) {
      state = BatteryState(
        batteryLevel: 'Failed to get battery level',
        chargingStatus: 'Failed to get charging status',
        errorMessage: e.toString(),
      );
    }
  }
}

final batteryProvider = StateNotifierProvider<BatteryNotifier, BatteryState>(
  (ref) {
    final batteryRepository = ref.watch(batteryRepositoryProvider);
    return BatteryNotifier(
      GetBatteryLevelUseCase(batteryRepository),
      GetChargingStatusUseCase(batteryRepository),
    );
  },
);

// Registering the battery repository in the provider.
final batteryRepositoryProvider = Provider<BatteryRepository>(
  (ref) => BatteryRepositoryImpl(),
);

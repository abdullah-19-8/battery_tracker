import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/battery_provider.dart';

class BatteryPage extends ConsumerWidget {
  const BatteryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryState = ref.watch(batteryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Battery Level: ${batteryState.batteryLevel}'),
            Text('Charging Status: ${batteryState.chargingStatus}'),
            if (batteryState.errorMessage.isNotEmpty)
              Text(
                'Error: ${batteryState.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(batteryProvider.notifier).refreshBatteryInfo();
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

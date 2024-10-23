import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/battery_provider.dart';

class BatteryPage extends ConsumerStatefulWidget {
  const BatteryPage({super.key});

  @override
  ConsumerState<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends ConsumerState<BatteryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final batteryState = ref.watch(batteryProvider);

    // Trigger animation when battery info is updated
    if (batteryState.batteryLevel != 'Unknown') {
      _controller.forward();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Tracker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Animated display for Battery Level and Charging Status
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    // Battery level with icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.battery_full,
                            size: 30, color: Colors.green),
                        const SizedBox(width: 10),
                        Text(
                          'Battery Level: ${batteryState.batteryLevel}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Charging status with icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          batteryState.chargingStatus == 'Charging'
                              ? Icons.power
                              : Icons.power_off,
                          size: 30,
                          color: batteryState.chargingStatus == 'Charging'
                              ? Colors.blue
                              : Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Charging Status: ${batteryState.chargingStatus}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Animated button for fetching and refreshing data
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: ElevatedButton(
                  key: ValueKey(batteryState.batteryLevel),
                  onPressed: () {
                    ref.read(batteryProvider.notifier).refreshBatteryInfo();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    (batteryState.batteryLevel == 'Unknown' &&
                            batteryState.chargingStatus == 'Unknown')
                        ? 'Get Battery Info'
                        : 'Refresh',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              // Error message display, if any error occurs
              if (batteryState.errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Error: ${batteryState.errorMessage}',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

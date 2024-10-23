import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _batteryLevel = 'Unknown';
  String _chargingStatus = 'Unknown';

  static const platform = MethodChannel('battery');

  Future<void> _refreshBatteryInfo() async {
    try {
      final int batteryLevel = await platform.invokeMethod('getBatteryLevel');
      final String chargingStatus =
          await platform.invokeMethod('getChargingStatus');
      setState(() {
        _batteryLevel = '$batteryLevel%';
        _chargingStatus = chargingStatus;
      });
    } catch (e) {
      setState(() {
        _batteryLevel = 'Failed to get battery level';
        _chargingStatus = 'Failed to get charging status';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Battery Level: $_batteryLevel'),
            Text('Charging Status: $_chargingStatus'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _refreshBatteryInfo,
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

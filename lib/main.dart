import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubb/screens/screens.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UBBMaps',
      home: const MainScreen(),
      routes: {
        'home_screen': (_) => const HomeScreen(),
        'map_screen': (_) => const MapScreen(),
        'settings_screen': (_) => const SettingsScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          //Background
          Background(),
          HeaderWave(),
          HeaderWave2(),
        ],
      ),
    );
  }
}

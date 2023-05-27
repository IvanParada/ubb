import 'package:flutter/material.dart';
import 'package:ubb/screens/screens.dart';
import '../widgets/widgets.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          //Background
          Background(),
          HeaderWave(),
          HeaderWave2(),
          GpsAccessScreen(),
          Text('MapScreen')
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../ui/ui.dart';
import '../widgets/widgets.dart';

class MapsOptionsScreen extends StatelessWidget {
  const MapsOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE0E0E0),
      width: double.infinity,
      height: double.infinity,
      child: const Stack(
        children: [
          HeaderCurvo(),
          Positioned(top: 200, left: 300, child: Bubble()),
          Positioned(top: -40, left: -30, child: Bubble()),
          Positioned(top: -50, right: -20, child: Bubble()),
          MapsOptions(),
        ],
      ),
    );
  }
}


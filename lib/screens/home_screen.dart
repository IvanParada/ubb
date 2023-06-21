import 'package:flutter/material.dart';
import 'package:ubb/widgets/widgets.dart';

import '../ui/ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const HeaderCurvo(),
          const Positioned(top: 200, left: 300, child: Bubble()),
          const Positioned(top: -40, left: -30, child: Bubble()),
          const Positioned(top: -50, right: -20, child: Bubble()),
          _HomeBody(),
        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ///Titulos
          PageTitle(),
        ],
      ),
    );
  }
}

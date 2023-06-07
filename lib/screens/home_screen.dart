import 'package:flutter/material.dart';
import 'package:ubb/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
          const Background(),
          const HeaderWave(),
          const HeaderWave2(),
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

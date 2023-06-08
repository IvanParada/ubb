import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ui/ui.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(size: size),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30, left: (size.width * 0.5) - 45),
        child: FadeInDown(
          child: const FaIcon(
            FontAwesomeIcons.userGraduate,
            color: Colors.white,
            size: 100,
          ),
        ),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: const Stack(
        children: [
          Positioned(top: 90, left: 30, child: Bubble()),
          Positioned(top: -40, left: -30, child: Bubble()),
          Positioned(top: -50, right: -20, child: Bubble()),
          Positioned(bottom: -50, left: 10, child: Bubble()),
          Positioned(bottom: 120, right: 30, child: Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 9, 27, 43),
        Color.fromARGB(255, 9, 27, 43),
      ]));
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            FadeInDown(
              child: const Text(
                '¡Bienvenid@!',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            FadeInLeft(
              child: const Text(
                'Explora nuestro campus con el mapa interactivo.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            FadeInUp(
              child: Image.asset(
                'assets/logo.png',
                height: 70,
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

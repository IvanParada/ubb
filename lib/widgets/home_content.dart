import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {

  const PageTitle({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            FadeInDown(
              child: const Center(
                child: Text(
                  '¡Bienvenid@!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeInLeft(
              child: const Center(
                child: Text(
                  'Explora nuestro campus con el mapa interactivo.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: FadeInUp(
                child: Image.asset(
                  'assets/logo.png',
                  height: 100,
                  width: 190,
                ),
              ),
            ),
            const SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }
}

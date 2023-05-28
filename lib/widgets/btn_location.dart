import 'package:flutter/material.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 8, 86, 100),
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location, color: Colors.white),
          onPressed: () {},
        ),
      ),
    );
  }
}

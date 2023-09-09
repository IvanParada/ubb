import 'package:flutter/material.dart';

import '../screens/screens.dart';

class BtnBack extends StatelessWidget {
  const BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 30,
      backgroundColor: const Color.fromARGB(255, 9, 27, 43),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MapsOptionsScreen(), 
            ),
          );
        },
      ),
    );
  }
}

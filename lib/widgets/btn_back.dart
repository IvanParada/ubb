import 'package:flutter/material.dart';


class BtnBack extends StatelessWidget {
  const BtnBack({
    super.key,
  });

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
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

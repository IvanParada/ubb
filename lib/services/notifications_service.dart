import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 9, 27, 43),
      elevation: 4,
        content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BounceInDown(
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color.fromARGB(255, 9, 27, 43),
          title: const Text(
            'Espere porfavor...',
            style: TextStyle(color: Colors.white),
          ),
          content: Container(
            width: 100,
            height: 80,
            margin: const EdgeInsets.only(top: 10),
            child: const Column(
              children: [
                Text(
                  'Calculando ruta...',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15),
                CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
    return;
  }

  showCupertinoDialog(
    context: context,
    builder: (context) => const CupertinoAlertDialog(
      title: Text('Espere porfavor...'),
      content: CupertinoActivityIndicator(),
    ),
  );
}

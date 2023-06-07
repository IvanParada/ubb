
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }){
    return  InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 9, 27, 43),
                  )
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 9, 27, 43),
                    width: 2
                  )
                ),
                hintText: hintText,
                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Colors.grey
                ),
                prefixIcon: prefixIcon != null
                  ? FaIcon(prefixIcon, color: const Color.fromARGB(255, 9, 27, 43),)
                  : null
                );
    
  }

}
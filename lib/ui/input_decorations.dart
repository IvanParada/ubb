
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
                    color: Colors.deepPurple
                  )
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2
                  )
                ),
                hintText: hintText,
                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Colors.grey
                ),
                prefixIcon: prefixIcon != null
                  ? FaIcon(prefixIcon, color: Colors.deepPurple)
                  : null
                );
    
  }

}
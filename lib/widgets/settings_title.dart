import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({super.key});


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            FadeInDown(
              child:  const Center(
                child: FaIcon(FontAwesomeIcons.userGear, color: Colors.white, size: 80,)
              ),
            ),
            const SizedBox(height: 20),
            // const Center(child: Text('Ajustes', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),)),
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0,5)
                        )
                      ]
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              child: Center(
                child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                disabledColor: Colors.grey,
                elevation: 0,
                color: const Color.fromARGB(255, 9, 27, 43),
                onPressed: () {
                  authService.logout();
                   Navigator.pushReplacementNamed(context, 'login_screen');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: const Row(
                          mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Cerrar sesión', style: TextStyle(color: Colors.white),),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: FaIcon(FontAwesomeIcons.rightFromBracket, color: Colors.white),
                    ),
                  ],
                  )
                )),
              ),
            )
                      ],
        ),
      ),
    );
  }
}

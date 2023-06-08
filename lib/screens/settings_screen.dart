import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubb/services/auth_service.dart';
import '../ui/ui.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

     return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const HeaderCurvo(),
          const Positioned(top: 200, left:300, child: Bubble()),
          const Positioned(top: -40, left:-30, child: Bubble()),
          const Positioned(top: -50, right:-20, child: Bubble()),
          Positioned(
            top: 40,
            right: 30,
            child: SafeArea(
              child: IconButton(onPressed: () {
                 authService.logout();
                 Navigator.pushReplacementNamed(context, 'login_screen');
              }, icon: const FaIcon(FontAwesomeIcons.rightFromBracket, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}

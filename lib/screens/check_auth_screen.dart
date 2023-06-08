import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubb/screens/screens.dart';
import 'package:ubb/services/auth_service.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Espere');
            }

            if (snapshot.data == '') {
              Future.microtask(() => {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const LoginScreen(),
                            transitionDuration: const Duration(seconds: 0)))
                  });
            } else {
              Future.microtask(() => {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const MainScreen(),
                            transitionDuration: const Duration(seconds: 0)))
                  });
            }

            return Container();
          },
        ),
      ),
    );
  }
}

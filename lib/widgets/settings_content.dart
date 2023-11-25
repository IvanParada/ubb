import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import '../services/services.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                FadeInDown(
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.userGear,
                    color: Colors.white,
                    size: 80,
                  )),
                ),
                const SizedBox(height: 50),
                FadeInLeft(
                  child: const Center(
                    child: Text(
                      'Datos del usuario.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Center(
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.userGraduate),
                              title: const Text(
                                'Nombre usuario',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: FutureBuilder<Map<String, dynamic>?>(
                                future: AuthService().getUserData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Error al obtener los datos del usuario');
                                  } else {
                                    final userData = snapshot.data;
                                    final displayName =
                                        userData?['displayName'] ?? '';
                                    return Text(displayName);
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.solidEnvelope),
                              title: const Text(
                                'Correo electrónico',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: FutureBuilder<Map<String, dynamic>?>(
                                future: AuthService().getUserData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Error al obtener los datos del usuario');
                                  } else {
                                    final userData = snapshot.data;
                                    final email = userData?['email'] ?? '';
                                    return Text(email);
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.calendarMinus),
                              title: const Text(
                                'Fecha de registro',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: FutureBuilder<Map<String, dynamic>?>(
                                future: AuthService().getUserData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Error al obtener los datos del usuario');
                                  } else {
                                    final userData = snapshot.data;
                                    final createdAt =
                                        userData?['createdAt'] as String?;
                                    final formattedDate = createdAt != null
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(createdAt)))
                                        : '';
      
                                    return Text(formattedDate);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeInUp(
                  child: Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: const Color.fromARGB(255, 58, 4, 4),
                      onPressed: () {
                        authService.logout();
                        Navigator.pushReplacementNamed(context, 'login_screen');
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cerrar sesión',
                                style: TextStyle(color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: FaIcon(FontAwesomeIcons.rightFromBracket,
                                    color: Colors.white, size: 16),
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

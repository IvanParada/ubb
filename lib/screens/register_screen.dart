import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubb/providers/providers.dart';
import 'package:ubb/ui/input_decorations.dart';
import 'package:ubb/widgets/widgets.dart';
import 'package:ubb/ui/ui.dart';

import '../services/services.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Registrar',
                  style: TextStyle(
                      color: Color.fromARGB(255, 9, 27, 43),
                      fontSize: 35,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child: _RegisterForm(),
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'login_screen'),
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 9, 27, 43).withOpacity(0.1)),
                shape: MaterialStateProperty.all(const StadiumBorder())),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 9, 27, 43).withOpacity(0.8),
                ),
                children: const [
                  TextSpan(
                    text: '¿Ya tienes cuenta? ',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: 'Inicia sesión',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(
        context); //se obtiene el acceso a todo el LoginFormProvider

    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: FadeIn(
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre',
                labelText: 'Nombre',
                prefixIcon: FontAwesomeIcons.userLarge,
              ),
              onChanged: (value) => registerForm.nombre = value,
              validator: (value) {
                // Verificar si el campo está vacío
                if (value == null || value.isEmpty) {
                  return 'Debes rellenar el campo de texto';
                }

                // Verificar si la longitud está entre 2 y 30 caracteres
                if (value.length < 2 || value.length > 30) {
                  return 'El nombre debe contener entre 2 a 30 caracteres';
                }

                // Verificar si hay caracteres no válidos
                RegExp nombreUsuario = RegExp(r'^[a-zA-Zá-úÁ-ÚüÜñÑ\s]{2,30}$');
                if (!nombreUsuario.hasMatch(value)) {
                  return 'Has ingresado un carácter no válido';
                }

                // Si pasa todas las validaciones, retorna null
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Apellido',
                labelText: 'Apellido',
                prefixIcon: FontAwesomeIcons.idCard,
              ),
              onChanged: (value) => registerForm.apellido = value,
              validator: (value) {
                // Verificar si el campo está vacío
                if (value == null || value.isEmpty) {
                  return 'Debes rellenar el campo de texto';
                }

                // Verificar si la longitud está entre 2 y 30 caracteres
                if (value.length < 2 || value.length > 30) {
                  return 'El apellido debe contener entre 2 a 30 caracteres';
                }

                // Verificar si hay caracteres no válidos
                RegExp apellidoUsuario =
                    RegExp(r'^[a-zA-Zá-úÁ-ÚüÜñÑ\s]{2,30}$');
                if (!apellidoUsuario.hasMatch(value)) {
                  return 'Has ingresado un carácter no válido';
                }

                // Si pasa todas las validaciones, retorna null
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'nombre.apellido0000@alumnos.ubiobio.cl',
                labelText: 'Correo electrónico',
                prefixIcon: FontAwesomeIcons.at,
              ),
              onChanged: (value) => registerForm.email = value,
              validator: (value) {
                // Verificar si el campo está vacío
                if (value == null || value.isEmpty) {
                  return 'Debes rellenar el campo de texto';
                }

                // Verificar si la longitud está entre 14 y 100 caracteres
                if (value.length < 14 || value.length > 100) {
                  return 'El correo debe tener entre 14 y 100 caracteres';
                }

                // Verificar si el correo tiene el formato correcto
                RegExp emailUsuario =
                    RegExp(r'^[a-z0-9.]+@(alumnos\.ubiobio\.cl|ubiobio\.cl)$');
                if (!emailUsuario.hasMatch(value)) {
                  return 'El correo no es válido';
                }

                // Si pasa todas las validaciones, retorna null
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: FontAwesomeIcons.lock,
              ),
              onChanged: (value) => registerForm.password = value,
              validator: (value) {
                // Verificar si el campo está vacío
                if (value == null || value.isEmpty) {
                  return 'Debes rellenar el campo de texto';
                }

                // Verificar la longitud de la contraseña
                if (value.length < 6) {
                  return 'La contraseña debe contener al menos 6 caracteres';
                }

                // Verificar si la contraseña contiene al menos una letra mayúscula y una minúscula
                bool hasUppercase = false;
                bool hasLowercase = false;

                for (int i = 0; i < value.length; i++) {
                  if (value[i].toUpperCase() == value[i]) {
                    hasUppercase = true;
                  } else if (value[i].toLowerCase() == value[i]) {
                    hasLowercase = true;
                  }

                  if (hasUppercase && hasLowercase) {
                    return null;
                  }
                }

                // Si no cumple con las condiciones anteriores, mostrar mensaje de error
                return 'La contraseña debe contener al menos una letra mayúscula y una minúscula';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: const Color.fromARGB(255, 9, 27, 43),
                onPressed: registerForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!registerForm.isValidForm()) return;

                        registerForm.isLoading = true;

                        final String? errorMessage =
                            await authService.createUser(
                                registerForm.nombre,
                                registerForm.apellido,
                                registerForm.email,
                                registerForm.password);
                        if (errorMessage == null) {
                          NotificationsService.showSnackbar(
                              'Se ha enviado un correo para activar tu cuenta. Por favor, verifica tu bandeja de entrada');
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, 'login_screen');
                        } else {
                          NotificationsService.showSnackbar(
                              'Ya existe una cuenta registrada con este correo electronico.');
                          registerForm.isLoading = false;
                        }
                      },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        registerForm.isLoading ? 'Espere...' : 'Registrar',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: FaIcon(
                          FontAwesomeIcons.userAstronaut,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

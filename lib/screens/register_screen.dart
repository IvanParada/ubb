import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubb/providers/providers.dart';
import 'package:ubb/services/auth_service.dart';
import 'package:ubb/ui/input_decorations.dart';
import 'package:ubb/widgets/widgets.dart';
import 'package:ubb/ui/ui.dart';

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
                  prefixIcon: FontAwesomeIcons.userLarge),
              onChanged: (value) => registerForm.nombre = value,
              validator: (value) {
                RegExp nombreRegExp = RegExp(r'^[a-zA-Zá-úÁ-ÚüÜñÑ\s]{3,}$');

                return nombreRegExp.hasMatch(value ?? '')
                    ? null
                    : 'El nombre no es válido';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Apellido ',
                  labelText: 'Apellido',
                  prefixIcon: FontAwesomeIcons.idCard),
              onChanged: (value) => registerForm.apellido = value,
              validator: (value) {
                RegExp nombreRegExp = RegExp(r'^[a-zA-Zá-úÁ-ÚüÜñÑ\s]{3,}$');

                return nombreRegExp.hasMatch(value ?? '')
                    ? null
                    : 'El apellido no es válido';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'nombre.apellido0000@alumnos.ubiobio.cl',
                  labelText: 'Correo electronico',
                  prefixIcon: FontAwesomeIcons.at),
              onChanged: (value) => registerForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(alumnos\.ubiobio\.cl|ubiobio\.cl)$';

                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es válido';
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
                if (value == null) {
                  return 'Contraseña requerida';
                }

                if (value.length < 6) {
                  return 'La contraseña debe contener al menos 6 caracteres';
                }

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
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, 'login_screen');
                        } else {
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

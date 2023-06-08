import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubb/providers/login_form_provider.dart';
import 'package:ubb/ui/input_decorations.dart';
import 'package:ubb/widgets/widgets.dart';
import 'package:ubb/ui/ui.dart';

import '../services/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                      'Iniciar Sesión',
                        style: TextStyle(
                          color:Color.fromARGB(255, 9, 27, 43),
                          fontSize: 35,
                          fontWeight: FontWeight.w500
                            ),
                          ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_ ) => LoginFormProvider(),
                      child: _LoginForm(),
                       )
                    
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: 
                () => Navigator.pushReplacementNamed(context,'register_screen'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(const Color.fromARGB(255, 9, 27, 43).withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 9, 27, 43).withOpacity(0.8),
                  ),
                  children: const [
                    TextSpan(
                      text: '¿No tienes cuenta? ',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Regístrate',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
      )
    );
  }
}


class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm  =  Provider.of<LoginFormProvider>(context); //se obtiene el acceso a todo el LoginFormProvider


    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: FadeIn(
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'nombre.apellido0000@alumnos.ubiobio.cl',
                labelText: 'Correo electronico',
                prefixIcon: FontAwesomeIcons.at
              ),
              onChanged: (value) => loginForm.email = value,
              validator: ( value ){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@alumnos\.ubiobio\.cl$';
                RegExp regExp  = RegExp(pattern);
      
                return regExp.hasMatch(value ?? '')
                  ? null
                  :'El correo no es válido';
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
                prefixIcon: FontAwesomeIcons.lock
              ),
              onChanged: (value) => loginForm.password = value,
      
              validator: ( value ){
      
                return (value != null && value.length >= 6)
                ? null
                : 'Contraseña incorrecta';
              },
            ),
      
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromARGB(255, 9, 27, 43),
              onPressed: loginForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                if(!loginForm.isValidForm()) return;
                
                loginForm.isLoading = true;
            
                final String? errorMessage = await authService.login(loginForm.email, loginForm.password);
                if(errorMessage == null){
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'home_screen');
                  
                }else{
                loginForm.isLoading = false;
                }
            
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                    loginForm.isLoading ? 'Espere...' : 'Ingresar',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: FaIcon(FontAwesomeIcons.rocket, color: Colors.white, size: 16),
                  ),
                ],
                )
              ),
              )
          ],
        ),
      ),
    );
  }
}
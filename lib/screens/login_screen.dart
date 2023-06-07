import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubb/providers/login_form_provider.dart';
import 'package:ubb/ui/input_decorations.dart';
import 'package:ubb/widgets/widgets.dart';
import 'package:ubb/ui/ui.dart';

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
                    Text('Login', style: Theme.of(context).textTheme.headlineLarge,),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_ ) => LoginFormProvider(),
                      child: _LoginForm(),
                       )
                    
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
            color: Colors.deepPurple,
            onPressed: loginForm.isLoading ? null : () async {
              FocusScope.of(context).unfocus();
              if(!loginForm.isValidForm()) return;
              
              loginForm.isLoading = true;

              await Future.delayed(const Duration(seconds: 2));

              loginForm.isLoading = false;


              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, 'home_screen');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading
                ? 'Espere...'
                : 'Ingresar',
               style: const TextStyle(color: Colors.white),)
            ))
        ],
      ),
    );
  }
}
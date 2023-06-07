import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/bloc.dart';
import '../ui/ui.dart';
import '../widgets/widgets.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccessButton();
        },
      )
          //  _AccessButton(),
          //  child: _EnableGpsMessage()
          ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {

  return Stack(
    children: [
         const HeaderCurvo(),
         const Positioned(top: 200, left:300, child: Bubble()),
         const Positioned(top: -40, left:-30, child: Bubble()),
         const Positioned(top: -50, right:-20, child: Bubble()),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: const Text(
                'Es necesario el acceso a GPS',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20), // Espacio vertical entre el texto y el botón
            Align(
              alignment: Alignment.bottomCenter,
              child: FadeInUp(
                child: MaterialButton(
                  color:const Color.fromARGB(255, 9, 27, 43),
                  shape: const StadiumBorder(),
                  elevation: 0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    final gpsBloc = BlocProvider.of<GpsBloc>(context);
                    gpsBloc.askGpsAccess();
                  },
                  child:  Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              
                    child: const Text(
                      'Solicitar Acceso',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size  = MediaQuery.of(context).size;

    return Stack(
      children: [
          const HeaderCurvo(),
          const Positioned(top: 200, left:300, child: Bubble()),
          const Positioned(top: -40, left:-30, child: Bubble()),
          const Positioned(top: -50, right:-20, child: Bubble()),

        Center(
          child: FadeInDown(
            child:const Text(
              'Debe habilitar el GPS',
              style: TextStyle(color: Colors.black,fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
            height: size.height * 1.05,
            width: size.width , // Ajusta esta posición según tus necesidades
            child: FadeInUp(
              child: const Center(
                child: FaIcon(FontAwesomeIcons.locationDot, color: Colors.black,size: 50),
              ),
            ),
          ),
      ],
    );
  }
}

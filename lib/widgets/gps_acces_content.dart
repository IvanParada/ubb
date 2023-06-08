import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/bloc.dart';

class GpsAccesTitle extends StatelessWidget {
  const GpsAccesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            FadeInDown(
              child: const Center(
                  child: FaIcon(
                FontAwesomeIcons.mapLocationDot,
                color: Colors.white,
                size: 80,
              )),
            ),
            const SizedBox(height: 20),
            // const Center(child: Text('Ajustes', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),)),
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.5,
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
                child: Center(
                  child: FadeInDown(
                    child: const Text(
                      'Es necesario el acceso a GPS',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              child: Center(
                child: MaterialButton(
                  color: const Color.fromARGB(255, 9, 27, 43),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    final gpsBloc = BlocProvider.of<GpsBloc>(context);
                    gpsBloc.askGpsAccess();
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Solicitar acceso',
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: FaIcon(FontAwesomeIcons.locationDot,
                                color: Colors.white, size: 16),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GpsDisabled extends StatelessWidget {
  const GpsDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            FadeInDown(
              child: const Center(
                  child: FaIcon(
                FontAwesomeIcons.mapLocationDot,
                color: Colors.white,
                size: 80,
              )),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.5,
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
                child: const Center(
                  child: Text(
                    'Debe habilitar el GPS',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



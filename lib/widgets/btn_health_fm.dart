import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/bloc.dart';

class BtnToggleMarkerFM extends StatelessWidget {
  const BtnToggleMarkerFM({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBlocFM = BlocProvider.of<MapBlocFM>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 9, 27, 43),
        maxRadius: 25,
        child: BlocBuilder<MapBlocFM, MapStateFM>(
          builder: (context, state) {
            return IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.kitMedical,
                color: Colors.white,
              ),
              onPressed: () {
                mapBlocFM.add(ToggleMedicalMarkersVisibilityEventFM());
              },
            );
          },
        ),
      ),
    );
  }
}

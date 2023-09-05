import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../blocs/bloc.dart';

class BtnToggleMarker extends StatelessWidget {
  const BtnToggleMarker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 9, 27, 43),
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.kitMedical,
                color: Colors.white,
              ),
              onPressed: () {
                mapBloc.add(ToggleMedicalMarkersVisibilityEvent());
              },
            );
          },
        ),
      ),
    );
  }
}

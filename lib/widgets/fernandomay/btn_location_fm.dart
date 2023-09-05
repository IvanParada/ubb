import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubb/blocs/bloc.dart';

class BtnCurrentLocationFM extends StatelessWidget {
  const BtnCurrentLocationFM({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBlocFM = BlocProvider.of<LocationBloc>(context);
    final mapBlocFM = BlocProvider.of<MapBlocFM>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 9, 27, 43),
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location, color: Colors.white),
          onPressed: () {
            final userLocation = locationBlocFM.state.lastKnowLocation;
            if (userLocation == null) return;
            mapBlocFM.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}

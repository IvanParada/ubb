import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubb/blocs/bloc.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 9, 27, 43),
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location, color: Colors.white),
          onPressed: () {
            final userLocation = locationBloc.state.lastKnowLocation;
            if (userLocation == null) return;
            mapBloc.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}

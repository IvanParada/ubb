import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../blocs/bloc.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    const CameraPosition initialCameraPosition = CameraPosition(
        target: LatLng(-36.8220178016745, -73.0129262889358), zoom: 18);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        compassEnabled: false,
        zoomControlsEnabled: false,
        // mapType: MapType.hybrid,
        onMapCreated: (controller) =>
            mapBloc.add(OnMapInitializedEvent(controller)),
      ),
    );
  }
}

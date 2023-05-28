import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../blocs/bloc.dart';

class MapView extends StatelessWidget {
  final Set<Polyline> polylines;

  const MapView({
    super.key,
    required this.polylines,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    const CameraPosition initialCameraPosition = CameraPosition(
        target: LatLng(-36.8220178016745, -73.0129262889358), zoom: 18);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (PointerMoveEvent) =>
            mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          polylines: polylines,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),
        ),
      ),
    );
  }
}

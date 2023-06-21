import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/bloc.dart';

class MapView extends StatelessWidget {
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const MapView({
    super.key,
    required this.polylines,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    const CameraPosition initialCameraPosition = CameraPosition(
        target: LatLng(-36.8220178016745, -73.0129262889358), zoom: 18);


    CameraTargetBounds cameraTargetBounds = CameraTargetBounds(
      LatLngBounds(
        southwest: const LatLng(-36.825952992476,
            -73.01679473201108), // Punto suroeste del área visible
        northeast: const LatLng(-36.82006998398947,
            -73.00732116939754), // Punto noreste del área visible
      ),
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (_) => mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          cameraTargetBounds: cameraTargetBounds,
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          polylines: polylines,
          zoomGesturesEnabled: true,
          minMaxZoomPreference: const MinMaxZoomPreference(16.0, 20.0),
          markers: markers,
          rotateGesturesEnabled: true,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
          
        ),
      ),
    );
  }
}

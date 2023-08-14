import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:ubb/helpers/helpers.dart';


import '../blocs/bloc.dart';

class MapView extends StatefulWidget {
  final Set<Polyline> polylines;
  final Set<Marker> markers;
  // final ValueNotifier<bool> markersVisible;

  const MapView({
    Key? key,
    required this.polylines,
    required this.markers,
    // required this.markersVisible,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  // Future<void> _initializeMarkers() async {
  //   final BitmapDescriptor customMarkerIcon = await getAssetImageMarker();

  //   final List<LatLng> coordinates = [
  //     const LatLng(-36.82167822894567, -73.01111290908632),
  //     const LatLng(-36.82309990910144, -73.01051877590834),
  //   ];

  //   for (int i = 0; i < coordinates.length; i++) {
  //     final LatLng coordinate = coordinates[i];

  //     widget.markers.add(
  //       Marker(
  //         markerId: MarkerId('Desfibrilador_$i'), // Cambia el ID del marcador
  //         position: coordinate,
  //         icon: customMarkerIcon,
  //         onTap: () {},
  //         infoWindow: const InfoWindow(title: 'Desfibrilador', snippet: ''),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(-36.8220178016745, -73.0129262889358),
      zoom: 18,
    );

    CameraTargetBounds cameraTargetBounds = CameraTargetBounds(
      LatLngBounds(
        southwest: const LatLng(-36.825952992476, -73.01679473201108),
        northeast: const LatLng(-36.82006998398947, -73.00732116939754),
      ),
    );

    final size = MediaQuery.of(context).size;

    // _initializeMarkers(); 

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
          polylines: widget.polylines,
          zoomGesturesEnabled: true,
          minMaxZoomPreference: const MinMaxZoomPreference(17.0, 20.0),
          markers:  widget.markers,
          rotateGesturesEnabled: true,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
        ),
      ),
    );
  }
}

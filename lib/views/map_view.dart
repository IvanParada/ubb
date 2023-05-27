import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    const CameraPosition initialCameraPosition = CameraPosition(
        target: LatLng(-36.8220178016745, -73.0129262889358), zoom: 18);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: const GoogleMap(
        initialCameraPosition: initialCameraPosition,
        compassEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
      ),
    );
  }
}

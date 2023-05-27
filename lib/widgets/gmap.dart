import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MapPage());

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(-36.82192, -73.01320),
    zoom: 18,
  );

  final LatLng initialPosition = const LatLng(-36.82192, -73.01320); //UBB
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {},
        initialCameraPosition: _initialCameraPosition,
        scrollGesturesEnabled: true,
        mapType: MapType.hybrid,
        compassEnabled: true,
      ),
    );
  }
}

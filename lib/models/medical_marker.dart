import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalMarker {
  LatLng position;
  String title;
  String description;

  MedicalMarker({
    required this.position,
    required this.title,
    required this.description,
  });
}



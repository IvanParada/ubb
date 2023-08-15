import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalMarker {
  final LatLng position;
  final String title;
  final String description;

  MedicalMarker({
    required this.position,
    required this.title,
    required this.description,
  });
}

final List<MedicalMarker> predefinedMedicalMarkers = [
  MedicalMarker(
    position: const LatLng(-36.82168314282541, -73.01110765342172),
    title: 'MedicalKit FACE',
    description: 'Descripción del MedicalKit FACE',
  ),
  MedicalMarker(
    position: const LatLng(-36.823208246494346, -73.01061690688198),
    title: 'MedicalKit CASINO',
    description: 'Descripción del MedicalKit CASINO',
  ),
];

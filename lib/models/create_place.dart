import 'package:ubb/models/places_model.dart';

Feature createCustomPlace(
  String id,
  String name,
  String secondaryText,
  List<double> coordinates,
) {
  return Feature(
    id: id,
    placeType: ['building'],
    text: name,
    placeName: secondaryText,
    center: coordinates,
  );
}

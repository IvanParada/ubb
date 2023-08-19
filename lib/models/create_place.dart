import 'package:ubb/models/places_model.dart';

Feature createCustomPlace(
  String id,
  String name,
  String placeName,
  List<double> coordinates,
) {
  return Feature(
    id: id,
    type: 'Feature',
    placeType: ['building'],
    properties: Properties(
      address: '',
      category: '',
      foursquare: '',
      landmark: null,
      maki: '',
      wikidata: '',
    ),
    textEs: name,
    placeNameEs: placeName,
    text: name,
    language: null,
    placeName: placeName,
    matchingText: null,
    matchingPlaceName: null,
    center: coordinates,
    geometry: Geometry(
      type: 'Point',
      coordinates: coordinates,
    ),
    context: [],
  );
}

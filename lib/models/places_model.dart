import 'dart:convert';

class PlacesResponse {
  PlacesResponse({
    required this.type,
    required this.features,
    required this.attribution,
  });

  final String type;
  final List<Feature> features;
  final String attribution;

  factory PlacesResponse.fromJson(String str) =>
      PlacesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    // required this.type,
    required this.placeType,
    required this.text,
    required this.placeName,
    required this.center,
  });

  final String id;
  // final String type;
  final List<String> placeType;
  final String text;
  final String placeName;
  final List<double> center;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        // type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        // "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
      };

  @override
  String toString() {
    return 'Feature: $text';
  }
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}

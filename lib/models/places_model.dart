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

  factory PlacesResponse.fromMap(Map<String, dynamic> json) {
    return PlacesResponse(
      type: json["type"] ?? "", // Provide a default empty string if 'type' is null
      features: List<Feature>.from((json["features"] as List<dynamic>? ?? []).map((x) => Feature.fromMap(x))),
      attribution: json["attribution"] ?? "", // Provide a default empty string if 'attribution' is null
    );
  }

  Map<String, dynamic> toMap() => {
    "type": type,
    "features": List<dynamic>.from(features.map((x) => x.toMap())),
    "attribution": attribution,
  };
}

class Feature {
  Feature({
    required this.id,
    required this.placeType,
    required this.text,
    required this.placeName,
    required this.center,
  });

  final String id;
  final List<String> placeType;
  final String text;
  final String placeName;
  final List<double> center;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
    id: json["id"] ?? "", // Provide a default empty string if 'id' is null
    placeType: List<String>.from(json["place_type"]?.map((x) => x.toString()) ?? []),
    text: json["text"] ?? "", // Provide a default empty string if 'text' is null
    placeName: json["place_name"] ?? "", // Provide a default empty string if 'place_name' is null
    center: List<double>.from(json["center"]?.map((x) => x.toDouble()) ?? []),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
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

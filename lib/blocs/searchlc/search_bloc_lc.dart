import 'package:firebase_database/firebase_database.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:ubb/models/models.dart';
import 'package:ubb/services/services.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;

part 'search_event_lc.dart';
part 'search_state_lc.dart';

class SearchBlocLC extends Bloc<SearchEventLC, SearchStateLC> {
  TrafficService trafficService;

  SearchBlocLC({
    required this.trafficService,
  }) : super(const SearchStateLC()) {
    on<OnActivateManualMarkerEventLC>(
        (event, emit) => emit(state.copyWith(displayManualMarkerLC: true)));
    on<OnDeactivateManualMarkerEventLC>(
        (event, emit) => emit(state.copyWith(displayManualMarkerLC: false)));
    on<OnNewPlacesFoundEventLC>(
        (event, emit) => emit(state.copyWith(placesLC: event.placesLC)));
    on<AddToHistoryEventLC>((event, emit) =>
        emit(state.copyWith(historyLC: [event.placeLC, ...state.historyLC])));
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);

    final endPlace = await trafficService.getInformationByCoors(end);

    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    final points = decodePolyline(geometry, accuracyExponent: 6);
    final latLngList = points
        .map((coor) => LatLng(
              coor[0].toDouble(),
              coor[1].toDouble(),
            ))
        .toList();

    return RouteDestination(
      points: latLngList,
      duration: duration,
      distance: distance,
      endPlace: endPlace,
    );
  }

  // Future<List<Feature>> loadPlacesFromJsonLC() async {
  //   // Cambia la URL al enlace en línea.
  //   final response = await http.get(Uri.parse(
  //       'https://ubbmap-81adc-default-rtdb.firebaseio.com/registros_lc.json'));

  //   if (response.statusCode == 200) {
  //     // Decodifica la respuesta JSON.
  //     final jsonList = json.decode(response.body) as List;

  //     final places = jsonList.map((json) => Feature.fromMap(json)).toList();
  //     return places;
  //   } else {
  //     // Maneja el error de la solicitud HTTP aquí si es necesario.
  //     throw Exception('Error al cargar datos desde la URL');
  //   }
  // }


Future<List<Feature>> loadPlacesFromJsonLC() async {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference reference = database.ref().child('registros_lc');

  List<Feature> places = [];

  try {
    DataSnapshot snapshot = await reference.get();

    if (snapshot.value != null) {
      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          Feature place = Feature.fromMap(Map<String, dynamic>.from(value));
          places.add(place);
        });
      } else if (snapshot.value is List<dynamic>) {
        List<dynamic> values = snapshot.value as List<dynamic>;
        for (var value in values) {
          Feature place = Feature.fromMap(Map<String, dynamic>.from(value));
          places.add(place);
        }
      }
    }

    return places;
  } catch (error) {
    throw Exception('Error al cargar datos desde Firebase');
  }
}

  Future getPlacesByQuery(LatLng proximity, String query) async {
    final newPlaces = <Feature>[];

    final places = await loadPlacesFromJsonLC();

    final match = RegExp(r'\d+([a-zA-Z]+)').firstMatch(query);
    if (match != null) {
      final queryLetters = match.group(1)?.toLowerCase() ?? '';

      final filteredPlaces = places
          .where((place) => place.placeName.any((name) =>
              name.replaceAll(RegExp('[^a-zA-Z]+'), "").toLowerCase() ==
              queryLetters))
          .toList();

      newPlaces.addAll(filteredPlaces);
      add(OnNewPlacesFoundEventLC(filteredPlaces));
    } else {
      final filteredPlaces = places
          .where(
              (place) => place.text.toLowerCase().contains(query.toLowerCase()))
          .toList();

      newPlaces.addAll(filteredPlaces);
      add(OnNewPlacesFoundEventLC(filteredPlaces));
    }
  }
}

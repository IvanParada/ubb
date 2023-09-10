import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:ubb/models/models.dart';
import 'package:ubb/services/services.dart';

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

  Future<List<Feature>> loadPlacesFromJsonLC() async {
    // Cambia la URL al enlace en línea.
    final response = await http.get(Uri.parse(
        'https://ubbmap-81adc-default-rtdb.firebaseio.com/registros_lc.json'));

    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON.
      final jsonList = json.decode(response.body) as List;

      final places = jsonList.map((json) => Feature.fromMap(json)).toList();
      return places;
    } else {
      // Maneja el error de la solicitud HTTP aquí si es necesario.
      throw Exception('Error al cargar datos desde la URL');
    }
  }

Future getPlacesByQuery(LatLng proximity, String query) async {
  final newPlaces = <Feature>[];

  final places = await loadPlacesFromJsonLC();

  // Usamos una expresión regular para encontrar la parte "ab" después de los números
  final match = RegExp(r'\d+([a-zA-Z]+)').firstMatch(query);
  if (match != null) {
    final queryLetters = match.group(1)?.toLowerCase() ?? '';


    final filteredPlaces = places.where((place) =>
      place.text.toLowerCase().contains(query.toLowerCase()) ||
      place.placeName.any((name) => name.replaceAll(RegExp('[^a-zA-Z]+'), "").toLowerCase() == queryLetters)
    ).toList();

    newPlaces.addAll(filteredPlaces);
    add(OnNewPlacesFoundEventLC(filteredPlaces));
  } else {
  }
}
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'dart:convert';
import 'package:ubb/models/models.dart';
import 'package:ubb/services/services.dart';
import 'package:http/http.dart' as http;

// import 'package:ubb/data/data.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({
    required this.trafficService,
  }) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnDeactivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));
    on<OnNewPlacesFoundEvent>(
        (event, emit) => emit(state.copyWith(places: event.places)));
    on<AddToHistoryEvent>((event, emit) =>
        emit(state.copyWith(history: [event.place, ...state.history])));
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


Future<List<Feature>> loadPlacesFromJsonCCP() async {
  // Cambia la URL al enlace en línea.
  final response = await http.get(Uri.parse('https://ubbmap-81adc-default-rtdb.firebaseio.com/registros_ccp.json'));

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

  final places = await loadPlacesFromJsonCCP();

  final filteredPlaces = places.where((place) =>
      place.text.toLowerCase().contains(query.toLowerCase()) ||
      place.placeName.toLowerCase().contains(query.toLowerCase())).toList();

  newPlaces.addAll(filteredPlaces);
  add(OnNewPlacesFoundEvent(filteredPlaces));
}

}

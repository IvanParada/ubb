import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:ubb/models/models.dart';
import 'package:ubb/services/services.dart';
import 'package:ubb/data/data.dart';

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

  Future getPlacesByQuery(LatLng proximity, String query) async {
    final newPlacesLC = <Feature>[];

    final filteredPlacesLC = registrosLC
        .where((placeLC) =>
            placeLC.text.toLowerCase().contains(query.toLowerCase()) ||
            placeLC.placeName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    newPlacesLC.addAll(filteredPlacesLC);
    add(OnNewPlacesFoundEventLC(filteredPlacesLC));
  }
}

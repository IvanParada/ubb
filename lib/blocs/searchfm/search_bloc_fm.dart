import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:ubb/models/models.dart';
import 'package:ubb/services/services.dart';
import 'package:ubb/data/data.dart';

part 'search_event_fm.dart';
part 'search_state_fm.dart';

class SearchBlocFM extends Bloc<SearchEventFM, SearchStateFM> {
  TrafficService trafficService;

  SearchBlocFM({
    required this.trafficService,
  }) : super(const SearchStateFM()) {
    on<OnActivateManualMarkerEventFM>(
        (event, emit) => emit(state.copyWith(displayManualMarkerFM: true)));
    on<OnDeactivateManualMarkerEventFM>(
        (event, emit) => emit(state.copyWith(displayManualMarkerFM: false)));
    on<OnNewPlacesFoundEventFM>(
        (event, emit) => emit(state.copyWith(placesFM: event.placesFM)));
    on<AddToHistoryEventFM>((event, emit) =>
        emit(state.copyWith(historyFM: [event.placeFM, ...state.historyFM])));
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
    final newPlacesFM = <Feature>[];

    final filteredPlacesFM = registrosFM
        .where((placeFM) =>
            placeFM.text.toLowerCase().contains(query.toLowerCase()) ||
            placeFM.placeName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    newPlacesFM.addAll(filteredPlacesFM);
    add(OnNewPlacesFoundEventFM(filteredPlacesFM));
  }
}

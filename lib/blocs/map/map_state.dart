part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  //  final bool markersVisible;

  //Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  final Map<String, Marker> medicalMarkers;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = false,
    this.showMyRoute = false,
    // this.markersVisible = false,
    Map<String, Marker>? medicalMarkers,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : polylines = polylines ?? const {},
        medicalMarkers = medicalMarkers ?? const {},
        markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    // bool? markersVisible, 
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    Map<String, Marker>? medicalMarkers
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
        medicalMarkers: medicalMarkers ?? this.medicalMarkers
        // markersVisible: markersVisible ?? this.markersVisible,
      );

  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, showMyRoute, polylines, medicalMarkers,/*markers,markersVisible*/];
}

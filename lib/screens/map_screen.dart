import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ubb/blocs/bloc.dart';
import 'package:ubb/views/views.dart';
import 'package:ubb/widgets/widgets.dart';
import '../ui/ui.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  final ValueNotifier<bool> _markersVisible = ValueNotifier(true); // Agrega esta línea

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnowLocation == null) {
            return Scaffold(
              body: Stack(
                children: [
                  const HeaderCurvo(),
                  const Positioned(top: 200, left: 300, child: Bubble()),
                  const Positioned(top: -40, left: -30, child: Bubble()),
                  const Positioned(top: -50, right: -20, child: Bubble()),
                  _MapLoading()
                ],
              ),
            );
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return Stack(
                children: [
                  MapView(
                    polylines: polylines.values.toSet(),
                    markers: mapState.markers.values.toSet(),
                    markersVisible: _markersVisible, // Pasa el ValueNotifier aquí
                  ),
                  const SearchBar(),
                  const ManualMarker()
                ],
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnToggleMarker(markersVisible: _markersVisible), // Pasa el ValueNotifier aquí
          const BtnFollowUser(),
          const BtnCurrentLocation(),
          // BtnToggleUserRoute(),
        ],
      ),
    );
  }
}

class _MapLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            FadeInDown(
              child: const Center(
                  child: FaIcon(
                FontAwesomeIcons.mapLocationDot,
                color: Colors.white,
                size: 80,
              )),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: FadeInDown(
                          child: const Text(
                            'Cargando...',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: FadeInUp(
                        child: Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.blueGrey,
                            valueColor: AlwaysStoppedAnimation(
                                Color.fromARGB(255, 9, 27, 43)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
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

    final size  = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnowLocation == null) {
            return Scaffold(
      body: Stack(
        children: [
          const HeaderCurvo(),
          const Positioned(top: 200, left:300, child: Bubble()),
          const Positioned(top: -40, left:-30, child: Bubble()),
          const Positioned(top: -50, right:-20, child: Bubble()),
          Center(
            child: FadeInDown(
              child:const Text(
                'Cargando...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            height: size.height * 1.05,
            width: size.width , // Ajusta esta posición según tus necesidades
            child: FadeInUp(
              child: const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.blueGrey,
                  valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 9, 27, 43),),
                ),
              ),
            ),
          ),
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
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnFollowUser(),
          BtnCurrentLocation(),
          // BtnToggleUserRoute(),
        ],
      ),
    );
  }
}


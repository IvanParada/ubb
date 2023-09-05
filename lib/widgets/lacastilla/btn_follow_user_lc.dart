import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubb/blocs/bloc.dart';

class BtnFollowUserLC extends StatelessWidget {
  const BtnFollowUserLC({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBlocLC = BlocProvider.of<MapBlocLC>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 9, 27, 43),
        maxRadius: 25,
        child: BlocBuilder<MapBlocLC, MapStateLC>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.isFollowingUserLC
                    ? Icons.directions_run_rounded
                    : Icons.hail_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                mapBlocLC.add(OnStartFollowingUserEventLC());
              },
            );
          },
        ),
      ),
    );
  }
}

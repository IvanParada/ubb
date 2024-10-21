import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubb/blocs/bloc.dart';
import 'package:ubb/themes/colors_theme.dart';

class BtnFollowUserFM extends StatelessWidget {
  const BtnFollowUserFM({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBlocFM = BlocProvider.of<MapBlocFM>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: AppColors.primary,
        maxRadius: 25,
        child: BlocBuilder<MapBlocFM, MapStateFM>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.isFollowingUserFM
                    ? Icons.directions_run_rounded
                    : Icons.hail_rounded,
                color: AppColors.white,
              ),
              onPressed: () {
                mapBlocFM.add(OnStartFollowingUserEventFM());
              },
            );
          },
        ),
      ),
    );
  }
}

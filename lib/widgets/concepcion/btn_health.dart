import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubb/themes/colors_theme.dart';

import '../../blocs/bloc.dart';

class BtnToggleMarker extends StatelessWidget {
  const BtnToggleMarker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: AppColors.primary,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              icon: SvgPicture.asset(
                'assets/icons/health_icon.svg',
                width: 20,
                height: 20,
              ),
              onPressed: () {
                mapBloc.add(ToggleMedicalMarkersVisibilityEvent());
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc.dart';
import '../ui/ui.dart';
import '../widgets/widgets.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade300,
        child: Center(
          child: BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) {
              return !state.isGpsEnabled
                  ? const _EnableGpsMessage()
                  : const _AccessButton();
            },
          ),
        ),
      ),
         floatingActionButton: const Padding(
           padding: EdgeInsets.only(bottom: 60, left: 60),
           child: Align(
               alignment: Alignment.bottomLeft,
               child: BtnBack(),
             ),
         ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        HeaderCurvo(),
        Positioned(top: 200, left: 300, child: Bubble()),
        Positioned(top: -40, left: -30, child: Bubble()),
        Positioned(top: -50, right: -20, child: Bubble()),
        GpsAccesTitle(),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        HeaderCurvo(),
        Positioned(top: 200, left: 300, child: Bubble()),
        Positioned(top: -40, left: -30, child: Bubble()),
        Positioned(top: -50, right: -20, child: Bubble()),
        GpsDisabled()
      ],
    );
  }
}

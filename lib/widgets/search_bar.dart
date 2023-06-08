import 'package:animate_do/animate_do.dart';
import 'package:ubb/blocs/bloc.dart';

import '../delegates/delegates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ubb/models/models.dart';

import '../helpers/helpers.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : FadeInDown(
                duration: const Duration(milliseconds: 300),
                child: const _SearchBarBody(),
              );
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody();

  void onSearchResults(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
                  showLoadingMessage(context);

      final destination = await searchBloc.getCoorsStartToEnd(
          locationBloc.state.lastKnowLocation!, result.position!);
      await mapBloc.drawRoutePolyline(destination);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
                context: context, delegate: SearchDestinationDelegate());
            if (result == null) return;

            // ignore: use_build_context_synchronously
            onSearchResults(context, result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 13,
            ),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 7))
                ]),
            alignment: Alignment.centerLeft,
            child: const Text('¿Dónde quieres ir?',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
    );
  }
}

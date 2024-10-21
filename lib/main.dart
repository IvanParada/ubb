import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ubb/blocs/bloc.dart';
import 'package:ubb/blocs/weather/weather_cubit.dart';
import 'package:ubb/helpers/routes.dart';
import 'package:ubb/services/services.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'ubbmap',
    options: const FirebaseOptions(
      apiKey: "AIzaSyAZs_EqCGSCaM822d3HZCiRrKwVdC8jYaA",
      appId: "1:1076359304083:android:e38757e2e388bacf1cce66",
      messagingSenderId: "1076359304083",
      projectId: "ubbmap-81adc",
    ),
  );

  runApp(MultiBlocProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(
          create: (context) =>
              MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
      BlocProvider(
          create: (context) => SearchBloc(trafficService: TrafficService())),
      BlocProvider(
          create: (context) => MapBlocFM(
              locationBlocFM: BlocProvider.of<LocationBloc>(context))),
      BlocProvider(
          create: (context) => SearchBlocFM(trafficService: TrafficService())),
      BlocProvider(
          create: (context) => MapBlocLC(
              locationBlocLC: BlocProvider.of<LocationBloc>(context))),
      BlocProvider(
          create: (context) => SearchBlocLC(trafficService: TrafficService())),
      BlocProvider(create: (context) => WeatherCubit(WeatherService())),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'UBBMap',
      routerConfig: router,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
    );
  }
}

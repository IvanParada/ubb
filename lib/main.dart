import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ubb/blocs/bloc.dart';
import 'package:ubb/screens/screens.dart';
import 'package:ubb/services/services.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(create: (context) =>MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
      BlocProvider(create: (context) => SearchBloc(trafficService: TrafficService())),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UBBMap',
      initialRoute: 'checking',
      routes: {
        'checking': (_) => const CheckAuthScreen(),
        'home_screen': (_) => const MainScreen(),
        'login_screen': (_) => const LoginScreen(),
        'map_screen': (_) => const LoadingScreen(),
        'register_screen': (_) => const RegisterScreen(),
        'settings_screen': (_) => const SettingsScreen(),
        'reset_password_screen': (_) => const PasswordResetScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}

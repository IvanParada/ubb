import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubb/blocs/weather/weather_cubit.dart';
import 'package:ubb/blocs/weather/weather_state.dart';
import 'package:ubb/helpers/status_enum.dart';
import 'package:ubb/services/weather_service.dart';
import 'package:ubb/widgets/home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(WeatherService())..fetchAllWeatherData(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == Status.success) {
              return PageTitle(weatherDataList: state.weatherDataList!);
            } else if (state.status == Status.error) {
              return Center(
                child: Text(state.errorMessage ?? 'Error al cargar los datos'),
              );
            } else {
              return const Center(
                child: Text('Presiona el botón para cargar el clima'),
              );
            }
          },
        ),
      ),
    );
  }
}

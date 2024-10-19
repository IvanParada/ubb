import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubb/helpers/status_enum.dart';
import 'package:ubb/services/weather_service.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService) : super(const WeatherState());

  Future<void> fetchAllWeatherData() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final weatherDataList = await weatherService.fetchAllWeatherData();
      emit(state.copyWith(
        status: Status.success,
        weatherDataList: weatherDataList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: 'Error al obtener los datos del clima: $e',
      ));
    }
  }
}

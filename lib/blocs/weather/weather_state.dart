
import 'package:ubb/helpers/status_enum.dart';
import 'package:ubb/models/weather_data.dart';

class WeatherState {
  final Status status;
  final List<WeatherData>? weatherDataList;
  final String? errorMessage;

  const WeatherState({
    this.status = Status.initial,
    this.weatherDataList,
    this.errorMessage,
  });

  WeatherState copyWith({
    Status? status,
    List<WeatherData>? weatherDataList,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weatherDataList: weatherDataList ?? this.weatherDataList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

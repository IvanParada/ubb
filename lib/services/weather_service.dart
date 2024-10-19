import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart'; 

String apiKey = 'ecd1ed319961044c42aaf01424b0e21c';

class WeatherService {
  Future<WeatherData> fetchWeatherDataCCP() async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=-36.8229514&lon=-73.0169533&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherData.fromJson(json);  
    } else {
      throw Exception('Error al obtener los datos del clima de CCP');
    }
  }

  Future<WeatherData> fetchWeatherDataChillan() async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=-36.605213941212774&lon=-72.09746254188289&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherData.fromJson(json);  // Convertimos el JSON al modelo
    } else {
      throw Exception('Error al obtener los datos del clima de Chillán');
    }
  }

  Future<List<WeatherData>> fetchAllWeatherData() async {
    final ccpData = await fetchWeatherDataCCP();
    final chillanData = await fetchWeatherDataChillan();
    return [ccpData, chillanData]; 
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

String apiKey = 'ecd1ed319961044c42aaf01424b0e21c';

class WeatherServiceCCP {
  Future<Map<String, dynamic>> fetchWeatherDataCCP() async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=-36.8229514&lon=-73.0169533&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los datos del clima');
    }
  }
}

class WeatherServiceCHILLAN {
  Future<Map<String, dynamic>> fetchWeatherDataCHILLAN() async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=-36.605213941212774&lon=-72.09746254188289&appid=$apiKey'; 
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los datos del clima');
    }
  }
}

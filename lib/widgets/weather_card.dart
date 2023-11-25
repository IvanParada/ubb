import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({super.key, this.weatherData});

  final Map<String, dynamic>? weatherData;
  final Map<String, String> weatherTranslations = {
    'Thunderstorm': 'Tormenta',
    'Drizzle': 'Llovizna',
    'Rain': 'Lluvia',
    'Snow': 'Nieve',
    'Mist': 'Neblina',
    'Smoke': 'Humo',
    'Haze': 'Bruma',
    'Dust': 'Polvo',
    'Fog': 'Niebla',
    'Sand': 'Arena',
    'Ash': 'Ceniza',
    'Squall': 'Chubasco',
    'Tornado': 'Tornado',
    'Clear': 'Despejado',
    'Clouds': 'Nubes',
  };
  final Map<String, String> icons = {
    '01d': 'assets/Sun.png',
    '01n': 'assets/Moon.png',
    '02d': 'assets/Cloudy_Day.png',
    '02n': 'assets/Cloudy_Night.png',
    '03d': 'assets/Cloud.png',
    '03n': 'assets/Cloud.png',
    '04d': 'assets/Cloud.png',
    '04n': 'assets/Cloud.png',
    '09d': 'assets/Raining.png',
    '09n': 'assets/Raining.png',
    '10d': 'assets/Raining.png',
    '10n': 'assets/Raining.png',
    '11d': 'assets/Thunder.png',
    '11n': 'assets/Thunder.png',
    '13d': 'assets/Snow.png',
    '13n': 'assets/Snow.png',
    '50d': 'assets/Mist.png',
    '50n': 'assets/Mist.png',
  };

  String translateWeather(String weather) {
    return weatherTranslations[weather] ?? weather;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.8,
        height: size.width * 0.9,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF0C3B64),
              Color(0xFF0D4576),
              Color(0xFF0B5494),
              Color(0xFF0B5494),
              Color(0xFF0D4576),
              Color(0xFF0C3B64),
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
Center(
  child: Expanded(
    child: Row(
      mainAxisSize: MainAxisSize.min, // Asegura que la fila ocupe el mínimo espacio necesario
      children: [
        const Icon(FontAwesomeIcons.locationDot, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          weatherData != null && weatherData!['name'] != null
              ? weatherData!['name']
              : 'Cargando',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
),

              if (weatherData != null && weatherData!['weather'] != null) ...[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff5CB3FF),
                            blurRadius: 60,
                            spreadRadius: 0.1,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      icons.containsKey(weatherData!['weather'][0]['icon'])
                          ? icons[weatherData!['weather'][0]['icon']]!
                          : 'assets/no-image.jpg',
                      width: 160, // Ajusta el ancho de la imagen aquí
                      height: 160, // Ajusta la altura de la imagen aquí
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                  const SizedBox(height: 10),

                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.topRight,
                    textDirection: TextDirection.rtl,
                    children: [
                      if (weatherData!['main'] != null &&
                          weatherData!['main']['temp'] != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              FontAwesomeIcons.temperatureEmpty,
                              size: 35,
                              color: Colors.white,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 30),
                              child: Text(
                                '${(weatherData!['main']['temp'] - 273.15).toStringAsFixed(1)}',
                                style: const TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const Text(
                        '°C',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                  const SizedBox(height: 10),

                if (weatherData!['weather'][0]['main'] != null)
                  Text(
                    translateWeather(weatherData!['weather'][0]['main']),
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
              ],
              const SizedBox(height: 10),
              if (weatherData?['main'] != null &&
                  weatherData!['main']['humidity'] != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Humedad: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: '${weatherData!['main']['humidity']}%',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ]),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      FontAwesomeIcons.droplet,
                      color: Colors.white,
                    )
                  ],
                ),
              const SizedBox(height: 10),
              if (weatherData?['main'] != null &&
                  weatherData!['main']['humidity'] != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Viento: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: '${weatherData!['wind']['speed']} km/h',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ]),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      FontAwesomeIcons.wind,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

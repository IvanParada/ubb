import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageTitle extends StatelessWidget {
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

  PageTitle({Key? key, this.weatherData}) : super(key: key);

  String translateWeather(String weather) {
    return weatherTranslations[weather] ?? weather;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            FadeInDown(
              child: const Center(
                child: Text(
                  '¡Bienvenid@!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeInLeft(
              child: const Center(
                child: Text(
                  'Explora nuestro campus con el mapa interactivo.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: FadeInUp(
                child: Image.asset(
                  'assets/logo.png',
                  height: 100,
                  width: 190,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
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
                  child: FadeInUp(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.locationDot,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Universidad del Bío-Bío',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        if (weatherData != null &&
                            weatherData!['weather'] != null) ...[
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(
                                      0xff5CB3FF), // Color de la sombra y su opacidad
                                  blurRadius:
                                      65, // Radio del desenfoque de la sombra
                                  spreadRadius:
                                      1, // Radio de propagación de la sombra
                                  offset: Offset(0,
                                      0), // Desplazamiento de la sombra en eje X e Y
                                ),
                              ],
                            ),
                            child: Image.network(
                              'https://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}.png',
                              fit: BoxFit.contain,
                            ),
                          ),
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
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                          '${(weatherData!['main']['temp'] - 273.15).toStringAsFixed(1)}',
                                          style: const TextStyle(
                                            fontSize: 80,
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
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (weatherData!['weather'][0]['main'] != null)
                            Text(
                              translateWeather(
                                  weatherData!['weather'][0]['main']),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                        ],
                        const SizedBox(height: 40),
                        if (weatherData?['main'] != null &&
                            weatherData!['main']['humidity'] != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Humedad: ${weatherData!['main']['humidity']}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                FontAwesomeIcons.droplet,
                                color: Colors.white,
                              )
                            ],
                          ),
                        const SizedBox(height: 20),
                        if (weatherData?['main'] != null &&
                            weatherData!['main']['humidity'] != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Viento: ${weatherData!['wind']['speed']} Km/h',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

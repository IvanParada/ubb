import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ubb/themes/colors_theme.dart';
import '../models/weather_data.dart';

class WeatherCardWidget extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCardWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.8, // Establecemos un ancho fijo
      child: SingleChildScrollView( // Permitir scroll si el contenido es grande
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: SvgPicture.asset(
                      'assets/icons/location_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  TextSpan(
                    text: '  ${weatherData.location}',
                    style: GoogleFonts.roboto(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            //TODO: LLAMAR IMAGENES (HACER DICCIONARIO)
            Image.asset(
              'assets/weather_img/Cloud.png',
              height: size.height * 0.16,
            ),
            Text(
              '${weatherData.temperature.toStringAsFixed(1)}°',
              style: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: size.height * 0.15,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            Text(
              weatherData.mainWeather,
              style: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: const Divider(thickness: 0.2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.22,
                vertical: size.height * 0.01,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/location_icon.svg'),
                      Text(
                        '${weatherData.windSpeed.toStringAsFixed(1)} km/h',
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Viento',
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/location_icon.svg'),
                      Text(
                        '${weatherData.humidity}%',
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Humedad',
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:ubb/widgets/widgets.dart';

import '../services/services.dart';
import '../ui/ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? ccpWeatherData;
  Map<String, dynamic>? chillanWeatherData;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchWeatherDataCCP();
    fetchWeatherDataCHILLAN();
  }

  Future<void> fetchWeatherDataCCP() async {
    final weatherService = WeatherServiceCCP();
    try {
      final data = await weatherService.fetchWeatherDataCCP();
      setState(() {
        ccpWeatherData = data;
        isLoading = false;
        error = null;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        error = 'Error al obtener los datos del clima en CCP: $e';
      });
    }
  }

  Future<void> fetchWeatherDataCHILLAN() async {
    final weatherService = WeatherServiceCHILLAN();
    try {
      final data = await weatherService.fetchWeatherDataCHILLAN();
      setState(() {
        chillanWeatherData = data;
        isLoading = false;
        error = null;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        error = 'Error al obtener los datos del clima en Chillan: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const HeaderCurvo(),
          const Positioned(top: 200, left: 300, child: Bubble()),
          const Positioned(top: -40, left: -30, child: Bubble()),
          const Positioned(top: -50, right: -20, child: Bubble()),
          _HomeBody(
            ccpWeatherData: ccpWeatherData ?? {},
            chillanWeatherData: chillanWeatherData ?? {},
          ),
        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final Map<String, dynamic> ccpWeatherData;
  final Map<String, dynamic> chillanWeatherData;
  const _HomeBody(
      {required this.ccpWeatherData, required this.chillanWeatherData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const PageTitle(),
          Swiper(
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.7,
            itemHeight: size.height * 0.5,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return WeatherCard(weatherData: ccpWeatherData);
              } else {
                return WeatherCard(weatherData: chillanWeatherData);
              }
            },
            itemCount: 2,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ubb/widgets/widgets.dart';

import '../services/services.dart';
import '../ui/ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    
  }

  Future<void> fetchWeatherData() async {

      final weatherService = WeatherService();
      final data = await weatherService.fetchWeatherData();
      setState(() {
        weatherData = data;
      });

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
          _HomeBody(weatherData: weatherData),
        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  const _HomeBody({Key? key, this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PageTitle(weatherData: weatherData),
          
          
          
          
          
        ],
      ),
    );
  }
}

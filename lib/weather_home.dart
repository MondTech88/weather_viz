import 'package:flutter/material.dart';
import 'package:weather_viz/themes/themes.dart';
import 'package:weather_viz/weather_page.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.mainThemeDark,
      home: const WeatherPage(),
    );
  }
}

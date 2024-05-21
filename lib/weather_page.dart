import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;
import 'package:intl/intl.dart';
import 'package:weather_viz/additional_info_item.dart';
import 'package:weather_viz/device.dart';
import 'package:weather_viz/hourly_forcast_tem.dart';
import 'package:weather_viz/themes/themes.dart';
import 'package:weather_viz/weather_icons.dart';

import 'app_secret.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>>? getCurrentWeather() async {
    String cityName = "lome";
    try {
      final weatherReponse = await htpp.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherAPIKey&units=metric",
        ),
      );
      final forecastReponse = await htpp.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey&units=metric",
        ),
      );

      if (weatherReponse.statusCode != 200 ||
          forecastReponse.statusCode != 200) {
        throw "An unexpected error occured!";
      }

      final forecastData = jsonDecode(forecastReponse.body);
      final weatherData = jsonDecode(weatherReponse.body);

      return [weatherData, forecastData];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = Device.lWidth(MediaQuery.of(context));
    double screenHeight = Device.usableScreenHeight(MediaQuery.of(context));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather Viz",
          style: TextStyles.appBarStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(WeatherIcons.refreshIcon),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final weatherData = data[0];
          final forecastData = data[1]["list"];

          final currentTemperature = weatherData["main"]["temp"];
          final currentSky = weatherData["weather"][0]["main"].toString();
          final currenPressure = weatherData["main"]["pressure"];
          final currentWindSpeed = weatherData["wind"]["speed"];
          final currentHumidity = weatherData["main"]["humidity"];

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth / 35, right: screenWidth / 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, child: TextField()),
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    elevation: 3,
                    child: SizedBox(
                      height: screenHeight / 3,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight / 45),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemperature°C",
                                  style: TextStyles.bigTextStyle,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight / 30),
                                  child: Icon(
                                    currentSky
                                                .toLowerCase()
                                                .contains("cloud") ||
                                            currentSky
                                                .toLowerCase()
                                                .contains("rain")
                                        ? WeatherIcons.cloudIcon
                                        : WeatherIcons.sunnyIcon,
                                    size: 48,
                                  ),
                                ),
                                Text(
                                  currentSky,
                                  style: TextStyles.textStyle20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 8),
                    child: Text(
                      "Hourly Weather Forecast",
                      style: TextStyles.textStyle24,
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final time =
                              DateTime.parse(forecastData[index]["dt_txt"]);
                          final currentSky =
                              forecastData[index]["weather"][0]["main"];
                          final iconData =
                              currentSky.toLowerCase().contains("cloud") ||
                                      currentSky.toLowerCase().contains("rain")
                                  ? WeatherIcons.cloudIcon
                                  : WeatherIcons.sunnyIcon;
                          final temperature =
                              forecastData[index]["main"]["temp"];

                          return HourlyForecastItem.getForecastItem(
                              hour: DateFormat("j").format(time),
                              iconData: iconData,
                              temperature: temperature);
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 10),
                    child: Text(
                      "Additional Informations",
                      style: TextStyles.textStyle24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: AdditionalInfo.getAdditionalInfos(
                          humidity: currentHumidity,
                          windSpeed: currentWindSpeed,
                          pressure: currenPressure,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

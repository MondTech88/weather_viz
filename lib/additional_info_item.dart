import 'package:flutter/material.dart';
import 'package:weather_viz/themes/themes.dart';
import 'package:weather_viz/weather_icons.dart';

class AdditionalInfo {
  static List<Widget> getAdditionalInfos(
      {required humidity, required windSpeed, required pressure}) {
    final infos = <Widget>[
      getAdditionalInfo(
          iconData: WeatherIcons.humidityIcon,
          label: "Humidity",
          value: humidity),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: getAdditionalInfo(
            iconData: WeatherIcons.airIcon,
            label: "Wind Speed",
            value: windSpeed),
      ),
      getAdditionalInfo(
          iconData: WeatherIcons.pressureIcon,
          label: "Pressure",
          value: pressure),
    ];

    return infos;
  }

  static Widget getAdditionalInfo({
    required iconData,
    required String label,
    required value,
  }) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Icon(iconData),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 2),
            child: Text(label, style: TextStyles.textStyle16),
          ),
          Text("$value", style: TextStyles.textStyle13),
        ],
      ),
    );
  }
}

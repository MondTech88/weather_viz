import 'package:flutter/material.dart';
import 'package:weather_viz/themes/themes.dart';

class HourlyForecastItem {
  static Widget getForecastItem(
      {required String hour,
      required IconData iconData,
      required temperature}) {
    return SizedBox(
      width: 100,
      height: 110,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(hour, style: TextStyles.textStyle16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Icon(iconData),
            ),
            Text(
              "$temperature°C",
              style: TextStyles.textStyle13,
            ),
          ],
        ),
      ),
    );
  }
}

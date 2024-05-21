import 'package:flutter/material.dart';

class Device {
  static Size lSize(MediaQueryData mediaQueryData) {
    return mediaQueryData.size;
  }

  static double lWidth(MediaQueryData mediaQueryData) {
    return lSize(mediaQueryData).width;
  }

  static double lHeight(MediaQueryData mediaQueryData) {
    return lSize(mediaQueryData).height;
  }

  static double statusBarHeight(MediaQueryData mediaQueryData) {
    return mediaQueryData.padding.top;
  }

  static double appBarHeight() {
    return AppBar().preferredSize.height;
  }

  static double usableScreenHeight(MediaQueryData mediaQueryData) {
    return lHeight(mediaQueryData) -
        statusBarHeight(mediaQueryData) -
        appBarHeight();
  }
}

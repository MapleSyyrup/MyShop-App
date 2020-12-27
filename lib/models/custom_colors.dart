import 'package:flutter/material.dart';

Map<int, Color> primaryThemeColor = {
  50: Color.fromRGBO(157, 146, 206, .1),
  100: Color.fromRGBO(157, 146, 206, .2),
  200: Color.fromRGBO(157, 146, 206, .3),
  300: Color.fromRGBO(157, 146, 206, .4),
  400: Color.fromRGBO(157, 146, 206, .5),
  500: Color.fromRGBO(157, 146, 206, .6),
  600: Color.fromRGBO(157, 146, 206, .7),
  700: Color.fromRGBO(157, 146, 206, .8),
  800: Color.fromRGBO(157, 146, 206, .9),
  900: Color.fromRGBO(157, 146, 206, 1),
};

Map<int, Color> accentThemeColor = {
  50: Color.fromRGBO(231, 217, 251, .1),
  100: Color.fromRGBO(231, 217, 251, .2),
  200: Color.fromRGBO(231, 217, 251, .3),
  300: Color.fromRGBO(231, 217, 251, .4),
  400: Color.fromRGBO(231, 217, 251, .5),
  500: Color.fromRGBO(231, 217, 251, .6),
  600: Color.fromRGBO(231, 217, 251, .7),
  700: Color.fromRGBO(231, 217, 251, .8),
  800: Color.fromRGBO(231, 217, 251, .9),
  900: Color.fromRGBO(231, 217, 251, 1),
};

Map<int, Color> canvasThemeColor = {
  50: Color.fromRGBO(238, 228, 249, .1),
  100: Color.fromRGBO(238, 228, 249, .2),
  200: Color.fromRGBO(238, 228, 249, .3),
  300: Color.fromRGBO(238, 228, 249, .4),
  400: Color.fromRGBO(238, 228, 249, .5),
  500: Color.fromRGBO(238, 228, 249, .6),
  600: Color.fromRGBO(238, 228, 249, .7),
  700: Color.fromRGBO(238, 228, 249, .8),
  800: Color.fromRGBO(238, 228, 249, .9),
  900: Color.fromRGBO(238, 228, 249, 1),
};

MaterialColor primaryTheme = new MaterialColor(0xFF9D92CE, primaryThemeColor);
MaterialColor accentTheme = new MaterialColor(0xFFE7D9FB, accentThemeColor);
MaterialColor canvasTheme = new MaterialColor(0xFFEEE4F9, canvasThemeColor);

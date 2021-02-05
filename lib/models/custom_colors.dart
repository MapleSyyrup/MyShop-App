import 'package:flutter/material.dart';

///Map of customized shades for the app

Map<int, Color> primaryThemeColor = {
  50: const Color.fromRGBO(157, 146, 206, .1),
  100: const Color.fromRGBO(157, 146, 206, .2),
  200: const Color.fromRGBO(157, 146, 206, .3),
  300: const Color.fromRGBO(157, 146, 206, .4),
  400: const Color.fromRGBO(157, 146, 206, .5),
  500: const Color.fromRGBO(157, 146, 206, .6),
  600: const Color.fromRGBO(157, 146, 206, .7),
  700: const Color.fromRGBO(157, 146, 206, .8),
  800: const Color.fromRGBO(157, 146, 206, .9),
  900: const Color.fromRGBO(157, 146, 206, 1),
};

Map<int, Color> accentThemeColor = {
  50: const Color.fromRGBO(231, 217, 251, .1),
  100: const Color.fromRGBO(231, 217, 251, .2),
  200: const Color.fromRGBO(231, 217, 251, .3),
  300: const Color.fromRGBO(231, 217, 251, .4),
  400: const Color.fromRGBO(231, 217, 251, .5),
  500: const Color.fromRGBO(231, 217, 251, .6),
  600: const Color.fromRGBO(231, 217, 251, .7),
  700: const Color.fromRGBO(231, 217, 251, .8),
  800: const Color.fromRGBO(231, 217, 251, .9),
  900: const Color.fromRGBO(231, 217, 251, 1),
};

Map<int, Color> canvasThemeColor = {
  50: const Color.fromRGBO(238, 228, 249, .1),
  100: const Color.fromRGBO(238, 228, 249, .2),
  200: const Color.fromRGBO(238, 228, 249, .3),
  300: const Color.fromRGBO(238, 228, 249, .4),
  400: const Color.fromRGBO(238, 228, 249, .5),
  500: const Color.fromRGBO(238, 228, 249, .6),
  600: const Color.fromRGBO(238, 228, 249, .7),
  700: const Color.fromRGBO(238, 228, 249, .8),
  800: const Color.fromRGBO(238, 228, 249, .9),
  900: const Color.fromRGBO(238, 228, 249, 1),
};

MaterialColor primaryTheme = MaterialColor(0xFF9D92CE, primaryThemeColor);
MaterialColor accentTheme = MaterialColor(0xFFE7D9FB, accentThemeColor);
MaterialColor canvasTheme = MaterialColor(0xFFEEE4F9, canvasThemeColor);

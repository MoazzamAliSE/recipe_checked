import 'package:flutter/material.dart';

// define colour swatch
Map<int, Color> swatch = {
  50: const Color.fromRGBO(254, 165, 75, .1),
  100: const Color.fromRGBO(254, 165, 75, .2),
  200: const Color.fromRGBO(254, 165, 75, .3),
  300: const Color.fromRGBO(254, 165, 75, .4),
  400: const Color.fromRGBO(254, 165, 75, .5),
  500: const Color.fromRGBO(254, 165, 75, .6),
  600: const Color.fromRGBO(254, 165, 75, .7),
  700: const Color.fromRGBO(254, 165, 75, .8),
  800: const Color.fromRGBO(254, 165, 75, .9),
  900: const Color.fromRGBO(254, 165, 75, 1),
};

class ThemeNotifier with ChangeNotifier {
  // we only have one theme
  final lightTheme = ThemeData(
    primaryColor: const Color(0xFFFEA54B),
    brightness: Brightness.light,
    dividerColor: Colors.white54,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 96.0, fontFamily: 'Roboto', color: Colors.black87),
      displayMedium: TextStyle(
          fontSize: 60.0, fontFamily: 'Roboto', color: Colors.black87),
      displaySmall: TextStyle(
          fontSize: 48.0, fontFamily: 'Roboto', color: Colors.black87),
      headlineMedium: TextStyle(
          fontSize: 34.0, fontFamily: 'Roboto', color: Colors.black87),
      headlineSmall: TextStyle(
          fontSize: 24.0, fontFamily: 'Roboto', color: Colors.black87),
      titleLarge: TextStyle(
          fontSize: 20.0, fontFamily: 'Roboto', color: Colors.black87),
      titleMedium: TextStyle(
          fontSize: 16.0, fontFamily: 'Roboto', color: Colors.black87),
      titleSmall: TextStyle(
          fontSize: 14.0, fontFamily: 'Roboto', color: Colors.black87),
      bodyLarge: TextStyle(
          fontSize: 16.0, fontFamily: 'Roboto', color: Colors.black87),
      bodyMedium: TextStyle(
          fontSize: 14.0, fontFamily: 'Roboto', color: Colors.black87),
      labelLarge: TextStyle(
          fontSize: 14.0, fontFamily: 'Roboto', color: Colors.black87),
      bodySmall: TextStyle(
          fontSize: 12.0, fontFamily: 'Roboto', color: Colors.black87),
      labelSmall: TextStyle(
          fontSize: 10.0, fontFamily: 'Roboto', color: Colors.black87),
    ),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: MaterialColor(0xFFFEA54B, swatch))
            .copyWith(background: Color(0xFFE5E5E5)),
  );

  late ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    _themeData = lightTheme;
    notifyListeners();
  }
}

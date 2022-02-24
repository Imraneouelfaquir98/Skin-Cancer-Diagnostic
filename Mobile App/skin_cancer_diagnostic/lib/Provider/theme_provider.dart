import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode  => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Themes {

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
    colorScheme: ColorScheme.dark(),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red,),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

  static final lighTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
      colorScheme: ColorScheme.light(),
      textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
          )
      )
  );
}
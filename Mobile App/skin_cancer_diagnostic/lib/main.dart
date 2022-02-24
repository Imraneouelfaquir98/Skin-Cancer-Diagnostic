import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_cancer_diagnostic/Provider/change_theme_button.dart';
import 'package:skin_cancer_diagnostic/Provider/theme_provider.dart';

import 'HomePage/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _){
        return MaterialApp(
          title: 'Permis Maroc',
          theme: ThemeData(
            brightness: (Provider.of<ThemeProvider>(context).isDarkMode)? Brightness.dark : Brightness.light,
            primaryColor: Colors.white,
            accentColor: Colors.cyan[600],
            textTheme: TextTheme(
              headline6: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold,
                  color: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.white: Colors.grey[700]
              ),
              headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
              headline4: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              headline3: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold,
                  color: (Provider.of<ThemeProvider>(context).isDarkMode)?Colors.pinkAccent:Colors.blueAccent
              ),
              headline1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ),
          home: HomePage(title: 'Disease diagnoses',)
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_cancer_diagnostic/HomePage/button_infos.dart';
import 'package:skin_cancer_diagnostic/HomePage/rectangle_button.dart';
import 'package:skin_cancer_diagnostic/Provider/change_theme_button.dart';
import 'package:skin_cancer_diagnostic/Provider/theme_provider.dart';

import 'diagnostic_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.pinkAccent :Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            actions: [
              ChangeThemeButton()
            ]
        ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Column(
                children: [
                  RectangleButton(
                      size: size,
                      button_infos: ButtonInfos(
                          path_image: 'assets/images/1_1.png',
                          widget: DiagnosticPage(index_model: 0, title: 'Pneumonia diagnostic'),
                          title: 'Pneumonia diagnostic', index_model: 0
                      )
                  ),
                  SizedBox(height: 15,),
                  RectangleButton(
                      size: size,
                      button_infos: ButtonInfos(
                          path_image: 'assets/images/melanoma.webp',
                          widget: DiagnosticPage(index_model: 1, title: 'Skin Cancer Diagnostic'),
                          title: 'Melanoma diagnostic', index_model: 0
                      )
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/theme_provider.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
      toolbarHeight: 60,
      backgroundColor: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.pinkAccent :Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0, fontWeight: FontWeight.bold,
        ),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context)
          );
        },
      ),
      actions: [
        Builder(
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
        SizedBox(width: 10,)
      ]
  );
}

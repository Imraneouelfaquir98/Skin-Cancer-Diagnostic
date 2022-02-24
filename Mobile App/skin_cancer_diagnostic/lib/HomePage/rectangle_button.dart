import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skin_cancer_diagnostic/HomePage/button_infos.dart';
import 'package:skin_cancer_diagnostic/Provider/theme_provider.dart';
import 'package:provider/provider.dart';

class RectangleButton extends StatefulWidget {

  final ButtonInfos button_infos;
  final Size size;
  double padding_top, padding_bottom;
  double font_size;
  bool rounded_icon;
  RectangleButton({
    Key? key,
    required this.size,
    required this.button_infos,
    this.padding_top = 10,
    this.padding_bottom = 15,
    this.font_size = 20,
    this.rounded_icon = false
  }) : super(key: key);

  @override
  _RectangleButtonState createState() => _RectangleButtonState();
}

class _RectangleButtonState extends State<RectangleButton> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: widget.size.width*0.88,
      decoration: BoxDecoration(
        color: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        trailing: Icon(Icons.arrow_right, size: 40, color: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.pinkAccent :Colors.blueAccent,),
        leading: Container(
          width: 80, height: 80, padding: EdgeInsets.only(top: 1),
          decoration: BoxDecoration(
              color: (Provider.of<ThemeProvider>(context).isDarkMode && widget.rounded_icon)?  Colors.pinkAccent :((Provider.of<ThemeProvider>(context).isDarkMode && !widget.rounded_icon)?Colors.grey[900]:Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: Image.asset(widget.button_infos.path_image),
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder : (context) => widget.button_infos.widget)),
        title: Container(
          padding: EdgeInsets.only(top: widget.padding_top, bottom: widget.padding_bottom, right: 5),
          child: Text(
              widget.button_infos.title,
              style: TextStyle(
                  fontSize: widget.font_size, fontWeight: FontWeight.bold,
                  color: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.white: Colors.grey[600]
              )
          ),
        ),
      ),
    );
  }
}
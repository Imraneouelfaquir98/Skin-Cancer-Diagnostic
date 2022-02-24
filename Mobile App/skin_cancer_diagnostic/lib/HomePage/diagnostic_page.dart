import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skin_cancer_diagnostic/HomePage/button_infos.dart';
import 'package:skin_cancer_diagnostic/Provider/theme_provider.dart';
import 'package:tflite/tflite.dart';

import '../app_bar.dart';

class DiagnosticPage extends StatefulWidget {
  final int index_model;
  final String title;
  const DiagnosticPage({Key? key, required this.index_model, required this.title}) : super(key: key);

  @override
  _DiagnosticPageState createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> {
  XFile? _image;
  bool _loading =false ;
  List<dynamic>?_outputs;

  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }


//Load the Tflite model
  loadModel() async {
    await Tflite.loadModel(
      model: models[widget.index_model][0],
      labels: models[widget.index_model][1],
    );
  }

  classifyImage(image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  Future pickImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, widget.title),
      body:  _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          strokeWidth: 100,
        ),
      )
          : Container(

        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            _image == null ? Container(
              child: Text(
                  'Select or take a picture',
                  style: TextStyle(
                    color: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.white :Colors.grey[900], fontSize: 22
                  ),
              ),
            ) : Image.file(File(_image!.path)),
            SizedBox(
              height: 20,
            ),
            _outputs != null
                ? Container(
              width: size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                _outputs![0]["label"],
                style: TextStyle(
                  color: (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.white :Colors.grey[900],
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ): Container(),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: openCamera,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('Take a Picture', style: TextStyle(fontSize: 22),),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.pinkAccent :Colors.blueAccent,)
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: openGallery,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('Select image', style: TextStyle(fontSize: 22),),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => (Provider.of<ThemeProvider>(context).isDarkMode)? Colors.pinkAccent :Colors.blueAccent,)
                  ),
                )
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Future openCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image ;
    });
  }

  //camera method
  Future openGallery() async {
    var piture = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = piture;
    }
    );
    classifyImage(piture);
  }

}

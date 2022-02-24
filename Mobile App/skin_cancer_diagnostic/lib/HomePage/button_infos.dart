import 'package:flutter/material.dart';

class ButtonInfos{
  final String title, path_image;
  final Widget widget;
  final int index_model;
  const ButtonInfos({required this.title, required this.path_image, required this.widget, required this.index_model});
}

final List<List<String>> models = [
  ['assets/pneumonia_model/model_pneumonia.tflite', 'assets/pneumonia_model/labels_pneumonia.txt'],
  ['assets/skin_cancer/model_unquant.tflite', 'assets/skin_cancer/labels.txt'],
];
import 'package:flutter/material.dart';

class GameButton {
  final id;
  String text;
  Color bgColor;
  bool enabled;

  GameButton({this.id, this.text = "", this.bgColor = Colors.grey, this.enabled = true});
}
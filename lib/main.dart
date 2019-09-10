import 'package:flutter/material.dart';

import 'game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
      home: Game(),
    );
  }
}

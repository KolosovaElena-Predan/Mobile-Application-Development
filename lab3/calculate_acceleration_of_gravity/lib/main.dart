import 'package:flutter/material.dart';
import 'FirstSceen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Выполнила: Колосова Елена'),
        ),
        body: FirstSceen(),
      ),
    );
  }
}
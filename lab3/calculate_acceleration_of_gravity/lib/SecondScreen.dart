import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final double mass;
  final double radius;

  SecondScreen({required this.mass, required this.radius});

  @override
  Widget build(BuildContext context) {
    // Гравитационная постоянная
    const G = 6.67430e-11;

    double g = (G * mass) / (radius * radius);

    return Scaffold(
      appBar: AppBar(
        title: Text('Выполнила: Колосова Елена'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Ускорение свободного падения небесного тела с массой ${mass} кг и радиусом ${radius} м равно:',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              '${g.toStringAsFixed(2)} м/с²',
              style: TextStyle(fontSize: 70.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
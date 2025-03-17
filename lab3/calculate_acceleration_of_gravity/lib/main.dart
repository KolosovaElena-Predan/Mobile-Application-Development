import 'package:flutter/material.dart';

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
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _field1 = TextEditingController();
  final _field2 = TextEditingController();
  bool _agriment = false;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Масса небесного тела: ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _field1,
              validator: (value) {
                if (value!.isEmpty) return 'Пожалуйста введите массу небесного тела';
                final mass = double.tryParse(value);
                if (mass == null || mass < 0) {
                  return 'Поле может содержать только положительные числа';
                }
              },
            ),
            const Text(
              'Радиус небесного тела: ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _field2,
              validator: (value) {
                if (value!.isEmpty) return 'Пожалуйста введите радиус небесного тела';
                final rad = double.tryParse(value);
                if (rad == null || rad < 0) {
                  return 'Поле может содержать только положительные числа';
                }
              },
            ),
            CheckboxListTile(
              value: _agriment,
              title: const Text('Я ознакомлен с документом "Согласие на обработку персональных данных"'),
              onChanged: (bool? value) {
                setState(() {
                  _agriment = value!;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()&&_agriment) {
                  double mass = double.parse(_field1.text);
                  double radius = double.parse(_field2.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => SecondScreen(mass: mass, radius: radius)
                    ),);
                }
                else if (!_agriment) {
                  // Если чекбокс не установлен, показываем сообщение об ошибке
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Вы должны согласиться с условиями обработки персональных данных'),
                    ),);}
                
              },
              child: const Text('Посчитать ускорение свободного падения'),
            ),
          ],
        ),
      ),
    );
  }
}


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
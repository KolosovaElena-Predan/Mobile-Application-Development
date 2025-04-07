import 'package:flutter/material.dart';
import 'SecondScreen.dart';

class FirstSceen extends StatefulWidget {
  @override
  _FirstSceenState createState() => _FirstSceenState();
}

class _FirstSceenState extends State<FirstSceen> {
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
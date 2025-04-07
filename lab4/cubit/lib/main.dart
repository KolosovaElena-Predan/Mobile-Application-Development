// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit/screens/cubit/calc_cubit.dart';
import 'package:cubit/screens/MainSceen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CalculatorCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор ускорения свободного падения',
      home: MainScreen(),
    );
  }
}
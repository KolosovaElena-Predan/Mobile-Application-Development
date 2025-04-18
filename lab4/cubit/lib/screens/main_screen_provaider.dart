import 'package:cubit/screens/cubit/calc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit/screens/MainScreen.dart'; 

class MainScreenProvaider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalculatorCubit>(
      create: (context) => CalculatorCubit(),
      child: MainScreen(),
    );
  }
}
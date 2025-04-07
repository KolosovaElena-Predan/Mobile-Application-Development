import 'package:flutter_bloc/flutter_bloc.dart';
import 'calc_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  double _mass = 0;
  double _radius = 0;
  bool _agriment = false;

  void updateMass(double mass) {
    _mass = mass;
    emit(CalculatorUpdated(mass: _mass, radius: _radius, agriment: _agriment));
  }

  void updateRadius(double radius) {
    _radius = radius;
    emit(CalculatorUpdated(mass: _mass, radius: _radius, agriment: _agriment));
  }

  void toggleConsent(bool value) {
    _agriment = value;
    emit(CalculatorUpdated(mass: _mass, radius: _radius, agriment: _agriment));
  }

  void calculateGravity(double mass, double radius) {
    if (mass > 0 && radius > 0 && _agriment) {
      const double G = 6.674 * 1e-11; // Гравитационная постоянная
      final acceleration = G * mass / (radius * radius);
      emit(CalculatorResult(acceleration: acceleration));
    }
  }
}
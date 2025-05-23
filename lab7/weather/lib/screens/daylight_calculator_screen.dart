import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/daylight_cubit.dart';
import '../models/daylight_model.dart';

class DaylightCalculatorPage extends StatelessWidget {
  const DaylightCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расчёт длины дня'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => showHistory(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DaylightCalculatorForm(),
            const SizedBox(height: 20),
            BlocBuilder<DaylightCubit, DaylightState>(
              builder: (context, state) {
                if (state is DaylightLoading) {
                  return const CircularProgressIndicator();
                } else if (state is DaylightLoaded) {
                  return DaylightInfo.DaylightInfo(daylight: state.daylight);
                } else if (state is DaylightError) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<DaylightCubit, DaylightState>(
          builder: (context, state) {
            if (state is DaylightHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DaylightHistoryLoaded) {
              return AlertDialog(
                title: const Text('История'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      final item = state.history[index];
                      return ListTile(
                        title: Text(item.location),
                        subtitle: Text(
                          'Рассвет: ${formatTime24(item.sunrise)}\n'
                          'Закат: ${formatTime24(item.sunset)}\n'
                          'Длина дня: ${formatDuration(item.dayLength)}\n'
                          'Посл. Измерение: ${formatDateTime(item.date)}',
                        ),
                        trailing: Text(
                          DateFormat('yyyy-MM-dd').format(item.date),
                        ),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Закрыть'),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }

  String formatTime24(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  String formatDuration(Duration duration) {
    return '${duration.inHours}ч ${duration.inMinutes.remainder(60)}м';
  }

  String formatDateTime(DateTime date) {
    return DateFormat('HH:mm dd.MM.yyyy').format(date);
  }
}

class DaylightCalculatorForm extends StatefulWidget {
  @override
  State<DaylightCalculatorForm> createState() => DaylightCalculatorFormState();
}

class DaylightCalculatorFormState extends State<DaylightCalculatorForm> {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Column(
    children: [
      Column(
        children: [
          TextField(
            controller: latitudeController,
            decoration: const InputDecoration(
              labelText: 'Широта',
              hintText: 'например: 52.5200',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: longitudeController,
            decoration: const InputDecoration(
              labelText: 'Долгота',
              hintText: 'например: 13.4050',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),

      const SizedBox(height: 16),

      // Дата
      Row(
        children: [
          Text('Дата: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => selectDate(context),
            child: const Text('Выбрать дату'),
          ),
        ],
      ),

      const SizedBox(height: 16),

      // Кнопка "Рассчитать"
      ElevatedButton(
        onPressed: () {
          final lat = latitudeController.text.trim();
          final lon = longitudeController.text.trim();

          if (lat.isNotEmpty && lon.isNotEmpty) {
            context.read<DaylightCubit>().calculateDaylight('$lat,$lon', selectedDate);
          }
        },
        child: const Text('Рассчитать'),
      ),
    ],
  );
}

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class DaylightInfo extends StatelessWidget {
  final DaylightModel daylight;

  const DaylightInfo.DaylightInfo({required this.daylight});

  String formatTime24(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String formatDuration(Duration duration) {
    return '${duration.inHours}ч ${duration.inMinutes.remainder(60)}м';
  }

  String formatDateTime(DateTime date) {
    return DateFormat('HH:mm dd.MM.yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Рассвет: ${formatTime24(daylight.sunrise)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Закат: ${formatTime24(daylight.sunset)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Длина дня: ${formatDuration(daylight.dayLength)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Посл. Измерение: ${formatDateTime(daylight.date)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
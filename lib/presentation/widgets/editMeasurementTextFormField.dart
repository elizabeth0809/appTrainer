// Widget para mostrar un measurement con opción de editar
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/presentation/screens/screen.dart';

class MeasurementTile extends ConsumerWidget {
  final UserMeasurement measurement;
  
  const MeasurementTile({
    Key? key,
    required this.measurement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            measurement.weight.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text('${measurement.height} cm - ${measurement.weight} kg'),
        subtitle: Text('${measurement.gender} · ${measurement.level}'),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateMeasurementScreen(
                  measurement: measurement,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
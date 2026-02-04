import 'package:flutter/material.dart';
import 'package:trainer_app/domain/models/data.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class SchedulingCreateScreen extends StatefulWidget {
  const SchedulingCreateScreen({super.key});

  @override
  State<SchedulingCreateScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingCreateScreen> {
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personalizacion')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            DateTimeSelector(
              onChanged: (dateTime) {
                if (!mounted) return; // Verifica si el widget sigue vivo
                setState(() => selectedDateTime = dateTime);
              },
            ),
            ObjetivoDropdown(),
            const SizedBox(height: 16),
            ObjetivoDropdown(),
            const SizedBox(height: 16),
            ObjetivoDropdown(),
            const SizedBox(height: 16),
            ButtonBlue(link: '/home/confirm', text: 'Guardar'),
          ],
        ),
      ),
    );
  }
}

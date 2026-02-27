import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                /* DateTimeSelector(
                  onChanged: (dateTime) {
                    if (!mounted) return; // Verifica si el widget sigue vivo
                    setState(() => selectedDateTime = dateTime);
                  },
                ),*/
                Textformfield(
                  controller: TextEditingController(),
                  icon: Icons.abc,
                  label: 'Nombre',
                ),
                const SizedBox(height: 16),
                ObjetivoDropdown(),
                const SizedBox(height: 16),
                
                DateSelector(
                  availableTimes: ["08:15", "08:30", "08:45", "09:15"],
                  onDateSelected: (date) {
                    print("Fecha seleccionada: $date");
                  },
                  onTimeSelected: (time) {
                    print("Hora seleccionada: $time");
                  },
                ),
                const SizedBox(height: 20),
                ButtonBlue(link: '/home/confirm', text: 'Guardar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

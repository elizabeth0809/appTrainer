import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/userSchedulingController.dart';
import 'package:trainer_app/domain/provider/objetivesExercise.dart';

import 'package:trainer_app/presentation/widgets/widget.dart';
// 1. Cambia a ConsumerStatefulWidget
class SchedulingCreateScreen extends ConsumerStatefulWidget {
  const SchedulingCreateScreen({super.key});

  @override
  _SchedulingScreenState createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends ConsumerState<ConsumerStatefulWidget> {
  late final objetivosAsync = ref.watch(objetivosListProvider);
  // Variables locales para controlar los datos antes de enviarlos
  final TextEditingController nameController = TextEditingController();
  String? selectedTime;
  DateTime? selectedDate;
  int? selectedObjectiveId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Textformfield(
                controller: nameController,
                icon: Icons.abc,
                label: 'Nombre del Agendamiento',
              ),
              const SizedBox(height: 16),
              
              // Aquí debes capturar el valor del dropdown
              objetivosAsync.when(
    loading: () => const CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
    data: (listaObjetivos) {
      return DropdownButtonFormField<int>(
        value: selectedObjectiveId, // Variable int? de tu estado
        hint: const Text('Selecciona tu objetivo'),
        items: listaObjetivos.map((objetivo) {
          return DropdownMenuItem<int>(
            value: objetivo.id, // Enviamos el ID al backend
            child: Text(objetivo.name), // Mostramos el nombre al usuario
          );
        }).toList(),
        onChanged: (id) {
          setState(() {
            selectedObjectiveId = id;
          });
        },
        validator: (value) => value == null ? 'Campo requerido' : null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
      );
    },
  ),
              const SizedBox(height: 16),
              DateSelector(
                availableTimes: ["08:15", "08:30", "09:15"],
                onDateSelected: (date) => selectedDate = date,
                onTimeSelected: (time) => selectedTime = time,
              ),
              
              const SizedBox(height: 20),
              
              SizedBox(
                 width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white, 
                    ),
                child: Text( 'Guardar'),
                onPressed: () async {
                  if (nameController.text.isEmpty || selectedDate == null) return;

                  // 2. Construir el objeto JSON exactamente como lo espera el backend
                  final data = {
                    "name": nameController.text,
                    "scheduled_date": "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2,'0')}-${selectedDate!.day.toString().padLeft(2,'0')}",
                    "exercise_objetive_exercise_id": selectedObjectiveId,
                    "user_measurement_id": 1, // Debes obtener este ID dinámicamente
                    "opening_schedule_id": 1, // Debes mapear el tiempo seleccionado a este ID
                  };

                  // 3. Llamar al provider
                  await ref.read(userSchedulingProvider.notifier).createScheduling(data);
                  
                  if (mounted) context.pop();
                },
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

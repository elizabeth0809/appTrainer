import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/userSchedulingController.dart';
import 'package:trainer_app/domain/provider/objetivesExerciseProvider.dart';

import 'package:trainer_app/presentation/widgets/widget.dart';
// 1. Cambia a ConsumerStatefulWidget
class SchedulingCreateScreen extends ConsumerStatefulWidget {
  const SchedulingCreateScreen({super.key});

  @override
  _SchedulingScreenState createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends ConsumerState<SchedulingCreateScreen> { // Corregido el tipo de State
  final TextEditingController nameController = TextEditingController();
  String? selectedTime;
  DateTime? selectedDate;
  int? selectedObjectiveId;

  @override
  Widget build(BuildContext context) {
    // 1. Escuchamos el nuevo provider
    final objetivosAsync = ref.watch(objetivosFutureProvider);

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
              
              // 2. Implementación del Dropdown con manejo de estados
              objetivosAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Column(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    Text('No se pudieron cargar los objetivos', style: TextStyle(color: Colors.red)),
                    TextButton(
                      onPressed: () => ref.refresh(objetivosFutureProvider), 
                      child: const Text('Reintentar')
                    ),
                  ],
                ),
                data: (listaObjetivos) {
                  return DropdownButtonFormField<int>(
                    value: selectedObjectiveId,
                    hint: const Text('Selecciona tu objetivo'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    ),
                    items: listaObjetivos.map((objetivo) {
                      return DropdownMenuItem<int>(
                        value: objetivo.id,
                        child: Text(objetivo.name, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (id) {
                      setState(() => selectedObjectiveId = id);
                    },
                    validator: (value) => value == null ? 'Selecciona un objetivo' : null,
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
                  onPressed: () async {
                    if (nameController.text.isEmpty || selectedDate == null || selectedObjectiveId == null) {
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text("Por favor completa todos los campos"))
                       );
                       return;
                    }

                    final data = {
                      "name": nameController.text,
                      "scheduled_date": "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2,'0')}-${selectedDate!.day.toString().padLeft(2,'0')}",
                      "exercise_objetive_exercise_id": selectedObjectiveId,
                      "user_measurement_id": 1, 
                      "opening_schedule_id": 1,
                    };

                    await ref.read(userSchedulingProvider.notifier).createScheduling(data);
                    if (mounted) context.pop();
                  },
                  child: const Text('Guardar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

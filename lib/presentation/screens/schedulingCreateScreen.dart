import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trainer_app/domain/controller/userSchedulingController.dart';
import 'package:trainer_app/domain/models/openingScheduleModel.dart';
import 'package:trainer_app/domain/provider/objetivesExerciseProvider.dart';
import 'package:trainer_app/domain/provider/openingProvider.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class SchedulingCreateScreen extends ConsumerStatefulWidget {
  const SchedulingCreateScreen({super.key});

  @override
  _SchedulingScreenState createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends ConsumerState<SchedulingCreateScreen> {
  final TextEditingController nameController = TextEditingController();
  OpeningSchedule? selectedSchedule;
  DateTime? selectedDate;
  int? selectedObjectiveId;

  @override
  Widget build(BuildContext context) {
    final objetivosAsync = ref.watch(objetivosFutureProvider);
    final openingAsync = ref.watch(openingFutureProvider);
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
              objetivosAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Column(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    Text(
                      'No se pudieron cargar los objetivos',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextButton(
                      onPressed: () => ref.refresh(objetivosFutureProvider),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
                data: (listaObjetivos) {
                  return DropdownButtonFormField<int>(
                    value:
                        listaObjetivos.any((o) => o.id == selectedObjectiveId)
                        ? selectedObjectiveId
                        : null,
                    isExpanded: true,
                    hint: const Text('Selecciona tu objetivo'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                    ),
                    items: listaObjetivos.map((objetivo) {
                      return DropdownMenuItem<int>(
                        value: objetivo.id,
                        child: Text(
                          objetivo.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (id) {
                      setState(() => selectedObjectiveId = id);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              openingAsync.when(
                data: (allSchedules) {
                  final filteredSchedules = _filterSchedulesByDate(
                    allSchedules,
                    selectedDate ?? DateTime.now(),
                  );
                  return DateSelector(
                    availableSchedules: filteredSchedules,
                    onDateSelected: (date) =>
                        setState(() => selectedDate = date),
                    onTimeSelected: (schedule) =>
                        setState(() => selectedSchedule = schedule),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text("Error: $e"),
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
                    if (nameController.text.isEmpty) print("Nombre vacío");
                    if (selectedDate == null) print("Fecha vacía");
                    if (selectedObjectiveId == null) print("Objetivo vacío");
                    if (selectedSchedule == null) print("Horario vacío");
                    if (nameController.text.isEmpty ||
                        selectedDate == null ||
                        selectedObjectiveId == null ||
                        selectedSchedule == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Completa todos los campos"),
                        ),
                      );
                      return;
                    }
                    try {
                      final formattedDate = DateFormat(
                        'yyyy-MM-dd',
                      ).format(selectedDate!);
                      final data = {
                        "name": nameController.text,
                        "scheduled_date": formattedDate,
                        "exercise_objetive_exercise_id": selectedObjectiveId,
                        "opening_schedule_id": selectedSchedule!.id,
                      };

                      await ref
                          .read(userSchedulingProvider.notifier)
                          .createScheduling(data);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Agendamiento creado con éxito"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error al guardar: $e"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<OpeningSchedule> _filterSchedulesByDate(
  List<OpeningSchedule> all,
  DateTime date,
) {
  // Convertimos el weekday de Dart (1=Lunes, 7=Domingo) al formato de tu API (mon, tue...)
  final dayMap = {
    1: 'mon',
    2: 'tue',
    3: 'wed',
    4: 'thu',
    5: 'fri',
    6: 'sat',
    7: 'sun',
  };

  final dayKey = dayMap[date.weekday];
  return all.where((s) => s.day == dayKey).toList();
}

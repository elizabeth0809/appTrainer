import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/controller/profileController.dart';
import 'package:trainer_app/presentation/screens/screen.dart';
class MeasurementCard extends ConsumerWidget {
  const MeasurementCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    
    if (state.measurements.isEmpty) return const SizedBox.shrink();

    final m = state.measurements.first;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Fila con título y botón editar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tus Medidas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _navigateToUpdateMeasurement(context, ref, m),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            
            const Divider(height: 24),
            
            // Medidas
            _measureRow(Icons.monitor_weight, 'Peso', '${m.weight} kg'),
            const SizedBox(height: 12),
            _measureRow(Icons.height, 'Altura', '${m.height} cm'),
            const SizedBox(height: 12),
            _measureRow(
              Icons.fitness_center, 
              'Nivel', 
              m.level[0].toUpperCase() + m.level.substring(1).toLowerCase(),
            ),
            const SizedBox(height: 12),
            _measureRow(
              Icons.person, 
              'Genero', 
              m.gender[0].toUpperCase() + m.gender.substring(1).toLowerCase(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToUpdateMeasurement(
    BuildContext context, 
    WidgetRef ref, 
    dynamic measurement
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateMeasurementScreen(
          measurement: measurement,
        ),
      ),
    );
    
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Medidas actualizadas correctamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _measureRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.orange, size: 22),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, 
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 13, 
                color: Colors.grey
              ),
            ),
            Text(
              subtitle, 
              style: const TextStyle(
                fontSize: 15, 
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ],
    );
  }
}
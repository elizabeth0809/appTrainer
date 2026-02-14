import 'package:flutter/material.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Evolución del entrenamiento',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Divider(),
            const SizedBox(height: 16),
        
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2,
              children: [
                const StatCard(
                  title: 'Racha',
                  value: '30 días',
                  icon: Icons.favorite_border,
                  color: Colors.blue,
                ),
                const StatCard(
                  title: 'Nivel:',
                  value: 'Principiante',
                  icon: Icons.star_outline,
                  color: Colors.green,
                ),
                const StatCard(
                  title: 'Entrenamientos',
                  value: '150 totales',
                  icon: Icons.access_time,
                  color: Colors.blue,
                ),
                const StatCard(
                  title: 'Esta semana',
                  value: '5 sesiones',
                  icon: Icons.calendar_month,
                  color: Colors.lightGreen,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
                'Mis ejercicios',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              const Divider(),
              const ExerciseCard(),
          ],
        ),
      ),
    );
  }
}

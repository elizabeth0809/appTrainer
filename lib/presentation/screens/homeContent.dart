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
            Text(
              'Mis Agendamientos',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const Divider(),
            const UserSchedulingCard(),
          ],
        ),
      ),
    );
  }
}

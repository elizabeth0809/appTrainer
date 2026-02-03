import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/models/data.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  int selectedIndex = -1; // ninguno seleccionado al inicio
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicios'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: exercises.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Schedulingcard(
                      isSelected: isSelected,
                      title: exercise.title,
                      type: exercise.type,
                      price: exercise.price,
                      image: exercise.image,
                    ),
                  );
                },
              ),
            ),
            _nextButton(),
          ],
        ),
      ),
    );
  }

  Widget _nextButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          onPressed: () {
            context.go('/home/editInfoId');
          },
          icon: const Text('Editar'),
          label: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

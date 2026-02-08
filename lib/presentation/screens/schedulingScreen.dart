import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/exerciseController.dart';
import 'package:trainer_app/domain/service/exerciseService.dart';

import 'package:trainer_app/presentation/widgets/widget.dart';

import '../../domain/models/model.dart';
final ExerciseControllerProvider = StateNotifierProvider((ref){
return ExerciseController(
  ExerciseState.initial()
);
});
class SchedulingScreen extends ConsumerStatefulWidget {
  const SchedulingScreen({super.key});

  @override
  ConsumerState<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends ConsumerState<SchedulingScreen> {
  late ExerciseController _exerciseController;
  late ExerciseState _exerciseData;
  int selectedIndex = -1; // ninguno seleccionado al inicio
  @override
  Widget build(BuildContext context) {
    _exerciseController = ref.watch(ExerciseControllerProvider.notifier);
    _exerciseData = ref.watch(ExerciseControllerProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Ejercicios'), elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
             /* Expanded(
                child: ListView.separated(
                  itemCount: 0,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final Exercise exercise = exercises[index];
                    final isSelected = selectedIndex == index;
      
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Schedulingcard(
                        isSelected: isSelected,
                        title: exercise.name,
                        type: exercise.modalities,
                        price: exercise.price,
                        image: exercise.img,
                      ),
                    );
                  },
                ),
              ),*/
              _nextButton(),
            ],
          ),
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

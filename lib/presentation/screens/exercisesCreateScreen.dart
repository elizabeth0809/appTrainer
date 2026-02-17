import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/provider/exerciseProvider.dart';
import 'package:trainer_app/global/exerciseApi.dart';
import 'package:trainer_app/presentation/widgets/widget.dart'; // Ajusta la ruta a tu provider



class ExerciseFormScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(exerciseFormProvider);
    final formNotifier = ref.read(exerciseFormProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(title: Text('Exercise Form')),
      body: Form(
        key: formState.formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                initialValue: formState.exercise.name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onChanged: formNotifier.updateName,
              ),
              TextFormField(
                initialValue: formState.exercise.price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Invalid price';
                  }
                  return null;
                },
                onChanged: formNotifier.updatePrice,
              ),
              TextFormField(
                initialValue: formState.exercise.modalities,
                decoration: InputDecoration(labelText: 'Modalities'),
                onChanged: formNotifier.updateModalities,
              ),
              TextFormField(
                initialValue: formState.exercise.img,
                decoration: InputDecoration(labelText: 'Image URL'),
                onChanged: formNotifier.updateImg,
              ),
              SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  final isSaving = ref.watch(exerciseServiceProvider).isSaving;
                  return ElevatedButton(
                    onPressed: isSaving ? null : () async {
                      if (formNotifier.isValidForm()) {
                        final service = ref.read(exerciseServiceProvider.notifier);
                        await service.saveOrCreateExercise(formState.exercise);
                        Navigator.pop(context);
                      }
                    },
                    child: isSaving
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Save'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
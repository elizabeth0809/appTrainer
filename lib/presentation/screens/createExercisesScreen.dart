import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainer_app/domain/controller/controller.dart';
import 'package:trainer_app/domain/provider/provider.dart';

import 'package:trainer_app/presentation/widgets/widget.dart';

class ExerciseFormScreen extends ConsumerWidget {
  const ExerciseFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(exerciseFormProvider);
    final formNotifier = ref.read(exerciseFormProvider.notifier);
    final exerciseState = ref.watch(exerciseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configurar Ejercicio')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección de Imagen
            _ImageHeader(formState: formState, formNotifier: formNotifier),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formState.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: formState.exercise.name,
                      decoration: const InputDecoration(labelText: 'Nombre del ejercicio'),
                      onChanged: formNotifier.updateName,
                      validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: formState.exercise.price.toString(),
                      decoration: const InputDecoration(labelText: 'Precio'),
                      keyboardType: TextInputType.number,
                      onChanged: formNotifier.updatePrice,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: formState.exercise.modalities.isEmpty ? null : formState.exercise.modalities,
                      decoration: const InputDecoration(labelText: 'Modalidad'),
                      items: const [
                        DropdownMenuItem(value: 'online', child: Text('Online')),
                        DropdownMenuItem(value: 'person', child: Text('Presencial')),
                      ],
                      onChanged: (value) => formNotifier.updateModalities(value ?? ''),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Cambiamos el icono si está guardando
        child: exerciseState.isSaving 
            ? const CircularProgressIndicator(color: Colors.white) 
            : const Icon(Icons.save),
        onPressed: exerciseState.isSaving 
            ? null 
            : () async {
                if (!formNotifier.isValidForm()) return;
                final success = await ref.read(exerciseProvider.notifier)
                    .saveOrCreateExercise(formState.exercise);
                
                if (success && context.mounted) {
                  context.pop();
                }
              },
      ),
    );
  }
}
class _ImageHeader extends ConsumerWidget {
  final ExerciseFormState formState;
  final ExerciseFormNotifier formNotifier;

  const _ImageHeader({required this.formState, required this.formNotifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        ExerciseImage(url: formState.exercise.img),
        Positioned(
          top: 40,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.black45,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () async {
                final picker = ImagePicker();
                final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile == null) return;
                ref.read(exerciseProvider.notifier).onFileChanged(pickedFile.path);
                formNotifier.updateImg(pickedFile.path);
              },
            ),
          ),
        ),
      ],
    );
  }
}
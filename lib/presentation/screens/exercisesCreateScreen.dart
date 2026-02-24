import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainer_app/domain/provider/exerciseProvider.dart';
import 'package:trainer_app/global/exerciseApi.dart';
import 'package:trainer_app/presentation/widgets/widget.dart'; // Ajusta la ruta a tu provider

class ExerciseFormScreen extends ConsumerStatefulWidget {
  const ExerciseFormScreen({super.key});

  @override
  ConsumerState<ExerciseFormScreen> createState() => _ExerciseFormScreenState();
}

class _ExerciseFormScreenState extends ConsumerState<ExerciseFormScreen> {
  late TextEditingController nameController;
late TextEditingController priceController;

  @override
  void initState() {
    super.initState();

final exercise = ref.read(exerciseFormProvider).exercise;

  nameController = TextEditingController(text: exercise.name);
  priceController = TextEditingController(text: exercise.price.toString());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final selectedExercise =
        ref.read(exerciseServiceProvider).selectedExercise;

    if (selectedExercise != null) {
      ref
          .read(exerciseFormProvider.notifier)
          .updateExercise(selectedExercise);

      nameController.text = selectedExercise.name;
      priceController.text = selectedExercise.price.toString();
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(exerciseFormProvider);
    final formNotifier = ref.read(exerciseFormProvider.notifier);

    final serviceState = ref.watch(exerciseServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Form')),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ExerciseImage(url: formState.exercise.img),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),

                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 35,
                      color: Colors.white,
                    ),
                    // En el método onPressed del IconButton
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality:
                            80, // Reducir calidad para ahorrar espacio
                      );

                      if (pickedFile == null) {
                        print('No seleccionó nada');
                        return;
                      }

                      // Verificar que el archivo existe
                      final file = File(pickedFile.path);
                      if (!await file.exists()) {
                        print('El archivo seleccionado no existe');
                        return;
                      }

                      // Actualizar con la ruta local
                      ref
                          .read(exerciseServiceProvider.notifier)
                          .updateSelectedExerciseImage(pickedFile.path);

                      formNotifier.updateImg(pickedFile.path);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formState.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: formState.exercise.name,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Name required'
                          : null,
                      onChanged: formNotifier.updateName,
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue: formState.exercise.price.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) => int.tryParse(value ?? '') == null
                          ? 'Invalid price'
                          : null,
                      onChanged: formNotifier.updatePrice,
                    ),

                    const SizedBox(height: 20),

                    /*TextFormField(
                      initialValue: formState.exercise.modalities,
                      decoration: const InputDecoration(
                        labelText: 'Modalities',
                      ),
                      onChanged: formNotifier.updateModalities,
                    ),*/
                    DropdownButtonFormField<String>(
                      value: formState.exercise.modalities.isEmpty
                          ? null
                          : formState.exercise.modalities,
                      items: const [
                        DropdownMenuItem(
                          value: 'online',
                          child: Text('Online'),
                        ),
                        DropdownMenuItem(
                          value: 'person',
                          child: Text('Presencial'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          formNotifier.updateModalities(value);
                        }
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: serviceState.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined),

        onPressed: serviceState.isSaving
            ? null
            : () async {
                if (!formNotifier.isValidForm()) return;

                final service = ref.read(exerciseServiceProvider.notifier);

                /// subir imagen si hay nueva
                final imageUrl = await service.uploadImage();

                if (imageUrl != null) {
                  formNotifier.updateImg(imageUrl);
                }

                await service.saveOrCreateExercise(
                  ref.read(exerciseFormProvider).exercise,
                );

                context.pop();
              },
      ),
    );
  }
}

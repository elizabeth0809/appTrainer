import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseTextFormfield extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController modalitiesController;
  final TextEditingController priceController;
  final TextEditingController imgController;
  const ExerciseTextFormfield({
    super.key,
    required this.nameController, required this.modalitiesController, required this.priceController, required this.imgController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //name
        TextFormField(
          controller: nameController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: 'Nombre del ejercicio',
            prefixIcon: Icon(Icons.account_box),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa el nombre';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        // Email
        TextFormField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Precio',
            prefixIcon: Icon(Icons.money),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.length < 1) {
              return 'Mínimo 1 numero';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),
        // Password
        TextFormField(
          controller: modalitiesController,
          decoration: const InputDecoration(
            labelText: 'Modalidad',
            prefixIcon: Icon(Icons.abc),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa la modalidad';
            }
            return null;
          },
        ),
        //confirm
        const SizedBox(height: 16),
        TextFormField(
          controller: imgController,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
            labelText: 'Imagen',
            prefixIcon: Icon(Icons.image),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa una imagen';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

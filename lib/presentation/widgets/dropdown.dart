import 'package:flutter/material.dart';

class ObjetivoDropdown extends StatefulWidget {
  const ObjetivoDropdown({Key? key}) : super(key: key);

  @override
  State<ObjetivoDropdown> createState() => _ObjetivoDropdownState();
}

class _ObjetivoDropdownState extends State<ObjetivoDropdown> {
  String? objetivoSeleccionado;

  final List<String> objetivos = [
    'Bajar de peso',
    'Ganar masa muscular',
    'Mejorar resistencia',
    'Mantenerme en forma',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Objetivo fitness', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          value: objetivoSeleccionado,
          hint: Text(
            'Selecciona tu objetivo',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          ),
          items: objetivos.map((objetivo) {
            return DropdownMenuItem(value: objetivo, child: Text(objetivo,   style: const TextStyle(fontSize: 14),));
          }).toList(),
          onChanged: (value) {
            setState(() {
              objetivoSeleccionado = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Selecciona un objetivo';
            }
            return null;
          },
        ),
      ],
    );
  }
}

// lib/ui/screens/update_measurement_screen.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trainer_app/domain/controller/profileController.dart';
import 'package:trainer_app/domain/models/model.dart';

class UpdateMeasurementScreen extends ConsumerStatefulWidget {
  final UserMeasurement measurement;
  
  const UpdateMeasurementScreen({
    Key? key,
    required this.measurement,
  }) : super(key: key);

  @override
  ConsumerState<UpdateMeasurementScreen> createState() => _UpdateMeasurementScreenState();
}

class _UpdateMeasurementScreenState extends ConsumerState<UpdateMeasurementScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late String _selectedGender;
  late String _selectedLevel;
  
  bool _isLoading = false;
  
  // Opciones para los dropdowns
  final List<String> _levelOptions = ['beginner', 'intermediate', 'advanced'];
  @override
  void initState() {
    super.initState();
    // Inicializar controladores con los valores actuales
    _weightController = TextEditingController(text: widget.measurement.weight.toString());
    _heightController = TextEditingController(text: widget.measurement.height.toString());
    _selectedGender = widget.measurement.gender;
    _selectedLevel = widget.measurement.level;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

 // En UpdateMeasurementScreen
Future<void> _updateMeasurement() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);
    
    try {
      // Leemos el notifier
      await ref.read(profileControllerProvider.notifier).updateMeasurementProfile({
        'weight': int.parse(_weightController.text),
        'height': int.parse(_heightController.text),
        'gender': _selectedGender,
        'level': _selectedLevel,
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Medidas actualizadas!'), backgroundColor: Colors.green)
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red)
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
  String _getDisplayGender(String gender) {
    switch (gender) {
      case 'male':
        return 'Masculino';
      case 'female':
        return 'Femenino';
      case 'other':
        return 'Otro';
      default:
        return gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Medidas'),
        elevation: 0,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // Tarjeta de información
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.fitness_center,
                        size: 50,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ID: ${widget.measurement.id}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Campo de Peso
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  hintText: 'Ejemplo: 70',
                  prefixIcon: const Icon(Icons.monitor_weight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu peso';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingresa un número válido';
                  }
                  if (int.parse(value) <= 0) {
                    return 'El peso debe ser mayor a 0';
                  }
                  if (int.parse(value) > 300) {
                    return 'El peso parece demasiado alto';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Campo de Altura
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  hintText: 'Ejemplo: 175',
                  prefixIcon: const Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu altura';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingresa un número válido';
                  }
                  if (int.parse(value) <= 0) {
                    return 'La altura debe ser mayor a 0';
                  }
                  if (int.parse(value) > 250) {
                    return 'La altura parece demasiado alta';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Sección de Género con Checkboxes
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade50,
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.person, size: 20, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Género',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Checkbox Masculino
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedGender = 'male';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedGender == 'male' 
                                      ? Colors.blue 
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: _selectedGender == 'male' 
                                    ? Colors.blue 
                                    : Colors.transparent,
                              ),
                              child: _selectedGender == 'male'
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Masculino',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Checkbox Femenino
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedGender = 'female';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedGender == 'female' 
                                      ? Colors.blue 
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: _selectedGender == 'female' 
                                    ? Colors.blue 
                                    : Colors.transparent,
                              ),
                              child: _selectedGender == 'female'
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Femenino',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Checkbox Otro
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedGender = 'other';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedGender == 'other' 
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: _selectedGender == 'other' 
                                    ? Colors.blue
                                    : Colors.transparent,
                              ),
                              child: _selectedGender == 'other'
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Otro',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // checkbox avanzado
              InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLevel = 'advanced';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedLevel == 'advanced' 
                                      ? Colors.red 
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: _selectedLevel == 'advanced' 
                                    ? Colors.red 
                                    : Colors.transparent,
                              ),
                              child: _selectedLevel == 'advanced'
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Avanzado',
                              style: TextStyle(fontSize: 16),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    //checkbox intermedio
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLevel = 'intermediate';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedLevel == 'intermediate' 
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: _selectedLevel == 'intermediate' 
                                    ? Colors.blue
                                    : Colors.transparent,
                              ),
                              child: _selectedLevel == 'intermediate'
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Intermedio',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
               //checkbox principeante
               InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLevel = 'beginner';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedLevel == 'beginner' 
                                      ? Colors.red 
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: _selectedLevel == 'beginner' 
                                    ? Colors.red 
                                    : Colors.transparent,
                              ),
                              child: _selectedLevel == 'beginner'
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Principiante',
                              style: TextStyle(fontSize: 16),
                            ),
                            
                          ],
                        ),
                      ),
                    ), 
              
              
              const SizedBox(height: 32),
              
              // Botón de Actualizar
              ElevatedButton(
                onPressed: _isLoading ? null : _updateMeasurement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Actualizar Medidas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              
              const SizedBox(height: 16),
              
              // Botón para cancelar
              TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
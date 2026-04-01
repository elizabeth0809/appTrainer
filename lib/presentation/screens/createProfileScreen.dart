import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trainer_app/domain/controller/controller.dart';



class CreateProfileScreen extends ConsumerStatefulWidget {
  
  const CreateProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _phoneController;
  late TextEditingController _birthdateController;
   late TextEditingController _weightController;
  late TextEditingController _heightController;

  String? _selectedGender;
  String? _selectedLevel;
  DateTime? _selectedDate;
  
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _selectedDate;
    _birthdateController = TextEditingController(text: _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : ''
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _birthdateController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedGender == null || _selectedLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona género y nivel'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
      setState(() => _isSaving = true);
      try {
      await ref.read(profileControllerProvider.notifier).createMeasurementProfile({
        'weight': int.parse(_weightController.text),
        'height': int.parse(_heightController.text),
        'gender': _selectedGender,
        'level': _selectedLevel,
      });

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
      try {
        final profileData = {
          'phone': _phoneController.text,
          'birthdate': _birthdateController.text,
        };

        await ref.read(profileControllerProvider.notifier).createProfile(profileData);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perfil actualizado correctamente'), backgroundColor: Colors.green),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
          );
        }
      } finally {
        if (mounted) setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Perfil'),
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
              
              // Campo de Teléfono
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Ingresa un teléfono' : null,
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _birthdateController,
                readOnly: true, 
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  hintText: 'yyyy-mm-dd',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Selecciona una fecha' : null,
              ),

              const SizedBox(height: 32),
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
              
              ElevatedButton(
                onPressed: _isSaving ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Guardar Cambios', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
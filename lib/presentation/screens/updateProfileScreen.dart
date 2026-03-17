import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart'; // Para formatear fechas
import 'package:trainer_app/domain/controller/profileController.dart';
import 'package:trainer_app/domain/models/model.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  final Profile profile;
  
  const UpdateProfileScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  ConsumerState<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _phoneController;
  late TextEditingController _birthdateController;
  DateTime? _selectedDate;
  
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.profile.phone);
    
    // Inicializar fecha
    _selectedDate = widget.profile.birthdate;
    _birthdateController = TextEditingController(
      text: _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : ''
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  // Función para abrir el selector de fecha
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
      setState(() => _isSaving = true);
      
      try {
        final profileData = {
          'phone': _phoneController.text,
          'birthdate': _birthdateController.text,
        };

        await ref.read(profileControllerProvider.notifier).updateProfile(profileData);

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
              
              // Campo de Fecha de Nacimiento (Solo lectura, abre el picker)
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
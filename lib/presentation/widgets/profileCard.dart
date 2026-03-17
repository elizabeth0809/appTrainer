import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/controller/profileController.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/presentation/screens/screen.dart';

class Infocard extends ConsumerWidget {
  const Infocard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Obtenemos el estado del perfil y los datos básicos del login
    final profileState = ref.watch(profileControllerProvider);
    final userAuth = ref.watch(loginProvider).user?.data;
    final pstate = profileState.profile;
    // Si está cargando, mostramos un placeholder o un spinner
    if (profileState.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final p = profileState.profile;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Email (Viene del login/auth)
            _infoRow(
              icon: Icons.email_outlined,
              title: 'Email',
              subtitle: userAuth?.email ?? 'correo@correo.com',
            ),
            const SizedBox(height: 12),

            _infoRow(
              icon: Icons.phone,
              title: 'Teléfono',
              subtitle: p?.profile.phone ?? 'No registrado',
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                 onPressed: () => _navigateToUpdateProfile(context, ref, p?.profile),
              ),
            ),
            const SizedBox(height: 12),

            // Fecha de Nacimiento / Miembro desde
            _infoRow(
              icon: Icons.cake_outlined,
              title: 'Fecha de Nacimiento',
              subtitle: p?.profile.birthdate.toString() ?? 'No disponible',
            ),
            const SizedBox(height: 12),

            // Rol o Membresía (Viene del login/auth)
            _infoRow(
              icon: Icons.workspace_premium_outlined,
              title: 'Rol de usuario',
              subtitle: userAuth?.role?.toUpperCase() ?? 'CUSTOMER',
            ),
          ],
        ),
      ),
    );
  }
void _navigateToUpdateProfile(
    BuildContext context, 
    WidgetRef ref, 
    dynamic profile
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileScreen(
          profile: profile,
        ),
      ),
    );
    
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Medidas actualizadas correctamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  Widget _infoRow({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}

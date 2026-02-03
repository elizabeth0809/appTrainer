import 'package:flutter/material.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class permissionsCard extends StatefulWidget {
  const permissionsCard({super.key});

  @override
  State<permissionsCard> createState() => _permissionsCardState();
}

class _permissionsCardState extends State<permissionsCard> {
  bool notificationsEnabled = true;
  bool shareProgress = true;
  bool darkMode = false;
  @override
Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchRow(
              icon: Icons.notifications,
              title: 'Notificacion de Entrenamientos',
              subtitle: 'Recibir notificaciones',
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            const SizedBox(height: 12),
            SwitchRow(
              icon: Icons.public,
              title: 'Compartir progreso',
              subtitle: 'Compartir en redes sociales',
              value: shareProgress,
              onChanged: (value) {
                setState(() {
                  shareProgress = value;
                });
              },
            ),
            const SizedBox(height: 12),
            SwitchRow(
              icon: Icons.dark_mode,
              title: 'Modo oscuro',
              subtitle: 'Usar tema oscuro',
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
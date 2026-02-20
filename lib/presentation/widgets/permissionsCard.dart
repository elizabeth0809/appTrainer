import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/config/theme/app_theme.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class permissionsCard extends ConsumerStatefulWidget {
  const permissionsCard({super.key});

  @override
ConsumerState<permissionsCard> createState() =>
      _permissionsCardState();
}

class _permissionsCardState extends ConsumerState<permissionsCard> {
  bool notificationsEnabled = true;
  @override
Widget build(BuildContext context){
  final isDarkMode = ref.watch(themeProvider);

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
           /* SwitchRow(
              icon: Icons.public,
              title: 'Compartir progreso',
              subtitle: 'Compartir en redes sociales',
              value: shareProgress,
              onChanged: (value) {
                setState(() {
                  shareProgress = value;
                });
              },
            ),*/
            const SizedBox(height: 12),
            SwitchRow(
              icon: Icons.dark_mode,
              title: 'Modo oscuro',
              subtitle: 'Usar tema oscuro',
              value: isDarkMode,
             onChanged: (value) {
            ref
                .read(themeProvider.notifier)
                .toggleTheme(value);
          },
            ),
          ],
        ),
      ),
    );
  }
}
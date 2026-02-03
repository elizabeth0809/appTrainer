import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Infocard extends StatelessWidget {
  const Infocard({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoRow(
              icon: Icons.folder,
              title: 'Email',
              subtitle: 'correo@correo.com',
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {context.push('/editInfo');},
              ),
            ),
            const SizedBox(height: 12),
            _infoRow(
              icon: Icons.phone,
              title: 'Telefono',
              subtitle: '(11)0000-0000',
            ),
            const SizedBox(height: 12),
            _infoRow(
              icon: Icons.memory_outlined,
              title: 'Membresia',
              subtitle: 'Platinu',
            ),
            
            const SizedBox(height: 12),
            _infoRow(
              icon: Icons.person,
              title: 'Miembro desde',
              subtitle: 'Enero 2024',
            ),
          ],
        ),
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.black)),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
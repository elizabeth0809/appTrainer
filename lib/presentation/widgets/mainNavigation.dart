import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/presentation/widgets/navItem.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFE9FBFF), 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.home,
            label: 'Inicio',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          NavItem(
            icon: Icons.calendar_month,
            label: 'Agendamiento',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          NavItem(
            icon: Icons.settings,
            label: 'Perfil',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}

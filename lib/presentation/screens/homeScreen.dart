import 'package:flutter/material.dart';
import 'package:trainer_app/presentation/screens/screen.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;

  final  pages = [HomeContent(),SchedulingCreateScreen(),SchedulingScreen(),PermissionsScreen()];
  void changePage(int index) => setState(() {
    page = index;
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),  
    );
  }
}


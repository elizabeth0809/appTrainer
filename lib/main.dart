import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/config/router/app_router.dart';
import 'package:trainer_app/config/theme/app_theme.dart';

void main() async {
// Inicializa el binding de Flutter antes de cualquier otra cosa
  WidgetsFlutterBinding.ensureInitialized();
  // Ejecuta la aplicación
 runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '<App Trainer>',
      theme: AppTheme().getTheme(),
     routerConfig: router,
    );
  }
}

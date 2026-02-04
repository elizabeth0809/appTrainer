import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/config/router/app_router.dart';
import 'package:trainer_app/config/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
// Inicializa el binding de Flutter antes de cualquier otra cosa
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  // Ejecuta la aplicación
 runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '<App Trainer>',
      theme: AppTheme().getTheme(),
      routerConfig: router,
      
      // === AGREGA ESTO ===
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Muy importante para el error que ves
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // Español
        Locale('en', 'US'), // Inglés por si acaso
      ],
      locale: const Locale('es', 'ES'), // Fuerza el idioma a español
      // ===================
    );
  }
}

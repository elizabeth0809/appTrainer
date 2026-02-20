import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false); // false = light

  void toggleTheme(bool value) {
    state = value;
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, bool>(
        (ref) => ThemeNotifier());
const colorSeed = Colors.blue;
class AppTheme {
final bool isDarkmode;
 AppTheme({ required this.isDarkmode });
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    scaffoldBackgroundColor: isDarkmode
      ? const Color(0xFF121212) // negro moderno
      : Colors.white,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    // Text (fuente nativa: Roboto)
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      titleMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
      ),
    ),
cardTheme: CardThemeData(
  color: isDarkmode
      ? const Color(0xFF1E1E1E)
      : Colors.white,
),
    // AppBar
    appBarTheme:  AppBarTheme(
       backgroundColor:
      isDarkmode ? const Color(0xFF121212) : Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: isDarkmode ? const Color(0xFF121212) : Colors.white
      ),
    ),
    //textformfield
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Color.fromARGB(255, 1, 31, 55)),
      hintStyle: TextStyle(color: Color.fromARGB(255, 3, 22, 38)),
      prefixIconColor: colorSeed,
      suffixIconColor: colorSeed,

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorSeed),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorSeed, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),
  );
}

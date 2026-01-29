import 'package:flutter/material.dart';

const colorSeed = Colors.blue;
const scaffoldBackgroundColor = Colors.white;

class AppTheme {

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    scaffoldBackgroundColor: scaffoldBackgroundColor,

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

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
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

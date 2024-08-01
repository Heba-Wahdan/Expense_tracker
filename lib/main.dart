import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 66, 108, 171),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
    error: const Color.fromARGB(255, 129, 56, 56),
    secondary: const Color.fromARGB(255, 167, 149, 181),
    primaryContainer: const Color.fromARGB(255, 255, 255, 255),
    primary: const Color.fromARGB(255, 82, 52, 87),
    tertiary: const Color.fromARGB(255, 125, 104, 129),
    seedColor: const Color.fromARGB(255, 90, 57, 100),
    brightness: Brightness.dark);
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          titleTextStyle: const TextStyle(fontSize: 24),
          backgroundColor: kDarkColorScheme.primary,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.tertiary,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: kDarkColorScheme.primaryContainer,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.onBackground,
          ),
        )),
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        titleTextStyle: const TextStyle(fontSize: 24),
        backgroundColor: kColorScheme.onSecondaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.primaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.onSecondaryContainer,
          foregroundColor: Colors.white,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: kColorScheme.onSecondaryContainer,
            ),
          ),
    ),
    themeMode: ThemeMode.system,
    home: const Expenses(),
  ));
}

import 'package:flutter/material.dart';

abstract final class AppTheme {
  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      );

  static final pageTransitionTheme = PageTransitionsTheme(
    builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
      TargetPlatform.values,
      value: (_) => const FadeForwardsPageTransitionsBuilder(),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.light,
    ),
    inputDecorationTheme: _inputDecorationTheme,
    pageTransitionsTheme: pageTransitionTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: _inputDecorationTheme,
    pageTransitionsTheme: pageTransitionTheme,
  );
}

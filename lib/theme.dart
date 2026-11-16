import 'package:flutter/material.dart';

const ink = Color(0xFF181918);
const muted = Color(0xFF6B706F);
const yellow = Color(0xFFFFCC00);
const cream = Color(0xFFFFF6CD);
const surface = Color(0xFFF7F8F5);
const line = Color(0xFFE5E7E4);

ThemeData buildTheme() => ThemeData(
  useMaterial3: true,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: yellow,
    primary: ink,
    secondary: yellow,
    surface: Colors.white,
    onSurface: ink,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 14, color: ink, letterSpacing: 0),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.45,
      color: ink,
      letterSpacing: 0,
    ),
    bodySmall: TextStyle(fontSize: 12, height: 1.4, color: muted),
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: ink,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: ink,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: surface,
    hintStyle: const TextStyle(fontSize: 14, color: muted),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: yellow, width: 2),
    ),
    errorMaxLines: 3,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: yellow,
      foregroundColor: ink,
      minimumSize: const Size(0, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ink,
      side: const BorderSide(color: line),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: ink),
  ),
  dividerColor: line,
);

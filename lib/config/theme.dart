import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF00796B),
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(centerTitle: true),
  cardTheme: CardThemeData(clipBehavior: Clip.antiAlias),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  dataTableTheme: DataTableThemeData(
    columnSpacing: 24,
    headingRowHeight: 48,
    dataRowMinHeight: 48,
    dataRowMaxHeight: 56,
  ),
);

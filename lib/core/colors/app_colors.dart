import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds
  static const Color background = Color(0xFFF5F5FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardElevated = Color(0xFFEEEEFF);

  // Brand
  static const Color primary = Color(0xFF5B21B6);
  static const Color primaryLight = Color(0xFF7C3AED);
  static const Color secondary = Color(0xFF4338CA);

  // Gradients
  static const List<Color> primaryGradient = [
    Color(0xFF5B21B6),
    Color(0xFF4338CA),
  ];
  static const List<Color> headerGradient = [
    Color(0xFF5B21B6),
    Color(0xFF3730A3),
  ];
  static const List<Color> fabGradient = [Color(0xFF7C3AED), Color(0xFF5B21B6)];

  // Category Gradients (same as before — these work on both themes)
  static const List<Color> foodGradient = [
    Color(0xFFFF6B6B),
    Color(0xFFEE5A24),
  ];
  static const List<Color> travelGradient = [
    Color(0xFF74B9FF),
    Color(0xFF0984E3),
  ];
  static const List<Color> shoppingGradient = [
    Color(0xFFFD79A8),
    Color(0xFFE84393),
  ];
  static const List<Color> entertainmentGradient = [
    Color(0xFFA29BFE),
    Color(0xFF6C5CE7),
  ];
  static const List<Color> healthGradient = [
    Color(0xFF55EFC4),
    Color(0xFF00B894),
  ];
  static const List<Color> billsGradient = [
    Color(0xFFFDCB6E),
    Color(0xFFE17055),
  ];
  static const List<Color> transportGradient = [
    Color(0xFF81ECEC),
    Color(0xFF00CEC9),
  ];
  static const List<Color> othersGradient = [
    Color(0xFFDFE6E9),
    Color(0xFFB2BEC3),
  ];

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFFCBD5E1);

  // Semantic
  static const Color income = Color(0xFF059669);
  static const Color expense = Color(0xFFDC2626);
  static const Color incomeBackground = Color(0xFFECFDF5);
  static const Color expenseBackground = Color(0xFFFEF2F2);

  // Borders
  static const Color borderPrimary = Color(0xFFE2E8F0);
  static const Color borderSecondary = Color(0xFFCBD5E1);
  static const Color borderGlow = Color(0x405B21B6);
}

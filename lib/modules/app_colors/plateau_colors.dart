// lib/modules/app_colors/plateau_colors.dart
import 'package:flutter/material.dart';

class PlateauColors {
  static const Color primaryColor = Color(0xFF009300); // Main green from gradient start
  static const Color darkGreen = Color(0xFF022102);   // Dark green from gradient end
  static Color lightGreen = const Color(0xFF009300).withOpacity(0.1); // Adjusted for a softer light green
  static const Color backgroundColor = Color(0xFFF8F8F8); // A light grey background often seen in apps
  static const Color greyText = Color(0xFF8A8A8A); // Grey text color from sign-in screen
  static const Color toggleBackground = Color(0xFFECF3ED); // A specific lighter green for the toggle background
}
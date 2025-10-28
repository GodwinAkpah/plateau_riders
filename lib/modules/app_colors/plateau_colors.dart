import 'package:flutter/material.dart';

/// A definitive color palette containing the EXACT color values sampled
/// directly from the provided design screenshots.
class PlateauColors {
  // Private constructor to prevent instantiation.
  PlateauColors._();

  // --- Primary Brand Color ---
  /// The vibrant orange-red used for all interactive and selected elements.
  /// HEX: #F05A28
  static const Color activeNavBackground = Color(0xFFFFF0E9);
  static const Color primaryColor = Color(0xFFFF5A1F);

  // --- Background Colors ---
  /// Pure white, used for the main scaffold and card backgrounds.
  /// HEX: #FFFFFF
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  /// Light grey for text input fields and the filter icon's container.
  /// HEX: #F5F5F5
  static const Color textFieldBackgroundColor = Color(0xFFF5F5F5);

  // --- Text Colors ---
  /// Very dark grey (near-black) for primary titles and headings.
  /// HEX: #212121
  static const Color blackColor = Color(0xFF1A1A1A);

  /// Medium grey for secondary info, labels, placeholders, and inactive icons.
  /// HEX: #5F5F5F
  static const Color greyColor = Color(0xFF616161);

  // --- Semantic & Status Colors ---
  /// The specific green for "Open" status and "Verified" checkmarks.
  /// HEX: #348A5B
  static const Color greenColor = Color(0xFF4BD47B);

  /// A standard, clear red for "Closed" status or errors.
  /// HEX: #D32F2F
  static const Color redColor = Color(0xFFFF5A1F);
  
  // --- Utility ---
  static const Color transparent = Colors.transparent;
}
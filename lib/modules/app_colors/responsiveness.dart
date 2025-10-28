import 'package:flutter/widgets.dart';

extension Responsive on BuildContext {
  static const double referenceWidth = 390; // iPhone 12 width
  static const double referenceHeight = 844; // iPhone 12 height

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  // ignore: deprecated_member_use
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
  bool get isPortrait => screenHeight > screenWidth;
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // Base scale ratios
  double get _scaleWidth => screenWidth / referenceWidth;
  double get _scaleHeight => screenHeight / referenceHeight;

  double get _scale => _scaleWidth;

  double scaleWidth(double width) =>
      (width * _scale).clamp(0.8 * width, 1.2 * width);

  double scaleHeight(double height) =>
      (height * _scaleHeight).clamp(0.8 * height, 1.2 * height);

  double scaleText(double size) =>
      (size * _scale).clamp(0.9 * size, 1.1 * size) / textScaleFactor;

  double scaleImage(double size) =>
      (size * _scale).clamp(0.8 * size, 1.2 * size);

  EdgeInsets get defaultPadding => EdgeInsets.symmetric(
    horizontal: scaleWidth(16),
    vertical: scaleHeight(12),
  );

  // --- FIX IS HERE ---
  /// Scale spacing like margins, gaps. This now correctly handles negative numbers.
  double scaleSpacing(double space) {
    final scaledValue = space * _scale;
    // Check if the number is negative.
    if (space < 0) {
      // For negative numbers, the clamp bounds must be reversed.
      return scaledValue.clamp(1.2 * space, 0.8 * space);
    } else {
      // For positive numbers, the original logic is correct.
      return scaledValue.clamp(0.8 * space, 1.2 * space);
    }
  }

  BoxConstraints dynamicConstraints({
    double minWidth = 0,
    double minHeight = 0,
    double? maxWidth,
    double? maxHeight,
  }) {
    return BoxConstraints(
      minWidth: scaleWidth(minWidth),
      minHeight: scaleHeight(minHeight),
      maxWidth: maxWidth != null ? scaleWidth(maxWidth) : double.infinity,
      maxHeight: maxHeight != null ? scaleHeight(maxHeight) : double.infinity,
    );
  }
}

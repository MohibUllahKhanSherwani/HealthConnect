import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  // Primary colors
  static const Color primaryLight = Color(0xFF9B80F3);
  static const Color primaryDark = Color(0xFF6D48E5);
  static const Color primaryContainerLight = Color(0xFFEAE4FF);
  static const Color primaryContainerDark = Color(0xFFEAE4EE);
  static const Color onPrimaryContainerLight = Color(0xFF4527A0);
  static const Color onPrimaryContainerDark = Color(0xFF4527AA);

  // Secondary colors
  static const Color secondaryLight = Color(0xFF64B5F6);
  static const Color secondaryDark = Color(0xFF1976D2);
  static const Color secondaryContainerLight = Color(0xFFE3F2FD);
  static const Color secondaryContainerDark = Color(0xFFE3F2F8);
  static const Color onSecondaryContainerLight = Color(0xFF0D47A1);
  static const Color onSecondaryContainerDark = Color(0xFF0D47AB);

  // Accent colors
  static const Color accentLight = Color(0xFF4CAF50);
  static const Color accentDark = Color(0xFF2E7D32);
  static const Color accentContainerLight = Color(0xFFE8F5E9);
  static const Color accentContainerDark = Color(0xFFE8F5EE);
  static const Color onAccentContainerLight = Color(0xFF1B5E20);
  static const Color onAccentContainerDark = Color(0xFF1B5E2A);

  // Error colors
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFD32F2F);
  static const Color errorContainerLight = Color(0xFFFFEBEE);
  static const Color errorContainerDark = Color(0xFFFFEBEA);
  static const Color onErrorContainerLight = Color(0xFFB71C1C);
  static const Color onErrorContainerDark = Color(0xFFB71C2C);

  // Warning colors
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);
  static const Color warningContainerLight = Color(0xFFFFF3E0);
  static const Color warningContainerDark = Color(0xFFFFF3E8);
  static const Color onWarningContainerLight = Color(0xFFE65100);
  static const Color onWarningContainerDark = Color(0xFFE6511A);

  // Success colors
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);
  static const Color successContainerLight = Color(0xFFE8F5E9);
  static const Color successContainerDark = Color(0xFFE8F5EE);
  static const Color onSuccessContainerLight = Color(0xFF1B5E20);
  static const Color onSuccessContainerDark = Color(0xFF1B5E2A);

  // Neutral colors
  static const Color neutralLight = Color(0xFFEEEEEE);
  static const Color neutralMedium = Color(0xFFBDBDBD);
  static const Color neutralDark = Color(0xFF757575);
  static const Color neutralDarker = Color(0xFF424242);

  // Background colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF303030);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF424242);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFBDBDBD);

  // Card colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF424242);
  static const Color cardBorderLight = Color(0xFFE0E0E0);
  static const Color cardBorderDark = Color(0xFF616161);

  // Specialty category colors
  static const Map<String, Color> specialtyColors = {
    'Cardiology': Color(0xFFEF5350),
    'Neurology': Color(0xFF42A5F5),
    'Dermatology': Color(0xFFFFCA28),
    'Orthopedics': Color(0xFF66BB6A),
    'Pediatrics': Color(0xFF9575CD),
    'General': Color(0xFF78909C),
  };

  // Get specialty color with fallback
  static Color getSpecialtyColor(String specialty) {
    return specialtyColors[specialty] ?? specialtyColors['General']!;
  }
}

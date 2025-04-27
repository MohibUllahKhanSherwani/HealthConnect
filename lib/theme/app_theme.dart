import 'package:flutter/material.dart';
import 'app_colors.dart';
import '../constants/specializations.dart';

/// Extension to add specialty colors to ThemeData
extension SpecialtyThemeColors on ThemeData {
  // Access to specialty colors map
  Map<String, Color> get specialtyColors => _specialtyColors;

  // Convenience method to get a specialty color by name
  Color getSpecialtyColor(String specialty) =>
      _specialtyColors[specialty] ?? Colors.grey;

  // Individual specialty colors for direct access
  Color get cardiologyColor => _specialtyColors['Cardiology'] ?? Colors.grey;
  Color get neurologyColor => _specialtyColors['Neurology'] ?? Colors.grey;
  Color get dermatologyColor => _specialtyColors['Dermatology'] ?? Colors.grey;
  Color get orthopedicsColor => _specialtyColors['Orthopedics'] ?? Colors.grey;
  Color get pediatricsColor => _specialtyColors['Pediatrics'] ?? Colors.grey;
  Color get generalColor => _specialtyColors['General Medicine'] ?? Colors.grey;

  // Card colors
  Color get cardBackground =>
      brightness == Brightness.light ? AppColors.cardLight : AppColors.cardDark;

  Color get cardBorder => brightness == Brightness.light
      ? AppColors.cardBorderLight
      : AppColors.cardBorderDark;
}

// Define colors for each specialization
final Map<String, Color> _specialtyColors = {
  for (var specialization in Specializations.all)
    specialization: _generateColorForSpecialization(specialization),
};

// Function to generate a color for a specialization (simple hash to color)
Color _generateColorForSpecialization(String specialization) {
  final hash =
      specialization.codeUnits.fold<int>(0, (prev, elem) => prev + elem);
  final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.cyan,
    Colors.amber,
    Colors.indigo,
    Colors.lime,
    Colors.pink,
    Colors.brown,
  ];
  return colors[hash % colors.length];
}

/// Light theme for the app
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,

  // Color scheme
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryDark,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryContainerLight,
    onPrimaryContainer: AppColors.onPrimaryContainerLight,
    secondary: AppColors.secondaryDark,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.secondaryContainerLight,
    onSecondaryContainer: AppColors.onSecondaryContainerLight,
    tertiary: AppColors.accentDark,
    onTertiary: Colors.white,
    tertiaryContainer: AppColors.accentContainerLight,
    onTertiaryContainer: AppColors.onAccentContainerLight,
    error: AppColors.errorDark,
    onError: Colors.white,
    errorContainer: AppColors.errorContainerLight,
    onErrorContainer: AppColors.onErrorContainerLight,
    background: AppColors.backgroundLight,
    onBackground: AppColors.textPrimaryLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    surfaceVariant: AppColors.neutralLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    outline: AppColors.neutralMedium,
    shadow: Colors.black.withOpacity(0.1),
  ),

  // Text theme
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.textPrimaryLight,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.textPrimaryLight,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryDark,
    ),
  ),

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryDark,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  // Button themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
      side: BorderSide(color: AppColors.primaryDark, width: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceLight,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.neutralMedium),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.neutralMedium),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.errorDark),
    ),
    labelStyle: TextStyle(color: AppColors.textSecondaryLight),
    hintStyle: TextStyle(color: AppColors.textSecondaryLight),
  ),

  // Card theme
  cardTheme: CardTheme(
    color: AppColors.surfaceLight,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  ),

  // Bottom navigation bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    selectedItemColor: AppColors.primaryDark,
    unselectedItemColor: AppColors.neutralDark,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Scaffold background color
  scaffoldBackgroundColor: AppColors.backgroundLight,
);

/// Dark theme for the app
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,

  // Color scheme
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryLight,
    onPrimary: Colors.black,
    primaryContainer: AppColors.primaryContainerDark,
    onPrimaryContainer: AppColors.onPrimaryContainerDark,
    secondary: AppColors.secondaryLight,
    onSecondary: Colors.black,
    secondaryContainer: AppColors.secondaryContainerDark,
    onSecondaryContainer: AppColors.onSecondaryContainerDark,
    tertiary: AppColors.accentLight,
    onTertiary: Colors.black,
    tertiaryContainer: AppColors.accentContainerDark,
    onTertiaryContainer: AppColors.onAccentContainerDark,
    error: AppColors.errorLight,
    onError: Colors.black,
    errorContainer: AppColors.errorContainerDark,
    onErrorContainer: AppColors.onErrorContainerDark,
    background: AppColors.backgroundDark,
    onBackground: AppColors.textPrimaryDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    surfaceVariant: AppColors.neutralDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: AppColors.neutralMedium,
    shadow: Colors.black.withOpacity(0.3),
  ),

  // Text theme
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.textPrimaryDark,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.textPrimaryDark,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryLight,
    ),
  ),

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.textPrimaryDark,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryDark,
    ),
    iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
  ),

  // Button themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      side: BorderSide(color: AppColors.primaryLight, width: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceDark,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.neutralMedium),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.neutralMedium),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.errorLight),
    ),
    labelStyle: TextStyle(color: AppColors.textSecondaryDark),
    hintStyle: TextStyle(color: AppColors.textSecondaryDark),
  ),

  // Card theme
  cardTheme: CardTheme(
    color: AppColors.surfaceDark,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  ),

  // Bottom navigation bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primaryLight,
    unselectedItemColor: AppColors.neutralLight,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Scaffold background color
  scaffoldBackgroundColor: AppColors.backgroundDark,
);

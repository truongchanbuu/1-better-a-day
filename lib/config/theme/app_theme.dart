import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/app_font_size.dart';
import '../../core/constants/app_size.dart';
import '../../core/constants/app_spacing.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      appBarTheme: _appBarTheme(isLight: true),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      snackBarTheme: _snackBarTheme(),
      textTheme: _textTheme(isLight: true),
      elevatedButtonTheme: _elevatedButtonTheme(),
      cardTheme: _cardTheme(),
      bottomSheetTheme: _bottomSheetTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      appBarTheme: _appBarTheme(isLight: false),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      textTheme: _textTheme(isLight: false),
      elevatedButtonTheme: _elevatedButtonTheme(),
      snackBarTheme: _snackBarTheme(),
      cardTheme: _cardTheme(),
      bottomSheetTheme: _bottomSheetTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
    );
  }

  static AppBarTheme _appBarTheme({required bool isLight}) {
    return AppBarTheme(
        backgroundColor: isLight ? AppColors.primary : AppColors.primaryDark,
        elevation: 10,
        iconTheme: const IconThemeData(color: AppColors.lightText));
  }

  static TextTheme _textTheme({required bool isLight}) {
    Color textColor = isLight ? AppColors.darkText : AppColors.lightText;
    return TextTheme(
      displayLarge: TextStyle(
        color: textColor,
        fontSize: AppFontSize.h1,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: textColor,
        fontSize: AppFontSize.h2,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: textColor,
        fontSize: AppFontSize.h3,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: textColor,
        fontSize: AppFontSize.labelLarge,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontSize: AppFontSize.labelMedium,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: AppFontSize.labelSmall,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: AppFontSize.bodyLarge,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: AppFontSize.bodyMedium,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontSize: AppFontSize.bodySmall,
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSpacing.radiusS),
          ),
        ),
        backgroundColor: AppColors.primary,
        minimumSize: const Size.fromHeight(AppSize.defaultButtonHeight),
        textStyle: const TextStyle(
          color: AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static BottomSheetThemeData _bottomSheetTheme() {
    return const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
      ),
    );
  }

  static SnackBarThemeData _snackBarTheme() {
    return const SnackBarThemeData(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      hintStyle: TextStyle(color: AppColors.grayText),
    );
  }
}

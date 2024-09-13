import 'package:flutter/material.dart';
import 'package:hotline_app/utils/colors.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        appBarTheme: const AppBarTheme(
            color: AppColors.appBarBg,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: AppColors.textColor,
            )),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            backgroundColor: WidgetStatePropertyAll(AppColors.buttonColor),
            overlayColor: WidgetStatePropertyAll(AppColors.buttonSplashColor),
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: AppColors.scaffoldBg,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: AppColors.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}

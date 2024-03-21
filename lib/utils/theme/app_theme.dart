import 'package:flutter/material.dart';
import 'theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: Colors.transparent,
      ),
      fontFamily: "DMSans",
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 28, color: primaryColor),
        displayMedium: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 26, color: primaryColor),
        displaySmall: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 24, color: secondaryColor),
        headlineLarge: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 20, color: secondaryColor),
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 20, color: secondaryColor),
        headlineSmall: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: secondaryColor),
        titleLarge: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 16, color: secondaryColor),
        titleMedium: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: secondaryColor),
        titleSmall: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 14, color: primaryColor),
        bodyLarge: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 14, color: secondaryColor),
        bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: secondaryMediumColor),
        bodySmall: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 12, color: primaryColor),
        labelLarge: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 12, color: primaryColor),
        labelMedium: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 12, color: secondaryColor),
        labelSmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: secondaryMediumColor),
      ));
}

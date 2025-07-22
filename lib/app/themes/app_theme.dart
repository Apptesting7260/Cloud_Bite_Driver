import 'package:flutter/material.dart';

class AppTheme {
  // Colors

  static const Color transparent = Colors.transparent;

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);
  static const Color primaryColor = Color(0xFFB6568E);
  static const Color primaryColor20 = Color(0x33B6568E);
  static const Color titleTextColor = Color(0xFF212121);
  static const Color paragraphTextColor = Color(0xFF626162);
  static const Color blueColor = Color(0xFF5FB6E3);
  static const Color boxBgColor = Color(0xFFF4F5F7);
  static const Color blueColor20 = Color(0x335FB6E3);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color redText =  Color(0xFFE33629);
  static const Color hintText =  Color(0xFF929090);
  static const Color darkText =  Color(0xFF212121);
  static const Color darkText14 =  Color(0x23181725);
  static const Color yellow =  Color(0xFFE3C429);

  static const Color red =  Color.fromRGBO(227, 54, 41, 1);
  static const Color white30 =  Color.fromRGBO(255, 255, 255, 0.3);
  static const Color black10 =  Color.fromRGBO(0, 0, 0, 0.1);
  static const Color pink =  Color.fromRGBO(182, 86, 142, 1);
  static const Color lightGrey =  Color.fromRGBO(244, 245, 247, 1);
  static const Color lightText =  Color.fromRGBO(146, 144, 144, 1);
  static const Color green =  Color.fromRGBO(52, 168, 83, 1);
  static const Color grey =  Color.fromRGBO(98, 97, 98, 1);
  static const Color grey50 =  Color.fromRGBO(98, 97, 98, 0.5);
  static const Color skyColor =  Color.fromRGBO(95, 182, 227, 1);
  static const Color skyColor30 =  Color.fromRGBO(95, 182, 227, 0.3);
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFB6568E),
      Color(0xFF5FB6E3),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradientHorizontal = LinearGradient(
    colors: [
      Color(0xFFB6568E),
      Color(0xFF5FB6E3),
    ],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );

  static const LinearGradient lightGradient = LinearGradient(
    colors: [
      Color(0xFFF8EEF4),
      Color(0xFFEFF7FC),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient newLightGradient = LinearGradient(
    colors: [
      Color(0xFFF4D1E6),
      Color(0xFFE1EFF8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient disabledButton = LinearGradient(
    colors: [Colors.grey.shade400, Colors.grey.shade400],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFFB6568E),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'GeneralSans',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: titleTextColor,
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontFamily: 'GeneralSans',
        ),
        headlineMedium: TextStyle(
          color: titleTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: 'GeneralSans',
        ),
        bodyLarge: TextStyle(
          color: paragraphTextColor,
          fontSize: 16,
          fontFamily: 'GeneralSans',
        ),
        bodyMedium: TextStyle(
          color: paragraphTextColor,
          fontSize: 14,
          fontFamily: 'GeneralSans',
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: titleTextColor),
        titleTextStyle: TextStyle(
          color: titleTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'GeneralSans',
        ),
      ),
    );
  }
}

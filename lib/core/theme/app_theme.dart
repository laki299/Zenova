import 'package:flutter/material.dart';

class AppTheme {
  static const Color amoledBlack = Color(0xFF0D0D0D);
  static const Color cardGrey = Color(0xFF1E1E1E);
  static const Color accentGreen = Color(0xFF00E676);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFFA0A0A0);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: amoledBlack,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: amoledBlack,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textWhite),
        titleTextStyle: TextStyle(
          color: textWhite,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardGrey,
        selectedItemColor: accentGreen,
        unselectedItemColor: textGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}

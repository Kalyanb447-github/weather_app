import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/appcolors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blue,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        size: 25,
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 24,
      ),
      backgroundColor: AppColors.blue,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );

}

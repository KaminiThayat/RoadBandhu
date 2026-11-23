import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle headlineLarge({required bool isDark}) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle headlineMedium({required bool isDark}) => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: -0.3,
      );

  static TextStyle titleLarge({required bool isDark}) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      );

  static TextStyle titleMedium({required bool isDark}) => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      );

  static TextStyle bodyLarge({required bool isDark}) => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        height: 1.4,
      );

  static TextStyle bodyMedium({required bool isDark}) => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        height: 1.4,
      );

  static TextStyle labelSmall({required bool isDark}) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        letterSpacing: 0.2,
      );

  static TextStyle buttonText({Color color = Colors.white}) => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.3,
      );
}

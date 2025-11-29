import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String fontFamily = 'System'; // replace if using GoogleFonts

  static TextStyle title(double size) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle heading(double size) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: AppColors.textMuted,
    height: 1.45,
  );

  static const TextStyle description = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.5,
  );

  static TextStyle buttonText(double size) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle footerLink(double size) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );
}

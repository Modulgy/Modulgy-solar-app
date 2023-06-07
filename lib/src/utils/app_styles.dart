import 'package:flutter/material.dart';
import 'package:moduluenergy/src/utils/app_colors.dart';

class AppStyles {
  static const TextStyle authHeadingStyle =
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
  static const TextStyle authDescriptionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  static const TextStyle dashboardHeadingStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w800);
  static const TextStyle dashboardDescriptionStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey);
  static TextStyle textFieldStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.hintColor);
  static TextStyle textInpuStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: AppColors.textfieldColor);
  static TextStyle forgotPassword = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
}

import 'package:flutter/material.dart';
import 'package:moduluenergy/generated/l10n.dart';

String? mailValidate(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return Localized.of(context).validator_enter_email;
  }

  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp emailRegex = RegExp(pattern);

  if (!emailRegex.hasMatch(value)) {
    return Localized.of(context).validator_enter_valid_email;
  }

  return null; // Return null if the email is valid
}

String? loginPasswordValidate(String? value, BuildContext context) {
  if (value == null || value.isEmpty || value.length < 10) {
    return Localized.of(context).validator_enter_valid_password;
  }

  return null;
}

String? passwordValidate(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return Localized.of(context).validator_enter_password;
  }

  // Check if password length is at least 8 characters
  if (value.length < 10) {
    return Localized.of(context).validator_password_10_chars;
  }

  // Check if password contains at least one number
  if (!value.contains(RegExp(r'\d'))) {
    return Localized.of(context).validator_password_num;
  }

  // Check if password contains at least one lowercase letter
  if (!value.contains(RegExp(r'[a-z]'))) {
    return Localized.of(context).validator_password_lower;
  }

  // Check if password contains at least one uppercase letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return Localized.of(context).validator_password_upper;
  }

  // Check if password contains at least one special character
  if (!value.contains(RegExp(r'[!@#$£%^&*(),.?":{}|<>]'))) {
    return Localized.of(context).validator_special_char;
  }

  return null; // Return null if the password is valid
}

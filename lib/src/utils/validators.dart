String? mailValidate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address.';
  }

  // Regular expression to match email format
  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');

  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address.';
  }

  return null; // Return null if the email is valid
}

String? passwordValidate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password.';
  }

  // Check if password length is at least 8 characters
  if (value.length < 8) {
    return 'Password must be at least 8 characters long.';
  }

  // Check if password contains at least one number
  if (!value.contains(RegExp(r'\d'))) {
    return 'Password must contain at least one number.';
  }

  // Check if password contains at least one lowercase or uppercase letter
  if (!value.contains(RegExp(r'[a-zA-Z]'))) {
    return 'Password must contain at least one letter.';
  }

  return null; // Return null if the password is valid
}

import 'package:flutter/material.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';

import '../utils/app_styles.dart';
class AuthBottom extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onRedirectPressed;
  const AuthBottom({Key? key, required this.text1, required this.text2, required this.onRedirectPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Text(text1,
          style: AppStyles.textFieldStyle,
        ).marginOnly(right: 6),
        GestureDetector(
          onTap: onRedirectPressed,
          child: Text(text2,
            style: AppStyles.forgotPassword,
          ),
        ),
      ],
    );
  }
}

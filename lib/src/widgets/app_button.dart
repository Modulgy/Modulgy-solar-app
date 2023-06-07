import 'package:flutter/material.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';

import '../utils/app_colors.dart';

class ModulgyButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final ButtonState buttonState;

  const ModulgyButton({
    Key? key,
    required this.title,
    required this.buttonState,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = FilledButton.styleFrom(
      textStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      backgroundColor: AppColors.primaryColor,
      minimumSize: const Size(88, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      child: FilledButton(
        style: buttonState == ButtonState.enabled
            ? raisedButtonStyle
            : raisedButtonStyle.copyWith(
                backgroundColor: MaterialStatePropertyAll(
                    AppColors.primaryColor.withOpacity(0.5))),
        onPressed: buttonState == ButtonState.enabled ? onPressed : null,
        child: buttonState == ButtonState.loading
            ? Row(
                children: [
                  const Spacer(),
                  Text(title, style: const TextStyle(color: Colors.white))
                  .marginOnly(left: 20),
                  const Spacer(),
                  const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                ],
              )
            : Text(title),
      ),
    );
  }
}

enum ButtonState { enabled, disabled, loading }

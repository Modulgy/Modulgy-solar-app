import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';

import '../../../generated/l10n.dart';
import '../../utils/app_styles.dart';
import '../../widgets/app_button.dart';
import 'auth_provider.dart';

Widget WelcomeHeader(String headerText, String descriptionText, {TextStyle headerStyle = AppStyles.authHeadingStyle, TextStyle descriptionStyle = AppStyles.authDescriptionStyle}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Text(
      headerText,
      style: headerStyle,
      textAlign: TextAlign.start,
    ).marginBottom(headerStyle == AppStyles.authHeadingStyle ? 10 : 4),
    Text(
      descriptionText,
      textAlign: TextAlign.start,
      style: descriptionStyle,
    ),
  ]);
}

Widget ForgotPassword() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        Localized.current.forgot_password,
        style: AppStyles.forgotPassword,
      )
    ],
  );
}


class ActivationCodeField extends StatelessWidget {
  final TextEditingController controller;

  ActivationCodeField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: Localized.of(context).enter_activation_code,
      ),
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

ButtonState getButtonState(Status status) {
  ButtonState result = ButtonState.enabled;
  switch (status) {
    case Status.NotAuthenticated:
      result = ButtonState.enabled;
      break;
    case Status.Authenticated:
      result = ButtonState.enabled;
      break;
    case Status.Authenticating:
      result = ButtonState.loading;
      break;
  }
  return result;
}

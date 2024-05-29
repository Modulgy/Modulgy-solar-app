import 'package:flutter/material.dart';
import 'package:moduluenergy/src/network/result.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/utils/validators.dart';
import 'package:moduluenergy/src/widgets/global_margin.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../widgets/app_button.dart';
import '../../widgets/auth_bottom.dart';
import '../../widgets/auth_textfield.dart';
import 'auth_provider.dart';
import 'login_components.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  String _email = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalMarginWrapper(
          child: Form(
        key: _formKey,
        child: BodyWidget(),
      )),
    );
  }

  Widget BodyWidget() {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        WelcomeHeader(Localized.of(context).provide_email,
                Localized.of(context).provide_email_text,
                descriptionStyle: AppStyles.textFieldStyle)
            .marginBottom(80),
        ModulgyTextField(
          hintText: Localized.of(context).email_hint,
          label: Localized.of(context).email_label,
          prefix: 'assets/mail.svg',
          validator: (value) => mailValidate(value, context),
          onSaved: (value) => _email = value ?? "",
        ).marginBottom(20),
        ModulgyButton(
                title: Localized.of(context).send_code,
                onPressed: onSendCodePressed,
                buttonState: getButtonState(auth.loggedInStatus))
            .marginOnly(bottom: 30),
        AuthBottom(
          text1: Localized.of(context).remember_password,
          text2: Localized.of(context).back_to_login,
          onRedirectPressed: () => {
            Navigator.pushReplacementNamed(
              context,
              ModulgyRoute.login.getRoute(),
            ),
          },
        ),
      ],
    );
  }

  void onSendCodePressed() {
    final form = _formKey.currentState;
    if (form?.validate() == true) {
      form?.save();
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      auth.passwordReset(_email).then((result) {
        if (result is Success) {
          Navigator.pushReplacementNamed(
              context, ModulgyRoute.forgotPassword.getRoute(),
              arguments: _email);
        } else {
          var userErrorMessage = "";
          switch ((result as Error).errorCode) {
            case 401:
              userErrorMessage =
                  Localized.of(context).invalid_email_or_password_error;
              break;
            default:
              userErrorMessage = Localized.of(context)
                  .getByErrorType(result.errorMessage, result.errorType);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userErrorMessage),
            ),
          );
        }
      });
    }
  }
}

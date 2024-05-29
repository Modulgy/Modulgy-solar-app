import 'package:flutter/material.dart';
import 'package:moduluenergy/src/network/result.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _activationCode = "";
  String _newPassword = "";
  String _confirmNewPassword = "";
  String _email = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String? args = ModalRoute.of(context)?.settings.arguments as String?;

    if (args != null) {
      _email = args;
    }

    return Scaffold(
      body: GlobalMarginWrapper(
        child: Form(
          key: _formKey,
          child: BodyWidget(),
        ),
      ),
    );
  }

  Widget BodyWidget() {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        WelcomeHeader(
          Localized.of(context).forgot_password,
          Localized.of(context).reset_password,
        ).marginBottom(60),
        ModulgyTextField(
          hintText: Localized.of(context).activation_code_hint,
          label: Localized.of(context).activation_code_label,
          //keyboardType: TextInputType.number,
          validator: /*kDebugMode ? null : numberValidate*/ null,
          onSaved: (value) => _activationCode = value ?? "",
        ).marginBottom(20),
        ModulgyTextField(
          hintText: Localized.of(context).new_password_hint,
          label: Localized.of(context).new_password_label,
          obscureText: true,
          validator: (value) => passwordValidate(value, context),
          onChanged: (newValue) => _newPassword = newValue ?? "",
        ).marginBottom(20),
        ModulgyTextField(
          hintText: Localized.of(context).confirm_new_password_hint,
          label: Localized.of(context).confirm_new_password_label,
          obscureText: true,
          validator: (value) {
            if (value != _newPassword) {
              return Localized.of(context).password_mismatch_error;
            }
            return null;
          },
          onSaved: (value) => _confirmNewPassword = value ?? "",
        ).marginBottom(15),
        ModulgyButton(
          title: Localized.of(context).reset_password_button,
          onPressed: onResetPasswordPressed,
          buttonState: getButtonState(auth.loggedInStatus),
        ).marginOnly(bottom: 30),
        AuthBottom(
          text1: Localized.of(context).no_code,
          text2: Localized.of(context).resend_text,
          onRedirectPressed: () => {onCodeResend(context, auth, _email)},
        ).marginBottom(10),
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

  void onCodeResend(BuildContext context, AuthProvider auth, String email) {
    auth.passwordReset(_email).then((result) {
      if (result is! Success) {
        var userErrorMessage = "";
        switch ((result as Error).errorCode) {
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Localized.of(context).reset_code_resent),
          content: Text(Localized.of(context).reset_code_resent_info),
          actions: [
            TextButton(
              child: Text(Localized.of(context).i_understand),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onResetPasswordPressed() {
    final form = _formKey.currentState;
    if (form?.validate() == true) {
      form?.save();
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      auth
          .passwordChange(
              _activationCode, _email, _newPassword, _confirmNewPassword)
          .then((result) {
        if (result is Success) {
          Navigator.pushReplacementNamed(context, ModulgyRoute.home.getRoute());
          auth.login(_email, _newPassword).then((result) {
            if (result is Success) {
              Navigator.pushReplacementNamed(
                  context, ModulgyRoute.home.getRoute());
            } else {
              var userErrorMessage = "";
              if (result is Error) {
                userErrorMessage = Localized.of(context)
                    .getByErrorType(result.errorMessage, result.errorType);
              } else {
                userErrorMessage = 'Unknown error';
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(userErrorMessage),
                ),
              );
            }
          });
        }
      }).catchError((Object err) {
        var userErrorMessage = "";
        if (err is Error) {
          userErrorMessage = err.errorMessage;
        } else {
          userErrorMessage = 'Unknown error';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(userErrorMessage),
          ),
        );
      });
    }
  }
}

import 'package:flutter/material.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        ).marginBottom(100),
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
          validator: passwordValidate,
          onSaved: (value) => _newPassword = value ?? "",
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

  void onResetPasswordPressed() {
    final form = _formKey.currentState;
    if (form?.validate() == true) {
      form?.save();
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      /*auth.resetPassword(
        _activationCode,
        _newPassword,
      ).then((result) {
        if (result is Success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Localized.of(context).password_reset_success),
            ),
          );
          Navigator.pushReplacementNamed(
            context,
            ModulgyRoute.login.getRoute(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.errorMessage),
            ),
          );
        }
      });*/
    }
  }
}

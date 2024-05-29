import 'package:flutter/material.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/views/auth/login_components.dart';
import 'package:moduluenergy/src/widgets/global_margin.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../network/result.dart';
import '../../utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/auth_bottom.dart';
import '../../widgets/auth_textfield.dart';
import 'auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email = "";
  String _password = "";
  String _confirmNewPassword = "";

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
        WelcomeHeader(Localized.of(context).signup_button,
                Localized.of(context).create_account_text)
            .marginBottom(40),
        ModulgyTextField(
          hintText: Localized.of(context).email_hint,
          label: Localized.of(context).email_label,
          prefix: 'assets/mail.svg',
          validator: /*kDebugMode ? null : mailValidate,*/ null,
          onSaved: (value) => _email = value ?? "",
        ).marginBottom(20),
        ModulgyTextField(
          hintText: Localized.of(context).password_hint,
          label: Localized.of(context).password_label,
          obscureText: true,
          validator: (value) => passwordValidate(value, context),
          onChanged: (value) => _password = value ?? "",
        ).marginBottom(15),
        ModulgyTextField(
          hintText: Localized.of(context).confirm_new_password_hint,
          label: Localized.of(context).confirm_new_password_label,
          obscureText: true,
          validator: (value) {
            if (value != _password) {
              return Localized.of(context).password_mismatch_error;
            }
            return null;
          },
          onSaved: (value) => _confirmNewPassword = value ?? "",
        ).marginBottom(15),
        buildPasswordRequirementsWidget().marginBottom(60),
        ModulgyButton(
                title: Localized.of(context).signup_button,
                buttonState: getButtonState(auth.registeredInStatus),
                onPressed: onSignUpPressed)
            .marginOnly(bottom: 30),
        AuthBottom(
          text1: Localized.of(context).existing_account,
          text2: Localized.of(context).signin_button,
          onRedirectPressed: () =>
              {Navigator.pushNamed(context, ModulgyRoute.login.getRoute())},
        )
      ],
    );
  }

  Widget buildPasswordRequirementsWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 16.0),
      child: Text(
        Localized.current.password_requirements,
        style: const TextStyle(fontSize: 14.0, color: Colors.grey),
      ),
    );
  }

  void onSignUpPressed() {
    final form = _formKey.currentState;
    debugPrint("form: $form");
    if (form?.validate() == true) {
      form?.save();
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      auth.register(_email, _password).then((result) {
        if (result is Success) {
          Navigator.pushNamed(context, ModulgyRoute.activate.getRoute(),
              arguments: AuthRequest(
                  type: 'user', email: _email, password: _password));
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
  }
}

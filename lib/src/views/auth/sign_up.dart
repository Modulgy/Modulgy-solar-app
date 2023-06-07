import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/views/auth/login_components.dart';
import 'package:moduluenergy/src/widgets/global_margin.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../network/result.dart';
import '../../utils/app_colors.dart';
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
  String _username = "";
  String _email = "";
  String _password = "";

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
          WelcomeHeader('Sign Up', 'Create account and enjoy services')
              .marginBottom(100),
          ModulgyTextField(
            hintText: 'Username',
            label: 'Type your Username',
            prefix: 'assets/user.svg',
            validator: (value) =>
                value?.isEmpty == true ? 'Please enter a valid username.' : null,
            onSaved: (value) => _username = value ?? "",
          ).marginBottom(20),
          ModulgyTextField(
            hintText: 'Email here',
            label: 'Type your email',
            prefix: 'assets/mail.svg',
            validator: kDebugMode ? null : mailValidate,
            onSaved: (value) => _email = value ?? "",
          ).marginBottom(20),
          ModulgyTextField(
            hintText: 'Password here',
            label: 'Type your password',
            obscureText: true,
            validator: passwordValidate,
            onSaved: (value) => _password = value ?? "",
          ).marginBottom(15),
          ForgotPassword().marginBottom(80),
          ModulgyButton(
              title: "Sign Up",
              buttonState: getButtonState(auth.registeredInStatus),
              onPressed: onSignUpPressed).marginOnly(bottom: 30),
          AuthBottom(
            text1: 'Have an account?',
            text2: 'Sign In',
            onRedirectPressed: () =>
                {Navigator.pushNamed(context, ModulgyRoute.login.getRoute())},
          )
        ],
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
              arguments: AuthRequest(type: 'user', email: _email, password: _password));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((result as Error).errorMessage),
            ),
          );
        }
      });
    }
  }
}

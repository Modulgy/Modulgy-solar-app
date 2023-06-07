import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moduluenergy/src/network/result.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/utils/validators.dart';
import 'package:moduluenergy/src/widgets/global_margin.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../widgets/app_button.dart';
import '../../widgets/auth_bottom.dart';
import '../../widgets/auth_textfield.dart';
import 'auth_provider.dart';
import 'login_components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
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
        WelcomeHeader(
          'Welcome Back!',
          'Sign In to your account',
        ).marginBottom(100),
        ModulgyTextField(
          hintText: 'Email here',
          label: 'Type your email',
          prefix: 'assets/mail.svg',
          validator: kDebugMode ? null : mailValidate,
          onSaved: (value) => _username = value ?? "",
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
                title: "Sign In",
                onPressed: onLoginPressed,
                buttonState: getButtonState(auth.loggedInStatus))
            .marginOnly(bottom: 30),
        AuthBottom(
          text1: 'Don\'t have account?',
          text2: 'Sign Up',
          onRedirectPressed: () =>
              {Navigator.pushNamed(context, ModulgyRoute.signup.getRoute())},
        )
      ],
    );
  }

  void onLoginPressed() {
    final form = _formKey.currentState;
    if (form?.validate() == true) {
      form?.save();
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      auth.login(_username, _password).then((result) {
        if (result is Success) {
          Navigator.pushReplacementNamed(context, ModulgyRoute.home.getRoute());
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

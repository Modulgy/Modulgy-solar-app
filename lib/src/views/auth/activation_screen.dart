import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../network/result.dart';
import '../../widgets/app_button.dart';
import '../../widgets/auth_bottom.dart';
import '../../widgets/global_margin.dart';
import 'auth_provider.dart';
import 'login_components.dart';

class ActivationCodeScreen extends StatefulWidget {
  const ActivationCodeScreen({Key? key}) : super(key: key);

  @override
  State<ActivationCodeScreen> createState() => _ActivationCodeScreenState();
}

class _ActivationCodeScreenState extends State<ActivationCodeScreen> {
  String _activationCode = "";

  final _formKey = GlobalKey<FormState>();
  final _activationCodeController = TextEditingController();

  AuthRequest? _arguments;

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context)?.settings.arguments as AuthRequest;
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
        WelcomeHeader('Verify Code', 'Please enter the code we just sent to your email address')
            .marginBottom(100),
        ActivationCodeField(controller: _activationCodeController)
            .marginBottom(20),
        ModulgyButton(
            title: "Activate",
            buttonState: getButtonState(auth.registeredInStatus),
            onPressed: onActivationCodePressed
        ).marginOnly(bottom: 30),
        AuthBottom(
          text1: 'Haven’t received a code?',
          text2: 'Resend',
          onRedirectPressed: () => { /* resend code logic goes here */ },
        )
      ],
    );
  }

  void onActivationCodePressed() {
    final form = _formKey.currentState;
    final email = _arguments?.email ?? "";
    final password = _arguments?.password ?? "";
    debugPrint("form: $form");
    if (_activationCodeController.text.length == 6) {
      _activationCode = _activationCodeController.text;
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      auth.activate(email, password, _activationCode).then((result) {
        if (result is Success) {
          Navigator.pushNamedAndRemoveUntil(
              context, ModulgyRoute.home.getRoute(), (Route<dynamic> route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((result as Error).errorMessage),
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 6 digit code"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _activationCodeController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
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
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    _arguments = ModalRoute.of(context)?.settings.arguments as AuthRequest;
    return Scaffold(
      body: GlobalMarginWrapper(
        child: Form(
          key: _formKey,
          child: BodyWidget(auth),
        ),
      ),
    );
  }

  Widget BodyWidget(AuthProvider auth) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final email = _arguments?.email ?? "";
    final password = _arguments?.password ?? "";
    return Column(
      children: [
        WelcomeHeader(Localized.of(context).verify_code,
                Localized.of(context).enter_code_text)
            .marginBottom(100),
        ActivationCodeField(controller: _activationCodeController)
            .marginBottom(20),
        ModulgyButton(
            title: Localized.of(context).activate_button,
            buttonState: getButtonState(auth.registeredInStatus),
            onPressed: () {
              onActivationCodePressed(auth, email, password);
            }).marginOnly(bottom: 30),
        AuthBottom(
          text1: Localized.of(context).no_code,
          text2: Localized.of(context).resend_text,
          onRedirectPressed: () => {onCodeResend(context, auth, email)},
        )
      ],
    );
  }

  void onCodeResend(BuildContext context, AuthProvider auth, String email) {
    String snackbarMessage = "";
    auth.resendActivationCode(email).then((result) {
      snackbarMessage = (result is Success)
          ? Localized.of(context).activation_code_resent
          : Localized.of(context).activation_code_send_error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackbarMessage),
        ),
      );
    });
  }

  void onActivationCodePressed(
      AuthProvider auth, String email, String password) {
    final form = _formKey.currentState;
    debugPrint("form: $form");
    if (_activationCodeController.text.length == 6) {
      _activationCode = _activationCodeController.text;
      auth.activate(email, password, _activationCode).then((result) {
        if (result is Success) {
          Navigator.pushNamedAndRemoveUntil(context,
              ModulgyRoute.home.getRoute(), (Route<dynamic> route) => false);
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
        SnackBar(
          content: Text(Localized.of(context).valid_code_error),
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

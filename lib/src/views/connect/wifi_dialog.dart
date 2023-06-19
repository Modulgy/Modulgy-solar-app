import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class WifiDialog extends StatefulWidget {
  void Function(String ssid, String password) onSubmitted;

  WifiDialog({required this.onSubmitted});

  @override
  _WifiDialogState createState() => _WifiDialogState();
}

class _WifiDialogState extends State<WifiDialog> {
  TextEditingController ssidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    showWifiDialog(context);
    super.initState();
  }

  void showWifiDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Localized.of(context).wifi_setup),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ssidController,
                decoration: InputDecoration(
                  labelText: Localized.of(context).network_name_label,
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: Localized.of(context).password_hint,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onSubmitted(
                    ssidController.text, passwordController.text);
              },
              child: Text(Localized.of(context).save_button),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

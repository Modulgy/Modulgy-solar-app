import 'package:flutter/material.dart';
import 'package:moduluenergy/generated/l10n.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/utils/user_preferences.dart';
import 'package:moduluenergy/src/widgets/delete_user_alert.dart';

import '../../../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: BodyWidget(),
    ));
  }

  Widget BodyWidget() {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          headerSection(context),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              String title = "";
              if (index == 0) {
                title = Localized.of(context).connect_device;
              } else if (index == 1) {
                title = Localized.of(context).delete_account;
              }
              IconData icon = index == 0 ? Icons.wifi : Icons.delete;
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 247, 246, 246),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon),
                ),
                title: Text(title),
                trailing:
                    const Icon(Icons.arrow_forward, color: Colors.deepOrange),
                contentPadding: const EdgeInsets.all(8),
                onTap: () {
                  if (index == 0) {
                    Navigator.pushNamed(
                        context, ModulgyRoute.connect.getRoute());
                  } else if (index == 1) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const DeleteUserAlertDialog();
                      },
                    );
                  }
                },
              );
            },
          )
        ]));
  }

  Widget headerSection(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
        child: Transform.translate(
          offset: const Offset(-12.0, 0.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () => {
                        Navigator.pushNamed(
                            context, ModulgyRoute.home.getRoute())
                      },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.black.withOpacity(0.5),
                  )),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        Localized.of(context).settings,
                        style: AppStyles.dashboardHeadingStyle,
                        textAlign: TextAlign.start,
                      ).marginBottom(4)
                    ]).marginAll(16),
              ),
            ],
          ),
        ).marginBottom(16));
  }

  void onSendCodePressed() {}
}

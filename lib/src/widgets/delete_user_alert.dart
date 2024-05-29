import 'package:flutter/material.dart';
import 'package:moduluenergy/generated/l10n.dart';
import 'package:moduluenergy/main.dart';
import 'package:moduluenergy/src/network/result.dart';
import 'package:moduluenergy/src/views/auth/auth_provider.dart';
import 'package:provider/provider.dart';

class DeleteUserAlertDialog extends StatefulWidget {
  const DeleteUserAlertDialog();

  @override
  _DeleteUserAlertDialogState createState() => _DeleteUserAlertDialogState();
}

class _DeleteUserAlertDialogState extends State<DeleteUserAlertDialog> {
  bool _isDeletingUser = false;
  bool _isUserDeleted = false;

  void _toggleDeletingUser() {
    setState(() {
      _isDeletingUser = !_isDeletingUser;
    });
  }

  void _setUserDeleted() {
    setState(() {
      _isUserDeleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(!_isUserDeleted
          ? Localized.of(context).are_you_sure_delete
          : Localized.of(context).account_deleted),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isDeletingUser && !_isUserDeleted)
            Text(Localized.of(context).account_will_delete),
          if (_isUserDeleted) Text(Localized.of(context).delete_success),
          SizedBox(height: 16),
          if (_isDeletingUser) CircularProgressIndicator(),
        ],
      ),
      actions: <Widget>[
        if (!_isDeletingUser && !_isUserDeleted)
          TextButton(
            child: Text(Localized.of(context).delete_cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        if (!_isDeletingUser && !_isUserDeleted)
          TextButton(
            child: Text(
              Localized.of(context).delete_my_account,
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              _toggleDeletingUser();
              AuthProvider auth =
                  Provider.of<AuthProvider>(context, listen: false);

              auth.deleteUser().then((result) {
                if (result is Success) {
                  _setUserDeleted();
                  _toggleDeletingUser();
                } else {
                  _toggleDeletingUser();
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
            },
          ),
        if (_isUserDeleted)
          TextButton(
            child: Text(Localized.of(context).delete_logout),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, ModulgyRoute.login.getRoute());
            },
          ),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:moduluenergy/src/network/models.dart';

class UserProvider with ChangeNotifier {
  UserData _user = UserData.empty;

  UserData get user => _user;

  void setUser(UserData user) {
    _user = user;
    notifyListeners();
  }
}
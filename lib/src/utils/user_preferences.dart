import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../network/models.dart';

class UserPreferences {
  Future<bool> saveUser(UserData user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("isActivated", user.isActivated);
    prefs.setString("lastLoginAt", user.lastLoginAt);
    prefs.setString("email", user.email);
    prefs.setString("createdAt", user.createdAt);
    prefs.setString("uuid", user.uuid);

    return true;

  }

  Future<UserData> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isActivated = prefs.getBool("isActivated");
    String? lastLoginAt = prefs.getString("lastLoginAt");
    String? email = prefs.getString("email");
    String? createdAt = prefs.getString("createdAt");
    String? uuid = prefs.getString("uuid");

    if (isActivated != null &&
        lastLoginAt != null &&
        email != null &&
        createdAt != null &&
        uuid != null) {
      return UserData(
        isActivated: isActivated,
        lastLoginAt: lastLoginAt,
        email: email,
        createdAt: createdAt,
        uuid: uuid,
      );
    }

    return UserData.empty;

  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("isActivated");
    prefs.remove("lastLoginAt");
    prefs.remove("email");
    prefs.remove("createdAt");
    prefs.remove("uuid");
    prefs.remove("token");
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }

  void saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  void clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moduluenergy/src/network/api_provider.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/network/modulgy_api_service.dart';
import 'package:moduluenergy/src/network/result.dart';

import '../../../generated/l10n.dart';
import '../../utils/user_preferences.dart';

enum Status { NotAuthenticated, Authenticating, Authenticated }

enum AuthOperationType { Login, Register, Activate }

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotAuthenticated;
  Status _registeredInStatus = Status.NotAuthenticated;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  Future<Result> login(String email, String password) async {
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    String errorMessage = "";
    int errorCode = -1;

    AuthToken? authResult = await ModulgyApiProvider.instance
        .getUnauthenticatedAPIService()
        .login(AuthRequest(email: email, password: password, type: 'user'))
        .catchError((Object obj) {
      Error? error = onErrorHandler(obj, AuthOperationType.Login);
      if (error != null) {
        errorMessage = error.errorMessage;
        errorCode = error.errorCode;
        return null;
      }
    });

    debugPrint("Auth Result: $authResult");

    if (authResult != null) {
      UserPreferences().saveToken(authResult.body);
      await ModulgyApiProvider.instance.initAuthenticatedApiService();
      debugPrint("Token saved: ${await UserPreferences().getToken()}");
      //Call /me, and we're done
      var result = await me();
      if (result is Error) {
        return result;
      } else {
        _loggedInStatus = Status.Authenticated;
        notifyListeners();

        return Success(authResult);
      }
    } else {
      return Error(errorMessage, errorCode: errorCode);
    }
  }

  Future<Result> resendActivationCode(String email) async {
    Result result = Success<bool>(true);

    await ModulgyApiProvider.instance
        .getAPIService()
        .resendActivationCode(ResendCodeBody(email: email))
        .catchError((Object obj) {
      Error? error = onErrorHandler(obj, AuthOperationType.Activate);
      if (error != null) {
        result = error;
      }
    });

    return result;
  }

  Future<Result> register(String email, String password) async {
    _registeredInStatus = Status.Authenticating;
    notifyListeners();

    Result result = Success("");

    debugPrint("email: $email, password: $password");

    await ModulgyApiProvider.instance
        .getUnauthenticatedAPIService()
        .signUp(NewUserData(email: email, password: password))
        .then((value) {
      _registeredInStatus = Status.Authenticated;
      notifyListeners();
    }).catchError((Object obj) {
      Error? error = onErrorHandler(obj, AuthOperationType.Register);
      if (error != null) {
        result = error;
      }
    });

    return result;
  }

  Future<Result> activate(
      String email, String password, String activationCode) async {
    _registeredInStatus = Status.Authenticating;
    notifyListeners();

    Result result = Success("");

    await ModulgyApiProvider.instance
        .getUnauthenticatedAPIService()
        .activateUser(
            ActivateRequestBody(email: email, verificationCode: activationCode))
        .then((value) {
      _registeredInStatus = Status.Authenticated;
      notifyListeners();
    }).catchError((Object obj) {
      Error? error = onErrorHandler(obj, AuthOperationType.Activate);
      if (error != null) {
        result = error;
      }
    });

    if (result is Error) {
      //Activation failed
      return result;
    }

    //Activation succeeded, now login
    result = await login(email, password);

    return result;
  }

  Future<Result> me() async {
    Result result = Success("");
    var userDataResponse = await ModulgyApiProvider.instance
        .getAPIService()
        .me()
        .catchError((Object obj) {
      Error? error = onErrorHandler(obj, AuthOperationType.Login);
      if (error != null) {
        return null;
      }
    });
    if (userDataResponse == null) {
      return Error("Error getting user data");
    } else {
      UserPreferences().saveUser(userDataResponse.user);
      return result;
    }
  }

  Error? onErrorHandler(Object obj, AuthOperationType? operationType) {
    String errorMessage = "";
    debugPrint(obj.toString());
    switch (obj.runtimeType) {
      case DioError:
        final dioError = obj as DioError;
        final res = dioError.response;
        _loggedInStatus = Status.NotAuthenticated;
        _registeredInStatus = Status.NotAuthenticated;
        notifyListeners();
        debugPrint("error: ${dioError.error}");
        debugPrint("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
        errorMessage = Localized.current.error_operation(
            operationType ?? AuthOperationType.Login,
            res?.statusMessage ?? dioError.error?.toString() ?? "");
        return Error(errorMessage, errorCode: res?.statusCode ?? -1);
      default:
        return null;
    }
  }
}

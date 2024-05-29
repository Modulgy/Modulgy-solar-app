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

enum AuthOperationType { Login, Register, Activate, ResetPassword }

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
      print(UserPreferences().getToken());
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

  Future<Result> passwordReset(String email) async {
    _loggedInStatus = Status.Authenticating;
    Result result = Success("");
    notifyListeners();

    await ModulgyApiProvider.instance
        .getAPIService()
        .resetPassword(PasswordResetRequestBody(email: email))
        .then((value) => {
              _loggedInStatus = Status.Authenticated,
              notifyListeners(),
            })
        .catchError((Object obj) {
      _loggedInStatus = Status.NotAuthenticated;
      Error? error = onErrorHandler(obj, AuthOperationType.ResetPassword);
      if (error != null) {
        result = error;
      }
    });

    return result;
  }

  Future<Result> passwordChange(
      String code, String email, String password, String passwordRepeat) async {
    Result result = Success("");

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    await ModulgyApiProvider.instance
        .getAPIService()
        .changePassword(PasswordChangeRequestBody(
            email: email,
            password: password,
            verificationCode: double.parse(code)))
        .then((value) => {
              debugPrint("Password changed successfully"),
              _loggedInStatus = Status.Authenticated,
              notifyListeners()
            })
        .catchError((Object obj) {
      _loggedInStatus = Status.NotAuthenticated;
      Error? error = onErrorHandler(obj, AuthOperationType.ResetPassword);
      if (error != null) {
        throw error;
      }
    });

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

  Future<Result> deleteUser() async {
    Result result = Success("");
    await ModulgyApiProvider.instance
        .getAPIService()
        .deleteUser()
        .then((value) => {
              UserPreferences().clearData(),
              _loggedInStatus = Status.NotAuthenticated,
              notifyListeners(),
            })
        .catchError((Object obj) {
      Error? error = onErrorHandler(obj, AuthOperationType.Login);
      if (error != null) {
        result = error;
      }
    });

    return result;
  }

  Error? onErrorHandler(Object obj, AuthOperationType? operationType) {
    String errorMessage = "";
    String errorType = "";
    debugPrint(obj.toString());
    switch (obj.runtimeType) {
      case DioException:
        final dioError = obj as DioException;
        final res = dioError.response;
        _loggedInStatus = Status.NotAuthenticated;
        _registeredInStatus = Status.NotAuthenticated;
        notifyListeners();

        if (dioError.response?.data is Map) {
          final data = dioError.response?.data as Map;
          errorMessage = data['message'] ?? "Unknown error";
          errorType = data['type'] ?? "";
        } else {
          errorMessage =
              "Error during $operationType: ${res?.statusMessage ?? dioError.error?.toString()}";
          errorType = "unknown";
        }

        return Error(errorMessage,
            errorCode: res?.statusCode ?? -1, errorType: errorType);
      default:
        return null;
    }
  }
}

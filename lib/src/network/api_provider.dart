import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:moduluenergy/src/network/modulgy_article_service.dart';
import '../utils/user_preferences.dart';
import 'modulgy_api_service.dart';

class ModulgyApiProvider {
  //create a singleton
  static final ModulgyApiProvider instance = ModulgyApiProvider();

  ModulgyApiProvider() {
    initAuthenticatedApiService();
  }

  BaseOptions? _authenticatedBaseOptions = null;

  final ModulgyApiService _apiService =
      ModulgyApiService(Dio(BaseOptions(contentType: "application/json")));

  final ModulgyWordpressService _wordpressService =
      ModulgyWordpressService(Dio(BaseOptions(headers: {
    'Accept':
        '*/*',
    'Accept-Encoding': 'gzip',
  })));

  ModulgyApiService? _authenticatedApiService = null;

  ModulgyApiService getAPIService() {
    if (_authenticatedBaseOptions == null) {
      return _apiService;
    } else {
      _authenticatedApiService =
          ModulgyApiService(Dio(_authenticatedBaseOptions!));
      return _authenticatedApiService!;
    }
  }

  ModulgyApiService getUnauthenticatedAPIService() {
    return _apiService;
  }

  Future<void> initAuthenticatedApiService() async {
    return await UserPreferences().getToken().then((value) => {
          if (value.isNotEmpty)
            {
              _authenticatedBaseOptions = BaseOptions(
                  contentType: "application/json",
                  headers: {HttpHeaders.authorizationHeader: "Bearer $value"})
            }
        });
  }

  ModulgyWordpressService getWordpressService() {
    return _wordpressService;
  }
}

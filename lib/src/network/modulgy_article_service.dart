import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/http.dart';
import 'models.dart';
part 'modulgy_article_service.g.dart';

const String BASE_URL = "https://www.modulgy.com/wp-json/wp/v2";

@RestApi(baseUrl: BASE_URL)
abstract class ModulgyWordpressService {
  factory ModulgyWordpressService(Dio dio, {String baseUrl}) = _ModulgyWordpressService;

  @GET("/posts?_embed")
  Future<List<Article>> getRecentArticles();

}
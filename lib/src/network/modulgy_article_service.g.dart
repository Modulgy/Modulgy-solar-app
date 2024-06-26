// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modulgy_article_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ModulgyWordpressService implements ModulgyWordpressService {
  _ModulgyWordpressService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.modulgy.com/wp-json/wp/v2';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Article>> getRecentArticles() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    };
    const Map<String, dynamic>? _data = null;

      final _result =
      await _dio.fetch<List<dynamic>>(_setStreamType<List<Article>>(Options(
        method: 'GET',
        headers: _headers,
        extra: _extra,
      )
          .compose(
        _dio.options,
        '/posts?_embed',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
          baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      //return [Article(id: 1, date: "2024-05-03", link: "https://www.google.com", title: "Jurooo", featuredMediaUrl: "")];
      // return [];
      print(_result.data);
      var value = _result.data!
          .map((dynamic i) {
        return Article.fromJson(i as Map<String, dynamic>);
      })
          .toList();
      return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

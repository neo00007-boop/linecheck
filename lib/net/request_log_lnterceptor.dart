import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

//请求处理拦截器
class RequestLogInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('============================${options.method}-Request=======================');
    debugPrint("Request-URL: ${options.uri}");
    debugPrint(options.method.toLowerCase() == "get" ? "Query-- ${json.encode(options.queryParameters)}" : "Body-- ${dataToString(options.data)}");
    debugPrint("header:${options.headers}--Extra: ${options.extra}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('==========================onResponse==============================');
    debugPrint('onResponse-URL:-->${response.requestOptions.uri}');
    debugPrint('\n${response.toString()}\n');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('==========================onError==============================');
    debugPrint('onError-->${err.requestOptions.uri} statusCode ${err.response?.statusCode}\n${err.message}');
    super.onError(err, handler);
  }

  String dataToString(dynamic data) {
    try {
      return json.encode(data);
    } catch (e) {
      return data.toString();
    }
  }
}

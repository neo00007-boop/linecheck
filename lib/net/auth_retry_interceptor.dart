import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:linecheck/net/network_manager.dart';
import 'package:linecheck/provider/user_info_provider.dart';

//请求处理拦截器
class AuthRetryInterceptor extends QueuedInterceptorsWrapper {
  AuthRetryInterceptor();
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //公共请求头
    var url = options.uri.toString();
    if (url.contains(NetworkManager.kBaseUrl) && url.contains("/private")) {
      if (UserInfoProvider.isLogin()) {
        options.headers['Authorization'] = "Bearer ${UserInfoProvider.login.accessToken}";
      } else {
        return handler.reject(
          DioError(requestOptions: options, message: "no token request $url"),
          true,
        );
      }
    }
    //options.headers['lang'] = await LocaleProvider.getCurrentLangString();
    // LocaleProvider.locale.countryCode tw
    //languageCode:"zh"
    // LocaleProvider.locale.countryCode ch
    //languageCode:"zh"
    // LocaleProvider.locale.countryCode US
    //languageCode:"en"

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    //https://github.com/cfug/dio/blob/main/example/lib/queued_interceptor_crsftoken.dart
    if (err.response?.statusCode == 401) {
      //This retries the request if the token was updated later on
      final options = err.response!.requestOptions;
      var result = await NetworkManager.instance.refreshToken();
      if (result) {
        final originResult = await NetworkManager.instance.dio.fetch(options);
        if (originResult.statusCode != null && originResult.statusCode! ~/ 100 == 2) {
          return handler.resolve(originResult);
        } else {
          return handler.next(err);
        }
      }
      debugPrint('the token has not been updated');
      return handler.reject(
        DioError(requestOptions: options),
      );
    } else if (err.response?.statusCode == 402) {
      //调用刷新token过期或者无效，需要重新登录，在刷新token接口里面处理了

      // return handler.next(options);
    } else {
      super.onError(err, handler);
    }
  }
}

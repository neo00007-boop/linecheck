import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:linecheck/entity/api.dart';
import 'package:linecheck/entity/http_result_bean.dart';
import 'package:linecheck/net/auth_retry_interceptor.dart';
import 'package:linecheck/net/request_log_lnterceptor.dart';
import 'package:linecheck/provider/user_info_provider.dart';
import 'package:linecheck/util/macro.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  static NetworkManager get instance => _instance;

  factory NetworkManager() => _instance;
  static const String kBaseUrl = "https://snatch.gamebot.buzz";

  Dio dio = Dio();
  Dio refreshTokenDio = Dio();

  /// sendTimeout
  /// connectTimeout 连接服务器超时时间
  /// receiveTimeout 两次数据流数据接收的最长间隔时间，注意不是请求的最长接收时间。
  /// headers 请求头.
  NetworkManager._internal() {
    dio.options = BaseOptions(connectTimeout: Duration(seconds: 60), receiveTimeout: Duration(seconds: 60), baseUrl: kBaseUrl);
    dio.interceptors.add(AuthRetryInterceptor());
    dio.interceptors.add(RequestLogInterceptor());
    refreshTokenDio.options = dio.options.copyWith();
    refreshTokenDio.interceptors.add(RequestLogInterceptor());
  }

  Future<HttpResultBean> get(String api, {Map<String, dynamic>? params, Options? options, CancelToken? cancelToken}) async {
    params ?? HashMap<String, dynamic>();
    try {
      Options requestOptions = options ?? Options();
      Response<Map<String, dynamic>> response = await dio.get<Map<String, dynamic>>(
        api,
        // data: params,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return _handleResponseData(response);
    } on DioError catch (e) {
      return HttpResultBean(error: e);
    }
  }

  Future<HttpResultBean> post(String api, {Map<String, dynamic>? params, Options? options, CancelToken? cancelToken}) async {
    params ?? HashMap<String, dynamic>();
    try {
      Options requestOptions = options ?? Options();
      Response<Map<String, dynamic>> response = await dio.post<Map<String, dynamic>>(
        api,
        data: params,
        // queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return _handleResponseData(response);
    } on DioError catch (e) {
      return HttpResultBean(error: e);
    }
  }

  /// 注意params参数会以get形式拼接
  Future<HttpResultBean> postFile(String api, {Map<String, dynamic>? params, Object? data, Options? options, CancelToken? cancelToken}) async {
    params ?? HashMap<String, dynamic>();
    data ?? HashMap<String, dynamic>();
    try {
      Options requestOptions = options ?? Options();
      Response<Map<String, dynamic>> response = await dio.post<Map<String, dynamic>>(
        api,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return _handleResponseData(response);
    } on DioError catch (e) {
      return HttpResultBean(error: e);
    }
  }

  // /**
  //  * 传入AppNetworkConfig的构造方法
  //  * BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
  //  * connectTimeout 连接服务器超时时间，单位是毫秒.
  //  * receiveTimeout 响应流上前后两次接受到数据的间隔，单位为毫秒。
  //  * headers 请求头.
  //  */
  // Https2.internal(AppNetworkConfig config) {
  //   dio.options = BaseOptions(
  //       baseUrl: config.baseUrl,
  //       connectTimeout: config.connectTimeout,
  //       receiveTimeout: config.receiveTimeout,
  //       validateStatus: (int? status) => status != null && status > 0,
  //       headers: config.headers ?? {});
  //   var interceptor = config.interceptor;
  //   if (FlutterUtils.isNotEmpty(interceptor)) {
  //     dio.interceptors.addAll(interceptor);
  //   }
  //   enableProxy(config.proxyEnable);
  // }

  // 刷新token
  Future<bool> refreshToken() async {
    try {
      var refreshToken = "${UserInfoProvider.login.refreshToken}";
      var params = {"refreshToken": refreshToken};
      // refreshTokenDio.options.headers['Authorization'] = "Bearer ${UserInfoProvider.login.accessToken}";
      debugPrint("start refreshToken with ${Api.refreshToken}");
      Response<Map<String, dynamic>> response = await refreshTokenDio.post<Map<String, dynamic>>(Api.refreshToken, data: params);
      var result = _handleResponseData(response);
      if (result.succeed) {
        UserInfoProvider.login.accessToken = result.data["accessToken"];
        UserInfoProvider.login.refreshToken = result.data["refreshToken"];
        UserInfoProvider.persistUser();
      }
      return result.succeed;
    } on DioError catch (e) {
      if (e.response?.statusCode == 402) {
        //刷新token 过期需要重新登录
        showToast("刷新token 过期需要重新登录,待完善");
        UserInfoProvider.logout();
      }
      debugPrint("$e");
      return false;
    }
  }

  /// 响应数据統一转换
  HttpResultBean _handleResponseData(Response response) {
    // hideLoading();
    HttpResultBean resultData;
    try {
      final responseResult = response.data;
      resultData = HttpResultBean.fromJson(responseResult); //转换请求实体
      return resultData;
    } catch (exception) {
      resultData = HttpResultBean(code: response.statusCode, msg: "网络请求异常");
    }
    return resultData;
  }
}

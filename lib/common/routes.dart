import 'package:flutter/material.dart';
import 'package:linecheck/page/login_page.dart';
import 'package:linecheck/page/main_tab_page.dart';

/// 原生跳转Flutter 页面路由地址
class RouterConstants {
  static const String loginPage = "/LoginPage"; //登录页
  static const String mainPage = "/MainPage"; //主页
}

final Map<String, WidgetBuilder> routesMap = {
  RouterConstants.loginPage: (context) => LoginPage(),
  RouterConstants.mainPage: (context) => MainTabPage(),
};

final routeObserver = RouteObserver<PageRoute>();

RouteObserver<PageRoute> getRouteObserver() {
  return routeObserver;
}

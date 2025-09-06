import 'package:flutter/cupertino.dart';
import 'package:linecheck/page/home/main_tab_page.dart';
import 'package:linecheck/util/macro.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'flutter_utils.dart';

class NavigatorUtils {
  static final NavigatorUtils _instance = NavigatorUtils._internal();

  static NavigatorUtils get instance => _instance;

  factory NavigatorUtils() => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorUtils._internal();

  // 全局获取静态变量
  static BuildContext getContext() {
    return NavigatorUtils.instance.navigatorKey.currentContext!;
  }

  /// 跳转系统浏览器
  static void launchURL(String? url) async {
    if (FlutterUtils.isNotEmpty(url)) {
      await launchUrlString(url!);
    } else {
      showToast("地址不能为空");
      throw 'Could not launch $url';
    }
  }

  /// 跳转到首页， 删除先前的路由
  static void pushMain(BuildContext context) {
    NavigatorUtils.pushAndRemoveUntil(context, MainTabPage());
  }

  /// valueSetter   跳转下一个界面  携带参数返回
  static void push(BuildContext context, Widget widget, {ValueSetter<dynamic>? valueSetter}) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => widget)).then((param) {
      if (null != valueSetter) {
        valueSetter(param);
      }
    });
  }

  /// 替换上一个界面
  static void pushReplacement(BuildContext context, Widget widget, {ValueSetter<dynamic>? valueSetter, String? routerTag}) {
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => widget)).then((param) {
      if (null != valueSetter) {
        valueSetter(param);
      }
    });
  }

  /// 将给定路由推送到Navigator，
  /// removeRoute  true 之前的路由保持不变
  /// removeRoute  false  删除先前的路由
  static void pushAndRemoveUntil(BuildContext context, Widget widget, {bool removeRoute = false}) {
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (BuildContext context) => widget), (route) {
      return removeRoute;
    });
  }

  static void pushNamed(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void pushNamedAndRemove(BuildContext context, String routeName, {Object? arguments, bool removeRoute = false}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (Route<dynamic> route) => removeRoute);
  }
}

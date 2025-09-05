import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linecheck/provider/user_info_provider.dart';

class Global {
  bool test() {
    return kReleaseMode;
  }

  static Future<void> init() async {
    debugPrint("Launch-----init--start--");
    setupSystemUI();
    await Future.wait([
      // LocaleProvider.init(),
      UserInfoProvider.init(),
      // RongCloudManager.instance.init(),
      // RongCloudCallManager.instance.init(),
      // LocaleProvider.init(), //本地用户信息初始化 与国际化
      // initNetWorkConfig(),
    ]);
    debugPrint("Launch-----init--end--");
  }

  /// UI 标准适配尺寸
  static Size designSize() {
    if (Platform.isAndroid) {
      return Size(375, 812);
    } else if (Platform.isIOS) {
      return Size(375, 812);
    } else {
      return Size(375, 812);
    }
  }

  static void setupSystemUI() {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。
      // 写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，
      // 写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        //状态栏背景色
        statusBarColor: Colors.transparent,
        //虚拟按键颜色
        systemNavigationBarColor: Color(0xFF000000),
        //状态栏字体黑色
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'flutter_utils.dart';

class MyColor {
  static Color contentColor = const Color(0xfff7f8fc);
  static Color mainColor = const Color(0xff19d6ce);
  static Color bgColor = const Color(0xff1A1A1A);
  static Color themeColor = const Color(_themePrimaryValue); //主色系
  static const int _themePrimaryValue = 0xff1DD9A3;

  static MaterialColor primarySwatch = MaterialColor(_themePrimaryValue, <int, Color>{
    50: themeColor,
    100: themeColor,
    200: themeColor,
    300: themeColor,
    400: themeColor,
    500: themeColor,
    600: themeColor,
    700: themeColor,
    800: themeColor,
    900: themeColor,
  });

  ///获取themeColor
  static Color getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(200), Random.secure().nextInt(200), Random.secure().nextInt(200));
  }

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String? hexString) {
    if (FlutterUtils.isEmpty(hexString)) {
      hexString = '#FFFFFF';
    }
    final buffer = StringBuffer();
    if (hexString?.length == 6 || hexString?.length == 7) buffer.write('ff');
    buffer.write(hexString?.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

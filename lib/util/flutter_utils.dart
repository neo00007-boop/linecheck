import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
// import 'package:flutter_im/common/index.dart';
import 'package:path/path.dart' as path;

class FlutterUtils {
  static bool isEmpty(dynamic str) {
    if (str == null || str.isEmpty || str == 'null') {
      return true;
    }
    return false;
  }

  static bool isNotEmpty(dynamic str) {
    return !isEmpty(str);
  }

  static bool isIntEmpty(int? value) {
    if (value == null) {
      return true;
    }
    return false;
  }

  ///验证是否是中文  ,正则中的^表示开头,$表示结束
  static bool isChinese(String value) {
    return RegExp(r"^[\u4e00-\u9fa5]+$").hasMatch(value);
  }

  // 验证是否为数字
  static bool isNumber(String str) {
    final reg = RegExp(r'^-?[0-9]+');
    return reg.hasMatch(str);
  }

/*  static String getAmounts(List<OddsList> list) {
    List amounts = [];
    for (int i in list) {
      amounts.add(i * int.parse(getIsYushe() ? _multipleList[_selIndex] : _originMultiplelist[_selIndex]));
    }
    String str = '';
    amounts.forEach((f) {
      if (str == '') {
        str = "$f";
      } else {
        str = "$str" "," "$f";
      }
    });
    return str;
  }*/

  /// 将日期转换为时间戳
  static DateTime timestampToDate(int timestamp) {
    DateTime dateTime = DateTime.now();
    var length = timestamp.toString().length;
    if (length == 11) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    } else if (length == 13) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else if (length == 16) {
      dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    }
    return dateTime;
  }

  /// 日期转时间戳
  /// isMicroseconds 是否是毫秒
  static int dateToTimestamp(String date, {isMicroseconds = false}) {
    DateTime dateTime = DateTime.parse(date);
    int timestamp = dateTime.millisecondsSinceEpoch;
    if (isMicroseconds) {
      timestamp = dateTime.microsecondsSinceEpoch;
    }
    return timestamp;
  }

  ///时间值转换
  ///2:1  => 02 : 01
  static numberUtils(int number) {
    if (number < 10) {
      return "0${number.toString()}";
    }
    return number.toString();
  }

  ///检测时间距离当前是今天 昨天 前天还是某个日期 跨年显示 年-月-日 不跨年显示 月-日
  static String formatToChatScope({required DateTime checkTime}) {
    final now = DateTime.now();
    var strTime = checkTime.toString();
    if (checkTime.year != now.year) {
      return strTime.substring(0, strTime.length - 7);
    } else {
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      final beforeYesterday = DateTime(now.year, now.month, now.day - 2);
      final aDate = DateTime(checkTime.year, checkTime.month, checkTime.day);
      if (aDate == today) {
        return "今天 ${numberUtils(checkTime.hour)}:${numberUtils(checkTime.minute)}";
      } else if (aDate == yesterday) {
        return "昨天 ${numberUtils(checkTime.hour)}:${numberUtils(checkTime.minute)}";
      } else if (aDate == beforeYesterday) {
        return "前天 ${numberUtils(checkTime.hour)}:${numberUtils(checkTime.minute)}";
      }
    }
    return strTime.substring(5, strTime.length - 7);
  }

  static bool pathIsImage(String? filePath) {
    if (isEmpty(filePath)) {
      return false;
    }
    String ext = path.extension(filePath!).toLowerCase();
    return ext == '.jpg' || ext == '.jpeg' || ext == '.png' || ext == '.gif' || ext == '.bmp' || ext == '.heic';
  }

  static bool pathIsGif(String? filePath) {
    if (isEmpty(filePath)) {
      return false;
    }
    String ext = path.extension(filePath!).toLowerCase();
    return ext == '.gif';
  }

  static bool pathIsVideo(String? filePath) {
    if (isEmpty(filePath)) {
      return false;
    }
    String ext = path.extension(filePath!).toLowerCase();
    return ext == '.mp4' || ext == '.mov' || ext == '.avi' || ext == '.wmv' || ext == '.3gp';
  }

  static Uri parseUrL(String strUrl) {
    var url = Uri.parse(strUrl);
    if (!url.hasScheme) {
      url = Uri.file(strUrl);
    }
    return url;
  }

  static int convertToInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static bool convertToBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is int) {
      return value > 0;
    }
    if (value is String) {
      return bool.tryParse(value) ?? false;
    }
    return false;
  }

  static dynamic convertToJSON(dynamic value) {
    if (value is Map || value is List) {
      return value;
    }
    if (value is String) {
      try {
        return jsonDecode(value);
      } catch (e) {
        debugPrint(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  static bool localFileExist(String? url) {
    return url != null && isNotEmpty(url) && File(parseUrL(url).toFilePath()).existsSync();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linecheck/util/flutter_utils.dart';

///函数式风格显示吐司
///示例:```
///   showToast('再按一次退出');
/// ```
void showToast(String? msg) {
  if (FlutterUtils.isEmpty(msg)) {
    return;
  }
  dismissLoading();
  Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Color(0xde393939),
    textColor: Colors.white,
    fontSize: 14.5,
  );
}

//dismissOnTap 点击是否消失  默认会
// maskType loading的遮罩类型, 默认[EasyLoadingMaskType.clear].
void showLoading({bool? dismissOnTap = false, EasyLoadingMaskType? maskType = EasyLoadingMaskType.clear, String? status}) {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.6)
    ..progressColor = Color(0xff1DD9A3)
    ..indicatorColor = Color(0xff1DD9A3);

  EasyLoading.show(status: status, maskType: maskType, dismissOnTap: dismissOnTap);
}

// 显示进度
void showProgress({required double value, bool? dismissOnTap = false, EasyLoadingMaskType? maskType = EasyLoadingMaskType.clear, String? status}) {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.6)
    ..progressColor = Color(0xff1DD9A3)
    ..indicatorColor = Color(0xff1DD9A3);

  EasyLoading.showProgress(value, status: status, maskType: maskType);
}

void dismissLoading() {
  if (EasyLoading.isShow) {
    EasyLoading.dismiss();
  }
}

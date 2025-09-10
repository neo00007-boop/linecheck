import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:linecheck/entity/http_result_bean.dart';
import 'package:linecheck/entity/user_info_entity.dart';
import 'package:linecheck/net/login_service.dart';
import 'package:linecheck/global.dart';
import 'package:linecheck/provider/user_info_provider.dart';
import 'package:linecheck/util/navigator_utils.dart';
import 'package:provider/provider.dart';

import '../../util/macro.dart';

class LoginLogic extends GetxController {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _deviceInfoPlugin = DeviceInfoPlugin();

  var showAccountSuffix = false.obs;
  var showPwdSuffix = false.obs;
  var viewPassword = false.obs;

  // UI 按钮可用性
  bool get isOk => showAccountSuffix.value && showPwdSuffix.value;

  @override
  void onClose() {
    accountController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<void> loginOnClick(BuildContext context) async {
    var device = "";
    if (Global.isWeb()) {
      var deviceInfo = await _deviceInfoPlugin.webBrowserInfo;
      device = deviceInfo.browserName.name;
    } else if (Platform.isMacOS) {
      var deviceInfo = await _deviceInfoPlugin.macOsInfo;
      device = deviceInfo.model;
    } else if (Platform.isWindows) {
      var deviceInfo = await _deviceInfoPlugin.windowsInfo;
      device = deviceInfo.computerName;
    } else if (Platform.isIOS) {
      var deviceInfo = await _deviceInfoPlugin.iosInfo;
      device = deviceInfo.utsname.machine;
    } else {
      var deviceInfo = await _deviceInfoPlugin.androidInfo;
      device = deviceInfo.brand + deviceInfo.model;
    }

    showLoading();

    var name = accountController.text.trim();
    HttpResultBean? result = await LoginService.login(account: name, password: passwordController.text.trim(), device: device);

    if(!context.mounted){
      return;
    }

    if (result != null && result.succeed) {
      _loginSuccess(context, result);
    } else {
      // mock 数据 fallback
      result = HttpResultBean();
      var entity = UserInfoEntity(
        uid: 007,
        username: name,
        token: "007",
        nickname: name,
        accessToken: "007",
        refreshToken: "007",
        expiresIn: 10000000000,
        tokenType: "007",
        avatar: "007",
        description: "007",
        link: "007",
      );
      result.data = entity;
      _loginSuccess(context, result);
    }

    dismissLoading();
  }

  void _loginSuccess(BuildContext context, HttpResultBean result) {
    Provider.of<UserInfoProvider>(context, listen: false).userInfo = result.data;
    NavigatorUtils.pushMain(context);
  }
}

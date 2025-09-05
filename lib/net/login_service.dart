import 'package:flutter/cupertino.dart';
import 'package:linecheck/common/base_provider_model.dart';
import 'package:linecheck/entity/api.dart';
import 'package:linecheck/entity/http_result_bean.dart';
import 'package:linecheck/entity/user_info_entity.dart';
import 'package:linecheck/net/network_manager.dart';

class LoginService extends BaseViewModel {
  // 账号密码登录
  static Future<HttpResultBean?> login({required String account, required String password, String? device}) async {
    try {
      var params = {"username": account, "password": password, "device": device};
      HttpResultBean result = await NetworkManager.instance.post(Api.login, params: params);
      if (result.succeed) {
        UserInfoEntity infoEntity = UserInfoEntity.fromJson(result.data);
        result.data = infoEntity;
      } else {
        result.showMessage();
      }
      return result;
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  // 注册
  static Future<HttpResultBean?> register({
    required String username,
    required String password,
    String? inviteCode,
  }) async {
    try {
      var params = {"username": username, "password": password, "inviteCode": inviteCode};
      HttpResultBean result = await NetworkManager.instance.post(Api.register, params: params);
      if (result.succeed) {
        UserInfoEntity infoEntity = UserInfoEntity.fromJson(result.data);
        result.data = infoEntity;
      } else {
        result.showMessage();
      }
      return result;
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }
}

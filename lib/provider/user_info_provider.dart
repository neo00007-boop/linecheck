import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:linecheck/entity/const.dart';
import 'package:linecheck/entity/user_info_entity.dart';
import 'package:linecheck/util/shared_preference.dart';

class UserInfoProvider extends ChangeNotifier {
  // static final UserInfoProvider _instance = UserInfoProvider._internal();
  // factory UserInfoProvider() => _instance;
  // static UserInfoProvider get instance => _instance;
  static UserInfoEntity _userInfoEntity = UserInfoEntity();

  //静态访问
  static UserInfoEntity get login => _userInfoEntity;

  //provider 访问
  UserInfoEntity get userInfo => _userInfoEntity;

  UserInfoProvider() {
    debugPrint("UserInfoProvider _internal");
  }

  //是否已登录
  bool userAlreadyLogin() {
    return _userInfoEntity.accessToken?.isNotEmpty == true;
  }

  //退出登录
  static void logout() {
    _userInfoEntity.accessToken = null;
    SharedUtil.remove(kUserInfoKey);
    // SharedUtil.remove(localFriendList);
    // RongCloudCallManager.instance.disconnect();
  }

  //静态访问
  static bool isLogin() {
    return _userInfoEntity.accessToken?.isNotEmpty == true;
  }

  //初始化
  static Future<void> init() async {
    var json = await SharedUtil.getJSON(kUserInfoKey);
    if (json != null) {
      _userInfoEntity = UserInfoEntity.fromJson(json);
    }
  }

  /// 保存用户信息并全局刷新
  /// 可使用 provider 访问  可全局刷新
  /// StoreUtil.value<UserInfoProvider>(context, listen: false).userInfoEntity = data;
  set userInfo(UserInfoEntity data) {
    _userInfoEntity = data;
    persistUser();
    notifyListeners();
  }

  /// 修改头像
  /// 可使用 provider 访问  可全局刷新
  /// StoreUtil.value<UserInfoProvider>(context, listen: false).userInfoEntity = data;
  void updateUserAvatar(String avatar) {
    _userInfoEntity.avatar = avatar;
    persistUser();
    notifyListeners();
  }

  /// 修改名称或者签名
  /// 可使用 provider 访问  可全局刷新
  /// StoreUtil.value<UserInfoProvider>(context, listen: false).userInfoEntity = data;
  void updateUser(bool name, String info) {
    if (name) {
      _userInfoEntity.nickname = info;
    } else {
      _userInfoEntity.description = info;
    }
    persistUser();
    notifyListeners();
  }

  /// 置空消息
  /// 可使用 provider 访问  可全局刷新
  /// StoreUtil.value<UserInfoProvider>(context, listen: false).userInfoEntity = data;
  void resetData() {
    _userInfoEntity.avatar = "";
    _userInfoEntity.nickname = "";
    _userInfoEntity.username = "";
    _userInfoEntity.uid = 0;
    _userInfoEntity.description = "";
    notifyListeners();
  }

  static void persistUser() {
    SharedUtil.save(kUserInfoKey, jsonEncode(_userInfoEntity.toJson()));
  }
}

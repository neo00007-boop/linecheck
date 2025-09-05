import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linecheck/common/base_provider_widget.dart';
import 'package:linecheck/common/fl_text_widget.dart';
import 'package:linecheck/entity/const.dart';
import 'package:linecheck/entity/http_result_bean.dart';
import 'package:linecheck/generated/assets.dart';
import 'package:linecheck/net/login_service.dart';
import 'package:linecheck/provider/user_info_provider.dart';
import 'package:linecheck/util/macro.dart';
import 'package:linecheck/util/my_color.dart';
import 'package:linecheck/util/navigator_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  // 登录成功是否需要跳到根控制器
  final popToRoot = false;

  const LoginPage({popToRoot = false, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ProviderWidgetState<LoginPage, LoginService> {
  bool _showAccountSuffix = false;
  bool _viewPassword = false;
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // late BuildContext _ccontext;
  static final _deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    // UserInfoProvider.instance.userAlreadyLogin();
    super.initState();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    dismissLoading();
    super.dispose();
  }

  /* 获取版本号 */
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  Future<void> loginOnClick() async {
    var device = "";
    if (Platform.isIOS) {
      var deviceInfo = await _deviceInfoPlugin.iosInfo;
      device = deviceInfo.utsname.machine;
    } else {
      var deviceInfo = await _deviceInfoPlugin.androidInfo;
      device = deviceInfo.brand + deviceInfo.model;
    }
    showLoading();
    HttpResultBean? result = await LoginService.login(account: _accountController.text.trim(), password: _passwordController.text.trim(), device: device);
    if (result != null && result.succeed) {
      if (context.mounted) {
        Provider.of<UserInfoProvider>(context, listen: false).userInfo = result.data;
        // RongCloudManager.instance.connect();
        if (widget.popToRoot) {
          NavigatorUtils.pushMain(context);
        } else {
          Navigator.maybePop(context);
        }
      }
    }
    dismissLoading();
  }

  @override
  LoginService createViewModel() {
    return LoginService();
  }

  @override
  Widget buildWidget(BuildContext context, LoginService model, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(28.w, 98.h, 28.w, 0),
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Column(
                    children: [
                      Image(image: AssetImage(Assets.commonAppLogo), width: 80.w, height: 80.w),
                      FLText(
                        kAppName,
                        margin: EdgeInsets.only(top: 12.h),
                        style: TextStyle(color: MyColor.fromHex("#19D6CE"), fontSize: 16.sp),
                      ),
                      //用户名
                      Container(
                        margin: EdgeInsets.only(top: 42.h),
                        // height: 52.h,
                        child: FocusTraversalOrder(
                          order: NumericFocusOrder(1),
                          child: TextFormField(
                            controller: _accountController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            maxLines: 1,
                            // cursorColor: Colors.amber,光标颜色
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return /*S.current.str_please_enter_a_username*/ "请输入用账号";
                              }
                              return null;
                            },
                            style: TextStyle(color: MyColor.fromHex("#222222"), fontSize: 14.sp),
                            scrollPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _showAccountSuffix = value.isNotEmpty;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: /*S.current.str_please_enter_an_account*/ "请输入用账号",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColor.fromHex("#CACCD3"), width: 0.5.h),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColor.fromHex("#CACCD3"), width: 0.5.h),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 0.5.h),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 0.5.h),
                              ),
                              prefixIcon: Container(
                                width: 20.w,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                child: Image.asset(Assets.loginLoginPhone, width: 20.w, height: 20.h),
                              ),
                              prefixIconConstraints: BoxConstraints(minWidth: 25),
                              suffixIcon: AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: _showAccountSuffix ? 1.0 : 0.0,
                                child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerRight,
                                  style: IconButton.styleFrom(
                                    // splashFactory: NoSplash.splashFactory,
                                  ),
                                  icon: Image(image: AssetImage(Assets.loginLoginCleanText), height: 20.h),
                                  onPressed: () {
                                    _accountController.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //密码
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        // height: 52.h,
                        child: FocusTraversalOrder(
                          order: NumericFocusOrder(2),
                          child: TextFormField(
                            controller: _passwordController,
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: _viewPassword ? false : true,
                            maxLines: 1,
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return /*S.current.str_please_input_a_password*/ "请输入用密码";
                              }
                              return null;
                            },
                            style: TextStyle(color: MyColor.fromHex("#222222"), decorationColor: Colors.red, fontSize: 14.sp),
                            decoration: InputDecoration(
                              hintText: /*S.current.str_please_input_a_password*/ "请输入用密码",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColor.fromHex("#CACCD3"), width: 0.5.h),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColor.fromHex("#CACCD3"), width: 0.5.h),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 0.5.h),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 0.5.h),
                              ),
                              prefixIcon: Container(
                                width: 20.w,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                child: Image.asset(Assets.loginLoginPassword, width: 20.w, height: 20.h),
                              ),
                              prefixIconConstraints: BoxConstraints(minWidth: 25),
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                // hoverColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerRight,
                                style: IconButton.styleFrom(
                                  alignment: Alignment.centerRight,
                                  // splashFactory: NoSplash.splashFactory,
                                ),
                                icon: Image(
                                  image: AssetImage(
                                    _viewPassword
                                        ? Assets.loginLoginHidden
                                        : Assets.loginLoginView,
                                  ),
                                  height: 20.h,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _viewPassword = !_viewPassword;
                                  });
                                },
                              ),
                              // suffixIconConstraints: BoxConstraints(maxWidth: 30.w)
                            ),
                          ),
                        ),
                      ),
                      //登录按钮
                      Container(
                        margin: EdgeInsets.only(top: 30.h),
                        width: double.infinity,
                        height: 48.h,
                        child: FocusTraversalOrder(
                          order: NumericFocusOrder(3),
                          child: TextButton(
                            style: TextButton.styleFrom(shape: StadiumBorder(), backgroundColor: MyColor.fromHex("#19D6CE")),
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                loginOnClick();
                                // showToast(S.current.str_login_succeeded);
                              }
                              // else {
                              //   showToast(S.current.str_validation_failed);
                              // }
                            },
                            child: Text(/*S.current.str_log_in_now*/ "登录", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: RichText(
                          text: TextSpan(
                            text: /*S.current.str_login_is_considered_as_consent*/ "登录即视为同意",
                            style: TextStyle(fontSize: 11.sp, color: MyColor.fromHex("#979AA7")),
                            children: <TextSpan>[
                              TextSpan(
                                text: /*'《${S.current.str_user_license_agreement}》'*/ '《用户许可协议》',
                                style: TextStyle(color: MyColor.primarySwatch),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showToast(/*S.current.str_click_on_the_user_license_agreement*/ "点击用户许可协议");

                                    debugPrint(/*S.current.str_click_on_the_user_license_agreement*/ "点击用户许可协议");
                                  },
                              ),
                              TextSpan(text: /*S.current.str_and*/ "和"),
                              TextSpan(
                                text: /*'《${S.current.str_privacy_policy}》'*/ '《隐私政策》',
                                style: TextStyle(color: MyColor.primarySwatch),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showToast(/*S.current.str_click_on_privacy_policy*/ "点击隐私政策");
                                    debugPrint(/*S.current.str_privacy_policy*/ "点击隐私政策");
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 18.h),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Text(
                            /*S.current.str_no_account*/
                            "没有账号？立即注册",
                            style: TextStyle(fontSize: 14.sp, color: MyColor.fromHex("#4A4C52")),
                          ),
                          onPressed: () {
                            // NavigatorUtils.push(context, RegisterPage());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder(
                  future: getVersionNumber(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'V${snapshot.data}',
                        style: TextStyle(fontSize: 14.sp, color: MyColor.fromHex("#4A4C52")),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

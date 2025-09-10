import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linecheck/util/my_color.dart';
import 'package:linecheck/generated/app_colors.dart';
import 'package:linecheck/generated/assets.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(28, 98, 28, 0),
              width: 550,
              child: Form(
                key: logic.formKey,
                child: Column(
                  children: [
                    // 用户名
                    Obx(() => Container(
                      margin: EdgeInsets.only(top: 42),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: logic.accountController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        maxLines: 1,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "请输入账号";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: MyColor.fromHex("#222222"),
                            fontSize: 14),
                        onChanged: (value) =>
                        logic.showAccountSuffix.value = value.isNotEmpty,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 6),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "请输入账号",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Image.asset(Assets.loginLoginPhone,
                                width: 20, height: 20),
                          ),
                          suffixIcon: logic.showAccountSuffix.value
                              ? IconButton(
                            padding: EdgeInsets.only(right: 10),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Image.asset(
                                Assets.loginLoginCleanText,
                                height: 20),
                            onPressed: () {
                              logic.accountController.clear();
                              logic.showAccountSuffix.value = false;
                            },
                          )
                              : null,
                        ),
                      ),
                    )),
                    // 密码
                    Obx(() => Container(
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: logic.passwordController,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: !logic.viewPassword.value,
                        maxLines: 1,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "请输入密码";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: MyColor.fromHex("#222222"),
                            fontSize: 14),
                        onChanged: (value) =>
                        logic.showPwdSuffix.value = value.isNotEmpty,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 6),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "请输入密码",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Image.asset(Assets.loginLoginPassword,
                                width: 20, height: 20),
                          ),
                          suffixIcon: IconButton(
                            padding: EdgeInsets.only(right: 10),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Image.asset(
                              logic.viewPassword.value
                                  ? Assets.loginLoginHidden
                                  : Assets.loginLoginView,
                              height: 20,
                            ),
                            onPressed: () => logic.viewPassword.toggle(),
                          ),
                        ),
                      ),
                    )),
                    // 登录按钮
                    Obx(() => Container(
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: logic.isOk
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                        color:
                        logic.isOk ? Colors.white : Colors.transparent,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: StadiumBorder()),
                        onPressed: () {
                          if (logic.formKey.currentState?.validate() ==
                              true) {
                            logic.loginOnClick(context);
                          }
                        },
                        child: Text("登录",
                            style: TextStyle(
                                color: logic.isOk
                                    ? AppColors.primary
                                    : Colors.white)),
                      ),
                    )),
                    // 版本号
                    FutureBuilder(
                      future: logic.getVersionNumber(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'V${snapshot.data}',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyColor.fromHex("#FFFFFF")),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

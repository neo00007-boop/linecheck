import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linecheck/common/routes.dart';
import 'package:linecheck/global.dart';
import 'package:linecheck/page/login_page.dart';
import 'package:linecheck/page/main_tab_page.dart';
import 'package:linecheck/provider/user_info_provider.dart';
import 'package:linecheck/util/my_color.dart';
import 'package:linecheck/util/navigator_utils.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInfoProvider()), // user
      ],
      child: Consumer<UserInfoProvider>(
        builder: (context, userInfo, child) {
          return ScreenUtilInit(
            designSize: Global.designSize(),
            // minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                routes: routesMap,
                navigatorObservers: [routeObserver],
                navigatorKey: NavigatorUtils.instance.navigatorKey,
                theme: ThemeData(
                  // primarySwatch: MyColor.primarySwatch,
                  // splashColor: Colors.red,
                  primaryColor: Colors.white,

                  //页面背景色
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    centerTitle: true,
                    elevation: 0,
                    color: Colors.white,
                    titleTextStyle: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w500),
                    iconTheme: IconThemeData(color: MyColor.fromHex("#222222")),
                  ),
                ),
                home: userInfo.userAlreadyLogin() ? MainTabPage() : LoginPage(),
                builder: EasyLoading.init(
                  builder: (context, child) {
                    return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!);
                  },
                ),
                // localizationsDelegates: [
                //   S.delegate,
                //   GlobalMaterialLocalizations.delegate,
                //   GlobalWidgetsLocalizations.delegate,
                //   GlobalCupertinoLocalizations.delegate,
                //   // RefreshLocalizations.delegate,
                // ],
                // supportedLocales: S.delegate.supportedLocales,
                // locale: locale.value,
              );
            },
          );
        },
      ),
    );
  }
}

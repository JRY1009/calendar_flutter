import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:library_base/utils/log_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:www/res/language/language_service.dart';
import 'package:www/routes/app_pages.dart';
import 'package:www/storage/shared_pref.dart';

//默认App的启动
class DefaultApp {
  static Future<Widget> getApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initApp();

    return const MyApp();
  }

  //运行app
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initApp();

    runApp(const MyApp());
  }

  //程序初始化操作
  static Future<void> initApp() async {

    await SharedPref.init();

    LogUtil.init(isDebug: kDebugMode);

    if (GetPlatform.isAndroid) {
      // 透明状态栏
      const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, widget) {
          return GetMaterialApp(
            title: "Calendar",
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: true,
            builder: (context,widget) {
              // bool themeIsLight = MySharedPref.getThemeIsLight();
              // return Theme(
              //   data: MyTheme.getThemeData(isLight: themeIsLight),
              //   child: MediaQuery(
              //     // prevent font from scalling (some people use big/small device fonts)
              //     // but we want our app font to still the same and dont get affected
              //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              //     child: widget!,
              //   ),
              // );
              return widget!;
            },
            initialRoute: AppPages.INITIAL, // first screen to show when app is running
            getPages: AppPages.routes, // app screens

            // 语言选项
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate, // ios
            ],
            translations: LanguageService.getInstance(), // localization services in app (controller app language)
            locale: LanguageService.getLocale(), // app language
            supportedLocales: LanguageService.supportedLanguages.values,
            fallbackLocale: LanguageService.defaultLocale, // 添加一个回调语言选项，以备上面指定的语言翻译不存在
            localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) { //监听系统语言切换
              LanguageService.currentLocale = LanguageService.getLocale();
              if (LanguageService.currentLocale == null) { //跟随系统
                if (LanguageService.isLocaleSupported(locale!)) {
                  LanguageService.currentLocale =  locale;
                } else {
                  LanguageService.currentLocale = LanguageService.defaultLocale;
                }
              }

              Get.updateLocale(LanguageService.currentLocale!);
              return LanguageService.currentLocale;
            },

          );
        },
      );
  }
}
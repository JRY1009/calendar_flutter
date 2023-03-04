import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
//import 'package:dokit/dokit.dart';
import 'package:get/get.dart';
import 'package:www/utils/date_util.dart';
import 'package:www/utils/object_util.dart';
import 'package:www/utils/path_util.dart';

import 'default_app.dart';

//应用初始化
class AppInit {

  static Future<void> run() async {

    if (GetPlatform.isAndroid) {
      // DoKit.runApp(
      //     appCreator: () async => DoKitApp(await DefaultApp.getApp()),
      //     useInRelease: true,
      //     exceptionCallback: (obj, trace) {
      //       var details = makeDetails(obj, trace);
      //       reportErrorAndLog(details);
      //     });

      catchException(() => DefaultApp.run());
    } else {
      //捕获异常
      catchException(() => DefaultApp.run());
    }
  }

  ///异常捕获处理
  static void catchException<T>(T Function() callback) {
    //捕获异常的回调
    FlutterError.onError = (FlutterErrorDetails details) {
      reportErrorAndLog(details);
    };

    runZonedGuarded<Future<void>>(
      () async {
        callback();
      },

      //未捕获的异常的回调
      (Object obj, StackTrace stack) {
        var details = makeDetails(obj, stack);
        reportErrorAndLog(details);
      },

      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          collectLog(parent, zone, line); // 收集日志
        },
      ),
    );
  }

  //日志拦截, 收集日志
  static void collectLog(ZoneDelegate parent, Zone zone, String line) {
    parent.print(zone, line);
  }

  //上报错误和日志逻辑
  static void reportErrorAndLog(FlutterErrorDetails details) {
    if (kDebugMode) {
      print(details);
    } else {
      if (GetPlatform.isMobile) {
        // FlutterBugly.uploadException(
        //     message: details.exception.toString(),
        //     detail: details.stack.toString());
      }
    }

    saveErrorToFile(details.toString());
  }

  static Future<void> saveErrorToFile(String error) async {
    if (!GetPlatform.isMobile) {
      return;
    }

    String? dirPath = '';
    if (GetPlatform.isIOS) {
      dirPath = await PathUtils.getCacheDirPath();
      if (ObjectUtil.isEmpty(dirPath)) {
        return;
      }
    } else {
      dirPath = await PathUtils.getExternalCacheDirPath();
      if (ObjectUtil.isEmpty(dirPath)) {
        return;
      }
    }

    Directory? crashDir = PathUtils.createDirSync('$dirPath/crash');
    String? crashDirPath = crashDir?.path;
    if (ObjectUtil.isEmpty(dirPath)) {
      return;
    }

    String fileName = 'crash_${DateUtil.getNowDateStr()!.replaceAll(' ', '_')}.txt';

    File file = File('$crashDirPath/$fileName');
    if (!file.existsSync()) {
      file.createSync();
    }

    file.writeAsString(error);
  }

  // 构建错误信息
  static FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
    return FlutterErrorDetails(exception: obj, stack: stack);
  }
}

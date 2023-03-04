import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:www/res/language/strings_enum.dart';
import 'package:www/routes/app_pages.dart';

import '../controllers/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        title: Text(Strings.hello.tr),
        centerTitle: true,
      ),
      //body: HomeView(),

      body: Container(
        alignment: Alignment.center,
        child: InkWell(
            onTap: () => Get.toNamed(Routes.LANGUAGE),
            child: Text(Strings.changeLanguage.tr)
        )
      ),
    );
  }
}

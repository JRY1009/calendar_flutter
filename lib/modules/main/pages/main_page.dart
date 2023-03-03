import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:www/res/language/strings_enum.dart';

import '../controllers/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        centerTitle: true,
      ),
      //body: HomeView(),

      body: Container(
        alignment: Alignment.center,
        child: Text(Strings.hello.tr)
      ),
    );
  }
}

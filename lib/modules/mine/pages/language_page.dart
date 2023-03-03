
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:library_base/component/button/back_button.dart';
import 'package:www/res/language/language_service.dart';
import 'package:www/res/language/strings_enum.dart';
import 'package:www/storage/shared_pref.dart';


class LanguagePage extends StatelessWidget {

  Widget buildLanguageItem(String lan, value) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        lan,
        // 对APP当前语言进行高亮显示
        style: TextStyle(
            color: SharedPref.getCurrentLanguage() == value ? Colors.blue : Colors.grey,
            fontSize: 14
        ),
      ),
      trailing: SharedPref.getCurrentLanguage() == value ? Icon(Icons.done, color: Colors.blue) : null,
      onTap: () {
        // 此行代码会通知MaterialApp重新build
        LanguageService.updateLanguage(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: const MyBackButton(),
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(Strings.changeLanguage.tr, style: const TextStyle(color: Colors.black, fontSize: 14))
        ),
        body: Padding(

            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
                itemExtent: 48,
                children: ListTile.divideTiles(
                    context: context,
                    color: Colors.grey,
                    tiles: [
                      buildLanguageItem(Strings.english.tr, "en"),
                      buildLanguageItem(Strings.chineseSimplified.tr, "zh_CN"),
                      buildLanguageItem(Strings.auto.tr, ''),
                    ]
                ).toList()
            )
        )
    );
  }
}

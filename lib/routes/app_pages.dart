import 'package:get/get.dart';
import 'package:www/modules/main/bindings/main_binding.dart';
import 'package:www/modules/main/pages/main_page.dart';
import 'package:www/modules/mine/pages/language_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(name: Routes.MAIN, page: () => MainPage(), binding: MainBinding()),
    GetPage(name: Routes.LANGUAGE, page: () => LanguagePage(), transition: Transition.cupertino),
  ];
}

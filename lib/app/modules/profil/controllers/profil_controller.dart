import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilController extends GetxController {
  final storage = GetStorage();

  var tm = const Locale('tm');
  var ru = const Locale('ru');
  var en = const Locale('en');
  dynamic switchLang(String value) {
    if (value == 'en') {
      Get.updateLocale(en);
      storage.write('langCode', 'en');
    } else if (value == 'ru') {
      Get.updateLocale(ru);
      storage.write('langCode', 'ru');
    } else {
      Get.updateLocale(tm);
      storage.write('langCode', 'tm');
    }
    update();
  }
}

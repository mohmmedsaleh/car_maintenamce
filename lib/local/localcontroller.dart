import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class MyLocalController extends GetxController {
  Locale intialLang = sharepref!.getString("lang") == null
      ? Get.deviceLocale!
      : Locale(sharepref!.getString("lang")!);
  void cangelanguge(String codelocal) {
    Locale locale = Locale(codelocal);
    sharepref!.setString("lang", codelocal);
    Get.updateLocale(locale);
  }
}

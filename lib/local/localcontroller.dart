import 'package:car_maintenance_technicians/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

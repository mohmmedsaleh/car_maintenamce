
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'controllers/login_controller.dart';
import 'controllers/register_controller.dart';
import 'local/local.dart';
import 'local/localcontroller.dart';
import 'string/constans.dart';
import 'view/login/dblogin/dblogin.dart';
import 'view/login/login/login_page.dart';

SharedPreferences? sharepref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  sharepref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var page = false;
  changedPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    page = prefs.getBool('verification') ?? false;
    setState(() {});
    prefs.setBool('login', true);
    if (prefs.getBool("dbpage") == true) {
      prefs.setBool("dbpage", false);
    }
  }

  @override
  void initState() {
    // Get.put(LoginController());
    changedPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyLocalController controller = Get.put(MyLocalController());
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(registerController());
        Get.put(LoginController());
      }),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      translations: Mylocal(),
      locale: controller.intialLang,
      theme: ThemeData(
          //  primarySwatch: Colors.white,
          iconTheme: IconThemeData(
            color: secondaryColor, // Set the default icon color here
          ),
          scaffoldBackgroundColor: primaryColor.withOpacity(0.4),
          // primaryColor:textColor ,
          canvasColor: primaryColor.withOpacity(0.4),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: textColor, fontFamily: 'Sukar')),
      home:
          // AuthenticateFaceView()
          // const MyWidget()
          page == true
              ? LoginPage()
              : Dblogin(
                  isUpdate: false,
                ),
    );
  }
}

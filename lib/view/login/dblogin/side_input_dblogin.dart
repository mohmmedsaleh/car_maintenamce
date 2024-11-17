import 'package:car_maintenance_technicians/controllers/login_controller.dart';
import 'package:car_maintenance_technicians/model/loginmodel.dart';
import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:car_maintenance_technicians/view/login/login/login_page.dart';
import 'package:car_maintenance_technicians/widget/button.dart';
import 'package:car_maintenance_technicians/widget/Text_Field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dbscrean extends StatefulWidget {
  Dbscrean({
    this.isUpdate = false,
    super.key,
  });
  bool isUpdate;
  @override
  State<Dbscrean> createState() => _DbscreanState();
}

class _DbscreanState extends State<Dbscrean> {
  final TextEditingController dbName = TextEditingController();

  final TextEditingController odooURL = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final LoginController controller = Get.put(LoginController());
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    if (widget.isUpdate) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dbName.text = prefs.getString('db') ?? '';
      odooURL.text = prefs.getString('url') ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = heightofpage(context);
    return SafeArea(
        child: Scaffold(
      body: Container(
          color: const Color(0xFF1860a3),
          height: height,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "serverconction".tr,
                    style: title2,
                  ),
                  ContainerTextField(
                    controller: dbName,
                    prefixIcon: const Icon(
                      Icons.done,
                      color: textColor,
                    ),
                    hintText: "db_hent".tr,
                    labelText: "db_hent".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "db_valid".tr;
                      }
                      return null;
                    },
                  ),
                  ContainerTextField(
                    controller: odooURL,
                    prefixIcon:
                        const Icon(Icons.http_rounded, color: textColor),
                    hintText: 'http://your Localhost:your port number',
                    labelText: "url_hent".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "url_valid".tr;
                      }
                      return null;
                    },
                  ),
                  Obx(() {
                    if (controller.authenticateLoading.value) {
                      return const CircularProgressIndicator();
                    } else {
                      return ButtonElevated(
                          minimumSize: 80,
                          right: 120,
                          left: 120,
                          text: "conction".tr,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              LoginModel loginModel = LoginModel(
                                  db: dbName.text,
                                  url: odooURL.text,
                                  login:
                                      // "admin",
                                      'wo_admin',
                                  password:
                                      // "admin",
                                      'wo_admin\$yousentech&2023',
                                  pin: "");
                              controller
                                  .cheakconnection(loginModel: loginModel)
                                  .then((value) async {
                                if (value == "true") {
                                  Get.snackbar(
                                    "conction".tr,
                                    "conctionsucc".tr,
                                    margin: const EdgeInsets.only(
                                        right: defaultPadding * 4,
                                        bottom: defaultPadding * 2,
                                        left: defaultPadding * 4),
                                    titleText: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "conction".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                    messageText: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "conctionsucc".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    duration: const Duration(seconds: 10),
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('db', dbName.text);
                                  prefs.setString('url', odooURL.text);
                                  // prefs.clear();
                                  prefs.setBool('verification', true);
                                  prefs.setBool('dbpage', false);
                                  Get.to(() => LoginPage());
                                } else {
                                  Get.snackbar(
                                    "loginpage_valid_t".tr,
                                    "يرجاء التأكد من اسم قاعدة البيانات او الرابط",
                                    margin: const EdgeInsets.only(
                                        right: defaultPadding * 4,
                                        bottom: defaultPadding * 2,
                                        left: defaultPadding * 4),
                                    titleText: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "loginpage_valid_t".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                    messageText: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "datbase_error".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    duration: const Duration(seconds: 10),
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              });
                            }
                          });
                    }
                  }),
                ],
              ),
            ),
          )
          // containr2(
          //     dbName: dbName, odooURL: odooURL, formKey: _formKey);
          //Container_input(
          // height: height / 4,
          // dbName: dbName,
          // odooURL: odooURL); // or return null;
          ),
    ));
  }
}

class containr2 extends StatelessWidget {
  const containr2({
    super.key,
    required this.dbName,
    required this.odooURL,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final TextEditingController dbName;
  final TextEditingController odooURL;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "signup".tr,
          style: title2,
        ),

        ContainerTextField(
          controller: dbName,
          prefixIcon: const Icon(
            Icons.done,
            color: textColor,
          ),
          hintText: "db_hent".tr,
          labelText: "db_hent".tr,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "db_valid".tr;
            }
            return null;
          },
        ),
        // ContainerTextField(
        //   controller: odooURL,
        //   prefixIcon: const Icon(Icons.http_rounded, color: textColor),
        //   hintText: 'http://your Localhost:your port number',
        //   labelText: "url_hent".tr,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return "url_valid".tr;
        //     }
        //     return null;
        //   },
        // ),
        // Obx(() {
        //   if (controller.authenticateLoading.value) {
        //     return const CircularProgressIndicator();
        //   } else {
        //     return
        // ButtonElevated(
        //     minimumSize: 80,
        //     right: 120,
        //     left: 120,
        //     text: "signup".tr,
        //     onPressed: () async {
        //       if (_formKey.currentState!.validate()) {
        //         SharedPreferences prefs = await SharedPreferences.getInstance();
        //         prefs.setString('db', dbName.text);
        //         prefs.setString('url', odooURL.text);
        //         prefs.setBool('dbpage', false);
        //         Get.to(() => const LoginPage());
        //       }
        //       //   LoginModel loginModel = LoginModel(
        //       //       db: dbName.text,
        //       //       url: odooURL.text,
        //       //       login: 'admin',
        //       //       password: 'admin',
        //       //       pin: "2001");
        //       //   controller
        //       //       .authenticate(loginModel)
        //       //       .then((value) {
        //       //     if (value == "true") {
        //       //       Get.to(() => const displaycars());

        //       //       // Get.to(() => const HomePage());
        //       //     } else {
        //       //       Get.snackbar(
        //       //           'error maseeg', value.toString(),
        //       //           titleText: const Text(
        //       //             'error maseeg',
        //       //             style: subtitlestyle,
        //       //           ),
        //       //           messageText: Text(
        //       //             value.toString(),
        //       //             style: subtitlestyle,
        //       //           ),
        //       //           duration: const Duration(seconds: 5),
        //       //           snackPosition: SnackPosition.BOTTOM,
        //       //           backgroundColor: deepPurple);
        //       //     }
        //       //   });
        //       // }
        //       //       });
        //       // }
        //     })
      ],
    );
  }
}

class Container_input extends StatelessWidget {
  Container_input({
    super.key,
    required this.height,
    required this.dbName,
    required this.odooURL,
  });

  final double height;
  final TextEditingController dbName;
  final TextEditingController odooURL;
  final _formKey = GlobalKey<FormState>();
  // final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1860a3),
      margin: EdgeInsets.only(
          top: height / 4,
          bottom: height / 4,
          right: height / 6,
          left: height / 6),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "signup".tr,
              style: title2,
            ),

            ContainerTextField(
              controller: dbName,
              prefixIcon: const Icon(
                Icons.done,
                color: textColor,
              ),
              hintText: "db_hent".tr,
              labelText: "db_hent".tr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "db_valid".tr;
                }
                return null;
              },
            ),
            ContainerTextField(
              controller: odooURL,
              prefixIcon: const Icon(Icons.http_rounded, color: textColor),
              hintText: 'http://your Localhost:your port number',
              labelText: "url_hent".tr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "url_valid".tr;
                }
                return null;
              },
            ),
            // Obx(() {
            //   if (controller.authenticateLoading.value) {
            //     return const CircularProgressIndicator();
            //   } else {
            //     return
            ButtonElevated(
                minimumSize: 80,
                right: 120,
                left: 120,
                text: "signup".tr,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('db', dbName.text);
                    prefs.setString('url', odooURL.text);
                    prefs.setBool('dbpage', false);
                    Get.to(() => LoginPage());
                  }
                  //   LoginModel loginModel = LoginModel(
                  //       db: dbName.text,
                  //       url: odooURL.text,
                  //       login: 'admin',
                  //       password: 'admin',
                  //       pin: "2001");
                  //   controller
                  //       .authenticate(loginModel)
                  //       .then((value) {
                  //     if (value == "true") {
                  //       Get.to(() => const displaycars());

                  //       // Get.to(() => const HomePage());
                  //     } else {
                  //       Get.snackbar(
                  //           'error maseeg', value.toString(),
                  //           titleText: const Text(
                  //             'error maseeg',
                  //             style: subtitlestyle,
                  //           ),
                  //           messageText: Text(
                  //             value.toString(),
                  //             style: subtitlestyle,
                  //           ),
                  //           duration: const Duration(seconds: 5),
                  //           snackPosition: SnackPosition.BOTTOM,
                  //           backgroundColor: deepPurple);
                  //     }
                  //   });
                  // }
                  //       });
                  // }
                })
          ],
        ),
      ),
    );
  }
}

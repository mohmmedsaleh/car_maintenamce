import 'package:car_maintenance_technicians/controllers/register_controller.dart';
import 'package:car_maintenance_technicians/model/loginmodel.dart';
import 'package:car_maintenance_technicians/responsive.dart';
import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:car_maintenance_technicians/view/login/dblogin/dblogin.dart';
import 'package:car_maintenance_technicians/view/register/addimage/addimage.dart';
import 'package:car_maintenance_technicians/widget/button.dart';
import 'package:car_maintenance_technicians/widget/Text_Field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminscrean extends StatefulWidget {
  const adminscrean({
    super.key,
  });

  @override
  State<adminscrean> createState() => _adminscreanState();
}

class _adminscreanState extends State<adminscrean> {
  final TextEditingController userName = TextEditingController();

  final TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final registerController controller = Get.put(registerController());

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
                    "adminlogin".tr,
                    style: title2,
                  ),
                  ContainerTextField(
                    controller: userName,
                    prefixIcon: const Icon(
                      Icons.done,
                      color: textColor,
                    ),
                    hintText: "username".tr,
                    labelText: "username".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "username".tr;
                      }
                      return null;
                    },
                  ),
                  ContainerTextField(
                    controller: password,
                    prefixIcon: const Icon(Icons.password, color: textColor),
                    hintText: 'password'.tr,
                    labelText: "password".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "password".tr;
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
                          text: "login".tr,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              var db = prefs.getString('db');
                              var url = prefs.getString('url');
                              LoginModel loginModel = LoginModel(
                                db: db.toString(),
                                url: url.toString(),
                                login: userName.text,
                                password: password.text,
                              );
                              controller
                                  .authenticate(loginModel: loginModel)
                                  .then((value) {
                                if (value == true) {
                                  Get.offAll(() => Addimage());
                                } else {
                                  if (db == null || url == null) {
                                    Get.snackbar("loginpage_valid_t".tr,
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
                                        messageText: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "datbase_error".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: defaultPadding,
                                            ),
                                            ElevatedButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: bgColor,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      defaultPadding * 3,
                                                  vertical: defaultPadding /
                                                      (Responsive.isMobile(
                                                              context)
                                                          ? 2
                                                          : 1),
                                                ),
                                              ),
                                              child: Text(
                                                "back".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              onPressed: () {
                                                Get.back();
                                                prefs.setBool('dbpage', true);
                                                Get.off(() => Dblogin());
                                              },
                                            )
                                          ],
                                        ),
                                        duration: const Duration(seconds: 10),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: primaryColor);
                                  } else {
                                    Get.snackbar(
                                        "loginpage_valid_t".tr,
                                        "the username or password you enter it is not existing"
                                            .tr,
                                        titleText: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "loginpage_valid_t".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ),
                                        messageText: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "the username or password you enter it is not existing"
                                                .tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                        duration: const Duration(seconds: 10),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: primaryColor);
                                  }
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

// class containr2 extends StatelessWidget {
//   const containr2({
//     super.key,
//     required this.dbName,
//     required this.odooURL,
//     required GlobalKey<FormState> formKey,
//   }) : _formKey = formKey;

//   final TextEditingController dbName;
//   final TextEditingController odooURL;
//   final GlobalKey<FormState> _formKey;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           "signup".tr,
//           style: title2,
//         ),

//         ContainerTextField(
//           controller: dbName,
//           prefixIcon: const Icon(
//             Icons.done,
//             color: textColor,
//           ),
//           hintText: "db_hent".tr,
//           labelText: "db_hent".tr,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return "db_valid".tr;
//             }
//             return null;
//           },
//         ),
//         // ContainerTextField(
//         //   controller: odooURL,
//         //   prefixIcon: const Icon(Icons.http_rounded, color: textColor),
//         //   hintText: 'http://your Localhost:your port number',
//         //   labelText: "url_hent".tr,
//         //   validator: (value) {
//         //     if (value == null || value.isEmpty) {
//         //       return "url_valid".tr;
//         //     }
//         //     return null;
//         //   },
//         // ),
//         // Obx(() {
//         //   if (controller.authenticateLoading.value) {
//         //     return const CircularProgressIndicator();
//         //   } else {
//         //     return
//         // ButtonElevated(
//         //     minimumSize: 80,
//         //     right: 120,
//         //     left: 120,
//         //     text: "signup".tr,
//         //     onPressed: () async {
//         //       if (_formKey.currentState!.validate()) {
//         //         SharedPreferences prefs = await SharedPreferences.getInstance();
//         //         prefs.setString('db', dbName.text);
//         //         prefs.setString('url', odooURL.text);
//         //         prefs.setBool('dbpage', false);
//         //         Get.to(() => const LoginPage());
//         //       }
//         //       //   LoginModel loginModel = LoginModel(
//         //       //       db: dbName.text,
//         //       //       url: odooURL.text,
//         //       //       login: 'admin',
//         //       //       password: 'admin',
//         //       //       pin: "2001");
//         //       //   controller
//         //       //       .authenticate(loginModel)
//         //       //       .then((value) {
//         //       //     if (value == "true") {
//         //       //       Get.to(() => const displaycars());

//         //       //       // Get.to(() => const HomePage());
//         //       //     } else {
//         //       //       Get.snackbar(
//         //       //           'error maseeg', value.toString(),
//         //       //           titleText: const Text(
//         //       //             'error maseeg',
//         //       //             style: subtitlestyle,
//         //       //           ),
//         //       //           messageText: Text(
//         //       //             value.toString(),
//         //       //             style: subtitlestyle,
//         //       //           ),
//         //       //           duration: const Duration(seconds: 5),
//         //       //           snackPosition: SnackPosition.BOTTOM,
//         //       //           backgroundColor: deepPurple);
//         //       //     }
//         //       //   });
//         //       // }
//         //       //       });
//         //       // }
//         //     })
//       ],
//     );
//   }
// }

// class Container_input extends StatelessWidget {
//   Container_input({
//     super.key,
//     required this.height,
//     required this.dbName,
//     required this.odooURL,
//   });

//   final double height;
//   final TextEditingController dbName;
//   final TextEditingController odooURL;
//   final _formKey = GlobalKey<FormState>();
//   // final LoginController controller = Get.put(LoginController());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF1860a3),
//       margin: EdgeInsets.only(
//           top: height / 4,
//           bottom: height / 4,
//           right: height / 6,
//           left: height / 6),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             Text(
//               "signup".tr,
//               style: title2,
//             ),

//             ContainerTextField(
//               controller: dbName,
//               prefixIcon: const Icon(
//                 Icons.done,
//                 color: textColor,
//               ),
//               hintText: "db_hent".tr,
//               labelText: "db_hent".tr,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "db_valid".tr;
//                 }
//                 return null;
//               },
//             ),
//             ContainerTextField(
//               controller: odooURL,
//               prefixIcon: const Icon(Icons.http_rounded, color: textColor),
//               hintText: 'http://your Localhost:your port number',
//               labelText: "url_hent".tr,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "url_valid".tr;
//                 }
//                 return null;
//               },
//             ),
//             // Obx(() {
//             //   if (controller.authenticateLoading.value) {
//             //     return const CircularProgressIndicator();
//             //   } else {
//             //     return
//             ButtonElevated(
//                 minimumSize: 80,
//                 right: 120,
//                 left: 120,
//                 text: "signup".tr,
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     prefs.setString('db', dbName.text);
//                     prefs.setString('url', odooURL.text);
//                     prefs.setBool('dbpage', false);
//                     Get.to(() => LoginPage());
//                   }
//                   //   LoginModel loginModel = LoginModel(
//                   //       db: dbName.text,
//                   //       url: odooURL.text,
//                   //       login: 'admin',
//                   //       password: 'admin',
//                   //       pin: "2001");
//                   //   controller
//                   //       .authenticate(loginModel)
//                   //       .then((value) {
//                   //     if (value == "true") {
//                   //       Get.to(() => const displaycars());

//                   //       // Get.to(() => const HomePage());
//                   //     } else {
//                   //       Get.snackbar(
//                   //           'error maseeg', value.toString(),
//                   //           titleText: const Text(
//                   //             'error maseeg',
//                   //             style: subtitlestyle,
//                   //           ),
//                   //           messageText: Text(
//                   //             value.toString(),
//                   //             style: subtitlestyle,
//                   //           ),
//                   //           duration: const Duration(seconds: 5),
//                   //           snackPosition: SnackPosition.BOTTOM,
//                   //           backgroundColor: deepPurple);
//                   //     }
//                   //   });
//                   // }
//                   //       });
//                   // }
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }

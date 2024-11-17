import 'package:car_maintenance_technicians/controllers/register_controller.dart';
import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:car_maintenance_technicians/view/register/register_face_view.dart';
import 'package:car_maintenance_technicians/widget/button.dart';
import 'package:car_maintenance_technicians/widget/text_field2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addimageinput extends StatefulWidget {
  const Addimageinput({super.key});

  @override
  State<Addimageinput> createState() => _AddimageinputState();
}

class _AddimageinputState extends State<Addimageinput> {
  final registerController controller = Get.find<registerController>();
  bool flag = false;
  final TextEditingController pin = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = heightofpage(context);
    double width = widthofpage(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          color: const Color(0xFF1860a3),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: height / 20,
                    bottom: height / 20,
                    right: width / 20,
                    left: width / 20),
                child: Column(
                  children: [
                    Text(
                      "addimageforemployee".tr,
                      style: title2,
                    ),
                    ContainerTextField(
                      controller: pin,
                      focusNode: _nameFocusNode,
                      onEditingComplete: () {
                        _nameFocusNode.unfocus();
                      },
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(
                        Icons.done,
                        color: textColor,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              flag = !flag;
                            });
                          },
                          icon: flag
                              ? const Icon(Icons.visibility,
                                  color: Colors.white)
                              : const Icon(Icons.visibility_off,
                                  color: Colors.white)),
                      obscureText: flag ? false : true,
                      hintText: "pin_hent".tr,
                      labelText: "pin_hent".tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "pin_valid".tr;
                        }
                        return null;
                      },
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //       right: width / 10,
                    //       left: width / 10,
                    //       top: 5,
                    //       bottom: 5),
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         height: 80,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: 3,
                    //           itemBuilder: (context, index) {
                    //             return InkWell(
                    //               onTap: () {
                    //                 setState(() {
                    //                   pin.text += (index + 7).toString();
                    //                 });
                    //               },
                    //               child: Container(
                    //                 margin: EdgeInsets.all(15),
                    //                 height: 50,
                    //                 width: (width / 3) / 4 + 10,
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.blue,
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 child: Center(
                    //                     child: Text(
                    //                   "${index + 7}",
                    //                   style: const TextStyle(
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.bold),
                    //                 )),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //       Container(
                    //         height: 80,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: 3,
                    //           itemBuilder: (context, index) {
                    //             return InkWell(
                    //               onTap: () {
                    //                 setState(() {
                    //                   pin.text += (index + 4).toString();
                    //                 });
                    //               },
                    //               child: Container(
                    //                 margin: const EdgeInsets.all(15),
                    //                 height: 50,
                    //                 width: (width / 3) / 4 + 10,
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.blue,
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 child: Center(
                    //                     child: Text(
                    //                   "${index + 4}",
                    //                   style: const TextStyle(
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.bold),
                    //                 )),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //       Container(
                    //         height: 80,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: 3,
                    //           itemBuilder: (context, index) {
                    //             return InkWell(
                    //               onTap: () {
                    //                 setState(() {
                    //                   pin.text += (index + 1).toString();
                    //                 });
                    //               },
                    //               child: Container(
                    //                 margin: const EdgeInsets.all(15),
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.blue,
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 height: 50,
                    //                 width: (width / 3) / 4 + 10,
                    //                 child: Center(
                    //                     child: Text(
                    //                   "${index + 1}",
                    //                   style: const TextStyle(
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.bold),
                    //                 )),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //       Container(
                    //         height: 80,
                    //         child: ListView(
                    //           scrollDirection: Axis.horizontal,
                    //           children: [
                    //             InkWell(
                    //               onTap: () {
                    //                 final text = pin.text;
                    //                 if (text.isNotEmpty) {
                    //                   final newText =
                    //                       text.substring(0, text.length - 1);

                    //                   setState(() {
                    //                     pin.text = newText;
                    //                   });
                    //                 }
                    //               },
                    //               child: Center(
                    //                 child: Container(
                    //                     margin: EdgeInsets.all(15),
                    //                     height: 80,
                    //                     width: (width / 2) / 5,
                    //                     child: const Icon(
                    //                       Icons.backspace,
                    //                       color: Colors.white,
                    //                       size: 30,
                    //                     )
                    //                     //Text("delete"),
                    //                     ),
                    //               ),
                    //             ),
                    //             InkWell(
                    //               onTap: () {
                    //                 setState(() {
                    //                   pin.text += (0).toString();
                    //                 });
                    //               },
                    //               child: Container(
                    //                 margin: const EdgeInsets.all(15),
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.blue,
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 height: 50,
                    //                 width: (width / 3) / 5 + 10,
                    //                 child: const Center(
                    //                     child: Text(
                    //                   "0",
                    //                   style: TextStyle(
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.bold),
                    //                 )),
                    //               ),
                    //             ),
                    //             InkWell(
                    //               onTap: () {
                    //                 setState(() {
                    //                   pin.clear();
                    //                 });
                    //               },
                    //               child: Center(
                    //                 child: Container(
                    //                     margin: const EdgeInsets.all(15),
                    //                     height: 80,
                    //                     width: (width / 2) / 5,
                    //                     child: const Icon(
                    //                       Icons.delete,
                    //                       color: Colors.white,
                    //                       size: 30,
                    //                     )),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // ButtonElevated(
                    //     minimumSize: 80,
                    //     right: 120,
                    //     left: 120,
                    //     text: "dd".tr,
                    //     onPressed: () async {
                    //       Get.off(() => RegisterFaceView());
                    //     }),
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
                              controller.cheackpin(pin: pin.text).then((value) {
                                if (value == true) {
                                  Get.off(() => const RegisterFaceView());
                                }
                              });
                              //   SharedPreferences prefs =
                              //       await SharedPreferences.getInstance();

                              //   var db = prefs.getString('db');
                              //   var url = prefs.getString('url');
                              //   LoginModel loginModel = LoginModel(
                              //       db: db.toString(),
                              //       url: url.toString(),
                              //       login: 'admin',
                              //       password: 'admin',
                              //       pin: pin.text);
                              controller.cheackpin(pin: pin.text).then((value) {
                                if (controller.hasData == true) {
                                  Get.off(() => const RegisterFaceView());
                                } else {
                                  Get.snackbar("loginpage_valid_t".tr,
                                      "loginpage_valid_m".tr,
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
                                          "loginpage_valid_m".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      duration: const Duration(seconds: 10),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: primaryColor);
                                }
                              });
                              //       if (controller.hasData == true) {
                              //         Get.off(() => regiteradmin());
                              //         // Get.off(() => HomePage(
                              //         //       technicalId: controller
                              //         //           .userInformation["technical_id"],
                              //         //     ));
                              //         // prefs.setBool('login', false);
                              //       } else {
                              //         Get.snackbar("loginpage_valid_t".tr,
                              //             "loginpage_valid_m".tr,
                              //             titleText: Align(
                              //               alignment: Alignment.topRight,
                              //               child: Text(
                              //                 "loginpage_valid_t".tr,
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .titleMedium,
                              //               ),
                              //             ),
                              //             messageText: Align(
                              //               alignment: Alignment.topRight,
                              //               child: Text(
                              //                 "loginpage_valid_m".tr,
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .titleSmall,
                              //               ),
                              //             ),
                              //             duration: const Duration(seconds: 10),
                              //             snackPosition: SnackPosition.BOTTOM,
                              //             backgroundColor: primaryColor);
                              //       }
                              //     } else {
                              //       Get.snackbar("loginpage_valid_t".tr,
                              //           "يرجاء التأكد من اسم قاعدة البيانات او الرابط",
                              //           margin: const EdgeInsets.only(
                              //               right: defaultPadding * 4,
                              //               bottom: defaultPadding * 2,
                              //               left: defaultPadding * 4),
                              //           titleText: Align(
                              //             alignment: Alignment.center,
                              //             child: Text(
                              //               "loginpage_valid_t".tr,
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .titleMedium,
                              //             ),
                              //           ),
                              //           messageText: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceEvenly,
                              //             children: [
                              //               Align(
                              //                 alignment: Alignment.center,
                              //                 child: Text(
                              //                   "datbase_error".tr,
                              //                   style: Theme.of(context)
                              //                       .textTheme
                              //                       .titleSmall,
                              //                 ),
                              //               ),
                              //               const SizedBox(
                              //                 height: defaultPadding,
                              //               ),
                              //               ElevatedButton(
                              //                 style: TextButton.styleFrom(
                              //                   backgroundColor: bgColor,
                              //                   padding: EdgeInsets.symmetric(
                              //                     horizontal: defaultPadding * 3,
                              //                     vertical: defaultPadding /
                              //                         (Responsive.isMobile(
                              //                                 context)
                              //                             ? 2
                              //                             : 1),
                              //                   ),
                              //                 ),
                              //                 child: Text(
                              //                   "back".tr,
                              //                   style: Theme.of(context)
                              //                       .textTheme
                              //                       .titleMedium,
                              //                 ),
                              //                 onPressed: () {
                              //                   Get.back();
                              //                   prefs.setBool('dbpage', true);
                              //                   Get.off(() => Dblogin());
                              //                 },
                              //               )
                              //             ],
                              //           ),
                              //           duration: const Duration(seconds: 10),
                              //           snackPosition: SnackPosition.BOTTOM,
                              //           backgroundColor: primaryColor);
                              //     }
                              //   });
                            }
                          },
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

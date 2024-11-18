import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../controllers/register_controller.dart';
import '../../model/user_model.dart';
import '../../string/constans.dart';
import '../../widget/button.dart';
import '../../widget/camera_view.dart';
import '../../widget/custom_button.dart';
import '../../widget/extract_face_feature.dart';
import '../login/login/login_page.dart';
import 'addimage/addimage.dart';

class RegisterFaceView extends StatefulWidget {
  const RegisterFaceView({Key? key}) : super(key: key);

  @override
  State<RegisterFaceView> createState() => _RegisterFaceViewState();
}

class _RegisterFaceViewState extends State<RegisterFaceView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  String? _image;
  FaceFeatures? _faceFeatures;
  registerController controller = Get.find<registerController>();
  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => Addimage());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: primaryWhite,
            )),
        centerTitle: true,
        backgroundColor: const Color(0xFF1860a3),
        title: Text(
          "addimageforemployee".tr,
          style: const TextStyle(color: primaryWhite),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1860a3),
              Color(0xFF1860a3),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              // padding: EdgeInsets.fromLTRB(0.05.sw, 0.025.sh, 0.05.sw, 0.04.sh),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 224, 222, 222),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CameraView(
                    onImage: (image) {
                      setState(() {
                        _image = base64Encode(image);
                      });
                    },
                    onInputImage: (inputImage) async {
                      _faceFeatures =
                          await extractFaceFeatures(inputImage, _faceDetector);
                      setState(() {});
                    },
                  ),
                  const Spacer(),
                  if (_image != null)
                    CustomButton(
                      text: "sendphoto".tr,
                      onTap: () {
                        // FocusScope.of(context).unfocus();

                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: false,
                        //   builder: (context) => const Center(
                        //     child: CircularProgressIndicator(
                        //       color: accentColor,
                        //     ),
                        //   ),
                        // );
                        if (_faceFeatures == null) {
                          Get.snackbar("no face detcted", "no face detcted",
                              titleText: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "no face detcted",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              messageText: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "no face detcted",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              duration: const Duration(seconds: 10),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: primaryColor);
                        }

                        // print("fe===============${_faceFeatures}");
                        UserModel user = UserModel(
                          id: controller.userInformation["emp_id"],
                          image: _image,
                          faceFeatures: _faceFeatures,
                        );
                        controller.adduser(user: user);
                        Get.offAll(() => const DoneRegister());
                        // FirebaseFirestore.instance
                        //     .collection("users")
                        //     .doc(userId)
                        //     .set(user.toJson())
                        //     .catchError((e) {
                        //   log("Registration Error: $e");
                        //   Navigator.of(context).pop();
                        //   CustomSnackBar.errorSnackBar(
                        //       "Registration Failed! Try Again.");
                        // }).whenComplete(() {
                        //   Navigator.of(context).pop();
                        //   CustomSnackBar.successSnackBar("Registration Success!");
                        //   Future.delayed(const Duration(seconds: 1), () {
                        //     //Reaches HomePage
                        //     Navigator.of(context)
                        //       ..pop()
                        //       ..pop()
                        //       ..pop();
                        //   });
                        // });
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoneRegister extends StatelessWidget {
  const DoneRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          color: const Color.fromARGB(255, 68, 117, 163),
          child: Column(children: [
            Text(
              "changedata".tr,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/images/done.png"),
            ),
            ButtonElevated(
              onPressed: () => Get.offAll(() => LoginPage()),
              text: "logoff".tr,
              right: 50,
              left: 50,
            ),
            ButtonElevated(
              onPressed: () => Get.offAll(() => Addimage()),
              text: "takephoto2".tr,
              right: 50,
              left: 50,
            )
          ]),
        ),
      ),
    );
  }
} 


// class rigister extends StatefulWidget {
//   const rigister({super.key});

//   @override
//   State<rigister> createState() => _rigisterState();
// }

// class _rigisterState extends State<rigister> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: CustomButton(
//         text: "Start Registering",
//         onTap: () {
//           FocusScope.of(context).unfocus();

//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) => const Center(
//               child: CircularProgressIndicator(
//                 color: accentColor,
//               ),
//             ),
//           );

//           // String userId = Uuid().v1();
//           // UserModel user = UserModel(
//           //   id: userId,
//           //   name: _nameController.text.trim().toUpperCase(),
//           //   image: widget.image,
//           //   registeredOn: DateTime.now().millisecondsSinceEpoch,
//           //   faceFeatures: widget.faceFeatures,
//           // );

//           // FirebaseFirestore.instance
//           //     .collection("users")
//           //     .doc(userId)
//           //     .set(user.toJson())
//           //     .catchError((e) {
//           //   log("Registration Error: $e");
//           //   Navigator.of(context).pop();
//           //   CustomSnackBar.errorSnackBar(
//           //       "Registration Failed! Try Again.");
//           // }).whenComplete(() {
//           //   Navigator.of(context).pop();
//           //   CustomSnackBar.successSnackBar("Registration Success!");
//           //   Future.delayed(const Duration(seconds: 1), () {
//           //     //Reaches HomePage
//           //     Navigator.of(context)
//           //       ..pop()
//           //       ..pop()
//           //       ..pop();
//           //   });
//           // });
//         },
//       ),
//     );
//   }
// }

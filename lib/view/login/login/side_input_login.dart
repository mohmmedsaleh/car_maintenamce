import 'dart:io';

import 'package:car_maintenance_technicians/controllers/login_controller.dart';
import 'package:car_maintenance_technicians/main.dart';
import 'package:car_maintenance_technicians/model/loginmodel.dart';
import 'package:car_maintenance_technicians/model/user_model.dart';
import 'package:car_maintenance_technicians/responsive.dart';
import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:car_maintenance_technicians/view/home/home_page.dart';
import 'package:car_maintenance_technicians/view/login/facedetcted/authenticate_face_view.dart';
import 'package:car_maintenance_technicians/view/login/dblogin/dblogin.dart';
import 'package:car_maintenance_technicians/view/login/login/login_page.dart';
import 'package:car_maintenance_technicians/widget/button.dart';
import 'package:car_maintenance_technicians/widget/custom_snackbar.dart';
import 'package:car_maintenance_technicians/widget/extract_face_feature.dart';
import 'package:car_maintenance_technicians/widget/text_field2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_face_api/face_api.dart' as regula;

class Logininput extends StatefulWidget {
  const Logininput({super.key});

  @override
  State<Logininput> createState() => _LogininputState();
}

class _LogininputState extends State<Logininput> {
  final LoginController controller = Get.put(LoginController());
  bool flag = false;
  final TextEditingController pin = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  FaceFeatures? _faceFeatures;
  var image1 = regula.MatchFacesImage();
  var image2 = regula.MatchFacesImage();

  final TextEditingController _nameController = TextEditingController();
  String _similarity = "";
  bool _canAuthenticate = false;
  List<dynamic> users = [];
  bool userExists = false;
  UserModel? loggingUser;
  bool isMatching = false;
  int trialNumber = 1;
  File? _image;
  ImagePicker? _imagePicker;
  InputImage? inputImage;
  @override
  void dispose() {
    _faceDetector.close();
    print("closeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.authenticateLoading.value = false;
    _imagePicker = ImagePicker();
  }

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
                      "login".tr,
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
                              _nameFocusNode.unfocus();
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              var db = prefs.getString('db');
                              var url = prefs.getString('url');
                              LoginModel loginModel = LoginModel(
                                  db: db.toString(),
                                  url: url.toString(),
                                  login: "admin",
                                  // 'wo_admin',
                                  password: "admin",
                                  // 'wo_admin\$yousentech&2023',
                                  pin: pin.text);
                              print(loginModel.password);
                              controller
                                  .authenticate(loginModel: loginModel)
                                  .then((value) async {
                                if (value == "true") {
                                  if (controller.hasData == true) {
                                    Get.off(() => HomePage(
                                          technicalId: controller
                                              .userInformation["technical_id"],
                                        ));

                                    ///start
                                    // if (controller.hasfeatures == true) {
                                    //   await _getImage().then((value) async {
                                    //     if (inputImage != null) {
                                    //       await extractFaceFeatures(
                                    //               inputImage!, _faceDetector)
                                    //           .then((value) async {
                                    //         _faceFeatures = value;
                                    //
                                    //         await _fetchUsersAndMatchFace();
                                    //       });
                                    //     } else {
                                    //       Get.snackbar(
                                    //           "loginpage_valid_t".tr,
                                    //           "you have not take photo pelease try login agin"
                                    //               .tr,
                                    //           titleText: Align(
                                    //             alignment: Alignment.topRight,
                                    //             child: Text(
                                    //               "loginpage_valid_t".tr,
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .titleMedium,
                                    //             ),
                                    //           ),
                                    //           messageText: Align(
                                    //             alignment: Alignment.topRight,
                                    //             child: Text(
                                    //               "you have not take photo pelease try login agin"
                                    //                   .tr,
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .titleSmall,
                                    //             ),
                                    //           ),
                                    //           duration:
                                    //               const Duration(seconds: 10),
                                    //           snackPosition:
                                    //               SnackPosition.BOTTOM,
                                    //           backgroundColor: primaryColor);
                                    //     }
                                    //   });
                                    //
                                    //   controller.authenticateLoading.value =
                                    //       false;
                                    //   // Get.to(() => AuthenticateFaceView());
                                    // } else {
                                    //   Get.snackbar(
                                    //       "loginpage_valid_t".tr,
                                    //       "conect with the admin to add photo  for you"
                                    //           .tr,
                                    //       titleText: Align(
                                    //         alignment: Alignment.topRight,
                                    //         child: Text(
                                    //           "loginpage_valid_t".tr,
                                    //           style: Theme.of(context)
                                    //               .textTheme
                                    //               .titleMedium,
                                    //         ),
                                    //       ),
                                    //       messageText: Align(
                                    //         alignment: Alignment.topRight,
                                    //         child: Text(
                                    //           "conect with the admin to add photo  for you"
                                    //               .tr,
                                    //           style: Theme.of(context)
                                    //               .textTheme
                                    //               .titleSmall,
                                    //         ),
                                    //       ),
                                    //       duration: const Duration(seconds: 10),
                                    //       snackPosition: SnackPosition.BOTTOM,
                                    //       backgroundColor: primaryColor);
                                    // }
/////end
                                    // Get.off(() => HomePage(
                                    //       technicalId: controller
                                    //           .userInformation["technical_id"],
                                    //     ));
                                    // prefs.setBool('login', false);
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
                                } else {
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
                                                horizontal: defaultPadding * 3,
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
                                }
                              });
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

  Future _setImage(Uint8List imageToAuthenticate) async {
    image2.bitmap = base64Encode(imageToAuthenticate);
    image2.imageType = regula.ImageType.PRINTED;

    setState(() {
      _canAuthenticate = true;
    });
  }

//call in _fetchUsersAndMatchFace
  double compareFaces(FaceFeatures face1, FaceFeatures face2) {
    double distEar1 = euclideanDistance(face1.rightEar!, face1.leftEar!);
    double distEar2 = euclideanDistance(face2.rightEar!, face2.leftEar!);

    double ratioEar = distEar1 / distEar2;

    double distEye1 = euclideanDistance(face1.rightEye!, face1.leftEye!);
    double distEye2 = euclideanDistance(face2.rightEye!, face2.leftEye!);

    double ratioEye = distEye1 / distEye2;

    double distCheek1 = euclideanDistance(face1.rightCheek!, face1.leftCheek!);
    double distCheek2 = euclideanDistance(face2.rightCheek!, face2.leftCheek!);

    double ratioCheek = distCheek1 / distCheek2;

    double distMouth1 = euclideanDistance(face1.rightMouth!, face1.leftMouth!);
    double distMouth2 = euclideanDistance(face2.rightMouth!, face2.leftMouth!);

    double ratioMouth = distMouth1 / distMouth2;

    double distNoseToMouth1 =
        euclideanDistance(face1.noseBase!, face1.bottomMouth!);
    double distNoseToMouth2 =
        euclideanDistance(face2.noseBase!, face2.bottomMouth!);

    double ratioNoseToMouth = distNoseToMouth1 / distNoseToMouth2;

    double ratio =
        (ratioEye + ratioEar + ratioCheek + ratioMouth + ratioNoseToMouth) / 5;
    log(ratio.toString(), name: "Ratio");

    return ratio;
  }

//call in compareFaces
// A function to calculate the Euclidean distance between two points
  double euclideanDistance(Points p1, Points p2) {
    final sqr =
        math.sqrt(math.pow((p1.x! - p2.x!), 2) + math.pow((p1.y! - p2.y!), 2));
    return sqr;
  }

//dirct
  _fetchUsersAndMatchFace() {
    if (controller.userInformation.isNotEmpty) {
      users.clear();

      UserModel user = UserModel.fromJson({
        "id": controller.userInformation['emp_id'],
        "image": controller.userInformation['image'],
        "faceFeatures": controller.userfeatures[0]
      });
      double similarity = compareFaces(_faceFeatures!, user.faceFeatures!);
      if (similarity >= 0.8 && similarity <= 1.5) {
        users.add([user, similarity]);
      }

      log(users.length.toString(), name: "Filtered Users");
      setState(() {
        //Sorts the users based on the similarity.
        //More similar face is put first.
        users.sort((a, b) => (((a.last as double) - 1).abs())
            .compareTo(((b.last as double) - 1).abs()));
      });

      _matchFaces();
      log(trialNumber.toString(), name: " Users");
    } else {
      _showFailureDialog(
        title: "No Users Registered",
        description:
            "Make sure users are registered first before Authenticating.",
      );
    }
  }

//call in _fetchUsersAndMatchFace and _fetchUserByName
  _matchFaces() async {
    bool faceMatched = false;
    for (List user in users) {
      image1.bitmap = (user.first as UserModel).image;
      image1.imageType = regula.ImageType.PRINTED;

      //Face comparing logic.
      var request = regula.MatchFacesRequest();
      request.images = [image1, image2];
      dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));

      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
          jsonEncode(response!.results), 0.75);

      var split =
          regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
      setState(() {
        _similarity = split!.matchedFaces.isNotEmpty
            ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)
            : "error";
        log("similarity: $_similarity");

        if (_similarity != "error" && double.parse(_similarity) > 90.00) {
          faceMatched = true;
          loggingUser = user.first;
        } else {
          faceMatched = false;
        }
      });
      if (faceMatched) {
        setState(() {
          trialNumber = 1;
          isMatching = false;
        });

        if (mounted) {
          Get.offAll(() => HomePage(
                technicalId: controller.userInformation["technical_id"],
              ));
          controller.authenticateLoading.value = false;
        }
        break;
      }
    }
    if (!faceMatched) {
      if (trialNumber == 4) {
        setState(() => trialNumber = 1);
        _showFailureDialog(
          title: "Redeem Failed",
          description: "Face doesn't match. Please try again.",
        );
      } else if (trialNumber == 3) {
        //After 2 trials if the face doesn't match automatically, the registered name prompt
        //will be shown. After entering the name the face registered with the entered name will
        //be fetched and will try to match it with the to be authenticated face.
        //If the faces match, Viola!. Else it means the user is not registered yet.

        setState(() {
          isMatching = false;
          trialNumber++;
        });
      } else {
        setState(() => trialNumber++);
        _showFailureDialog(
          title: "Redeem Failed",
          description: "Face doesn't match. Please try again.",
        );
      }
    }
  }

// //call in _matchFaces
//   _fetchUserByName(String orgID) {
//     // FirebaseFirestore.instance
//     //     .collection("users")
//     //     .where("organizationId", isEqualTo: orgID)
//     //     .get()
//     //     .catchError((e) {
//     //   log("Getting User Error: $e");
//     //   setState(() => isMatching = false);
//     //   _playFailedAudio;
//     //   CustomSnackBar.errorSnackBar("Something went wrong. Please try again.");
//     // }).then((snap) {
//     //   if (snap.docs.isNotEmpty) {
//     //     users.clear();

//     //     for (var doc in snap.docs) {
//     //       setState(() {
//     //         users.add([UserModel.fromJson(doc.data()), 1]);
//     //       });
//     //     }
//     //     _matchFaces();
//     //   } else {
//     //     setState(() => trialNumber = 1);
//     //     _showFailureDialog(
//     //       title: "User Not Found",
//     //       description:
//     //           "User is not registered yet. Register first to authenticate.",
//     //     );
//     //   }
//     // });
//   }

//call in _fetchUsersAndMatchFace ,_matchFaces and _fetchUserByName
  _showFailureDialog({
    required String title,
    required String description,
  }) {
    setState(() => isMatching = false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              color: primaryBlack,
            ),
          ),
          content: Text(
            description,
            style: const TextStyle(
              color: primaryBlack,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                // Get.offAll(() => LoginPage());
              },
              child: const Text(
                "Ok",
                style: TextStyle(
                  color: primaryBlack,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  ////
  Future _getImage() async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
        source: ImageSource.camera,
        maxWidth: 400,
        maxHeight: 400,
        preferredCameraDevice: CameraDevice.front
        // imageQuality: 50,
        );
    print("pickedFile$pickedFile");
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });

    Uint8List imageBytes = _image!.readAsBytesSync();
    _setImage(imageBytes);

    inputImage = InputImage.fromFilePath(path);
  }
}

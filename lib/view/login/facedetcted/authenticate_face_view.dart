// import 'dart:convert';
// import 'dart:developer';
// import 'dart:math' as math;

// import 'package:car_maintenance_technicians/controllers/login_controller.dart';
// import 'package:car_maintenance_technicians/model/user_model.dart';
// import 'package:car_maintenance_technicians/string/constans.dart';
// import 'package:car_maintenance_technicians/view/home/home_page.dart';
// import 'package:car_maintenance_technicians/view/login/login/login_page.dart';
// import 'package:car_maintenance_technicians/widget/custom_snackbar.dart';
// import 'package:car_maintenance_technicians/widget/extract_face_feature.dart';
// import 'package:car_maintenance_technicians/widget/camera_view.dart';
// import 'package:car_maintenance_technicians/widget/custom_button.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_face_api/face_api.dart' as regula;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

// class AuthenticateFaceView extends StatefulWidget {
//   AuthenticateFaceView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<AuthenticateFaceView> createState() => _AuthenticateFaceViewState();
// }

// class _AuthenticateFaceViewState extends State<AuthenticateFaceView> {
//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableLandmarks: true,
//       performanceMode: FaceDetectorMode.accurate,
//     ),
//   );
//   final LoginController controller = Get.find<LoginController>();
//   FaceFeatures? _faceFeatures;
//   var image1 = regula.MatchFacesImage();
//   var image2 = regula.MatchFacesImage();

//   final TextEditingController _nameController = TextEditingController();
//   String _similarity = "";
//   bool _canAuthenticate = false;
//   List<dynamic> users = [];
//   bool userExists = false;
//   UserModel? loggingUser;
//   bool isMatching = false;
//   int trialNumber = 1;

//   @override
//   void dispose() {
//     _faceDetector.close();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(0xFF1860a3),
//         title: const Text("تحقق من الوجه"),
//         elevation: 0,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constrains) => Stack(
//           children: [
//             Container(
//               // width: constrains.maxWidth,
//               // height: constrains.maxHeight,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFF1860a3),
//                     Color(0xFF1860a3),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       height: 300,
//                       width: double.infinity,
//                       // padding:
//                       //     EdgeInsets.fromLTRB(0.05.sw, 0.025.sh, 0.05.sw, 0),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 224, 222, 222),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30),
//                           topRight: Radius.circular(30),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Stack(
//                             children: [
//                               CameraView(
//                                 onImage: (image) {
//                                   _setImage(image);
//                                 },
//                                 onInputImage: (inputImage) async {
//                                   setState(() => isMatching = true);
//                                   _faceFeatures = await extractFaceFeatures(
//                                       inputImage, _faceDetector);
//                                   setState(() => isMatching = false);
//                                 },
//                               ),
//                               // if (isMatching)
//                               //   Align(
//                               //     alignment: Alignment.center,
//                               //     child: Padding(
//                               //       padding: EdgeInsets.only(top: 30),
//                               //       child: const AnimatedView(),
//                               //     ),
//                               //   ),
//                             ],
//                           ),
//                           const Spacer(),
//                           if (_canAuthenticate)
//                             CustomButton(
//                               text: "التحقق",
//                               onTap: () {
//                                 setState(() => isMatching = true);

//                                 _fetchUsersAndMatchFace();
//                               },
//                             ),
//                           // SizedBox(height: 0.038.sh),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// // //dirct
// //   Future _setImage(Uint8List imageToAuthenticate) async {
// //     image2.bitmap = base64Encode(imageToAuthenticate);
// //     image2.imageType = regula.ImageType.PRINTED;

// //     setState(() {
// //       _canAuthenticate = true;
// //     });
// //   }

// // //call in _fetchUsersAndMatchFace
// //   double compareFaces(FaceFeatures face1, FaceFeatures face2) {
// //     double distEar1 = euclideanDistance(face1.rightEar!, face1.leftEar!);
// //     double distEar2 = euclideanDistance(face2.rightEar!, face2.leftEar!);

// //     double ratioEar = distEar1 / distEar2;

// //     double distEye1 = euclideanDistance(face1.rightEye!, face1.leftEye!);
// //     double distEye2 = euclideanDistance(face2.rightEye!, face2.leftEye!);

// //     double ratioEye = distEye1 / distEye2;

// //     double distCheek1 = euclideanDistance(face1.rightCheek!, face1.leftCheek!);
// //     double distCheek2 = euclideanDistance(face2.rightCheek!, face2.leftCheek!);

// //     double ratioCheek = distCheek1 / distCheek2;

// //     double distMouth1 = euclideanDistance(face1.rightMouth!, face1.leftMouth!);
// //     double distMouth2 = euclideanDistance(face2.rightMouth!, face2.leftMouth!);

// //     double ratioMouth = distMouth1 / distMouth2;

// //     double distNoseToMouth1 =
// //         euclideanDistance(face1.noseBase!, face1.bottomMouth!);
// //     double distNoseToMouth2 =
// //         euclideanDistance(face2.noseBase!, face2.bottomMouth!);

// //     double ratioNoseToMouth = distNoseToMouth1 / distNoseToMouth2;

// //     double ratio =
// //         (ratioEye + ratioEar + ratioCheek + ratioMouth + ratioNoseToMouth) / 5;
// //     log(ratio.toString(), name: "Ratio");

// //     return ratio;
// //   }

// // //call in compareFaces
// // // A function to calculate the Euclidean distance between two points
// //   double euclideanDistance(Points p1, Points p2) {
// //     final sqr =
// //         math.sqrt(math.pow((p1.x! - p2.x!), 2) + math.pow((p1.y! - p2.y!), 2));
// //     return sqr;
// //   }

// // //dirct
// //   _fetchUsersAndMatchFace() {
// //     if (controller.userInformation.isNotEmpty) {
// //       users.clear();

// //       for (var i = 0; i < controller.userInformation.length; i++) {
// //         UserModel user = UserModel.fromJson({
// //           "id": controller.userInformation['emp_id'],
// //           "image": controller.userInformation['image'],
// //           "faceFeatures": controller.userfeatures[0]
// //         });
// //         double similarity = compareFaces(_faceFeatures!, user.faceFeatures!);
// //         if (similarity >= 0.8 && similarity <= 1.5) {
// //           users.add([user, similarity]);
// //         }
// //       }
// //       log(users.length.toString(), name: "Filtered Users");
// //       setState(() {
// //         //Sorts the users based on the similarity.
// //         //More similar face is put first.
// //         users.sort((a, b) => (((a.last as double) - 1).abs())
// //             .compareTo(((b.last as double) - 1).abs()));
// //       });

// //       _matchFaces();
// //     } else {
// //       _showFailureDialog(
// //         title: "No Users Registered",
// //         description:
// //             "Make sure users are registered first before Authenticating.",
// //       );
// //     }
// //   }

// // //call in _fetchUsersAndMatchFace and _fetchUserByName
// //   _matchFaces() async {
// //     bool faceMatched = false;
// //     for (List user in users) {
// //       image1.bitmap = (user.first as UserModel).image;
// //       image1.imageType = regula.ImageType.PRINTED;

// //       //Face comparing logic.
// //       var request = regula.MatchFacesRequest();
// //       request.images = [image1, image2];
// //       dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));

// //       var response = regula.MatchFacesResponse.fromJson(json.decode(value));
// //       dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
// //           jsonEncode(response!.results), 0.75);

// //       var split =
// //           regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
// //       setState(() {
// //         _similarity = split!.matchedFaces.isNotEmpty
// //             ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)
// //             : "error";
// //         log("similarity: $_similarity");

// //         if (_similarity != "error" && double.parse(_similarity) > 90.00) {
// //           faceMatched = true;
// //           loggingUser = user.first;
// //         } else {
// //           faceMatched = false;
// //         }
// //       });
// //       if (faceMatched) {
// //         setState(() {
// //           trialNumber = 1;
// //           isMatching = false;
// //         });

// //         if (mounted) {
// //           Get.off(() => HomePage(
// //                 technicalId: controller.userInformation["technical_id"],
// //               ));
// //         }
// //         break;
// //       }
// //     }
// //     if (!faceMatched) {
// //       if (trialNumber == 4) {
// //         setState(() => trialNumber = 1);
// //         _showFailureDialog(
// //           title: "Redeem Failed",
// //           description: "Face doesn't match. Please try again.",
// //         );
// //       } else if (trialNumber == 3) {
// //         //After 2 trials if the face doesn't match automatically, the registered name prompt
// //         //will be shown. After entering the name the face registered with the entered name will
// //         //be fetched and will try to match it with the to be authenticated face.
// //         //If the faces match, Viola!. Else it means the user is not registered yet.

// //         setState(() {
// //           isMatching = false;
// //           trialNumber++;
// //         });
// //         showDialog(
// //             context: context,
// //             builder: (context) {
// //               return AlertDialog(
// //                 title: const Text("Enter Name"),
// //                 content: TextFormField(
// //                   controller: _nameController,
// //                   cursorColor: accentColor,
// //                   decoration: InputDecoration(
// //                     enabledBorder: OutlineInputBorder(
// //                       borderSide: const BorderSide(
// //                         width: 2,
// //                         color: accentColor,
// //                       ),
// //                       borderRadius: BorderRadius.circular(4),
// //                     ),
// //                     focusedBorder: OutlineInputBorder(
// //                       borderSide: const BorderSide(
// //                         width: 2,
// //                         color: accentColor,
// //                       ),
// //                       borderRadius: BorderRadius.circular(4),
// //                     ),
// //                   ),
// //                 ),
// //                 actions: [
// //                   TextButton(
// //                     onPressed: () {
// //                       if (_nameController.text.trim().isEmpty) {
// //                         CustomSnackBar.errorSnackBar("Enter a name to proceed");
// //                       } else {
// //                         Navigator.of(context).pop();
// //                         setState(() => isMatching = true);

// //                         _fetchUserByName(_nameController.text.trim());
// //                       }
// //                     },
// //                     child: const Text(
// //                       "Done",
// //                       style: TextStyle(
// //                         color: accentColor,
// //                       ),
// //                     ),
// //                   )
// //                 ],
// //               );
// //             });
// //       } else {
// //         setState(() => trialNumber++);
// //         _showFailureDialog(
// //           title: "Redeem Failed",
// //           description: "Face doesn't match. Please try again.",
// //         );
// //       }
// //     }
// //   }

// // //call in _matchFaces
// //   _fetchUserByName(String orgID) {
// //     // FirebaseFirestore.instance
// //     //     .collection("users")
// //     //     .where("organizationId", isEqualTo: orgID)
// //     //     .get()
// //     //     .catchError((e) {
// //     //   log("Getting User Error: $e");
// //     //   setState(() => isMatching = false);
// //     //   _playFailedAudio;
// //     //   CustomSnackBar.errorSnackBar("Something went wrong. Please try again.");
// //     // }).then((snap) {
// //     //   if (snap.docs.isNotEmpty) {
// //     //     users.clear();

// //     //     for (var doc in snap.docs) {
// //     //       setState(() {
// //     //         users.add([UserModel.fromJson(doc.data()), 1]);
// //     //       });
// //     //     }
// //     //     _matchFaces();
// //     //   } else {
// //     //     setState(() => trialNumber = 1);
// //     //     _showFailureDialog(
// //     //       title: "User Not Found",
// //     //       description:
// //     //           "User is not registered yet. Register first to authenticate.",
// //     //     );
// //     //   }
// //     // });
// //   }

// // //call in _fetchUsersAndMatchFace ,_matchFaces and _fetchUserByName
// //   _showFailureDialog({
// //     required String title,
// //     required String description,
// //   }) {
// //     setState(() => isMatching = false);
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text(title),
// //           content: Text(description),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Get.offAll(() => LoginPage());
// //               },
// //               child: const Text(
// //                 "Ok",
// //                 style: TextStyle(
// //                   color: accentColor,
// //                 ),
// //               ),
// //             )
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }

// //=============================
// //==========================================================================================================
// //=============================

// class AuthenticateFaceView extends StatefulWidget {
//   const AuthenticateFaceView({Key? key}) : super(key: key);

//   @override
//   State<AuthenticateFaceView> createState() => _AuthenticateFaceViewState();
// }

// class _AuthenticateFaceViewState extends State<AuthenticateFaceView> {
//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableLandmarks: true,
//       performanceMode: FaceDetectorMode.accurate,
//     ),
//   );
//   final LoginController controller = Get.find<LoginController>();
//   FaceFeatures? _faceFeatures;
//   var image1 = regula.MatchFacesImage();
//   var image2 = regula.MatchFacesImage();

//   final TextEditingController _nameController = TextEditingController();
//   String _similarity = "";
//   bool _canAuthenticate = false;
//   List<dynamic> users = [];
//   bool userExists = false;
//   UserModel? loggingUser;
//   bool isMatching = false;
//   int trialNumber = 1;

//   @override
//   void dispose() {
//     _faceDetector.close();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(0xFF1860a3),
//         title: const Text("Authenticate Face"),
//         elevation: 0,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constrains) => Stack(
//           children: [
//             Container(
//               width: constrains.maxWidth,
//               height: constrains.maxHeight,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFF1860a3), Color(0xFF1860a3)],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       height: 300,
//                       width: double.infinity,
//                       // padding:
//                       //     EdgeInsets.fromLTRB(0.05.sw, 0.025.sh, 0.05.sw, 0),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 224, 222, 222),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30),
//                           topRight: Radius.circular(30),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Stack(
//                             children: [
//                               CameraView(
//                                 onImage: (image) {
//                                   _setImage(image);
//                                 },
//                                 onInputImage: (inputImage) async {
//                                   setState(() => isMatching = true);
//                                   _faceFeatures = await extractFaceFeatures(
//                                       inputImage, _faceDetector);
//                                   setState(() => isMatching = false);
//                                 },
//                               ),
//                               if (isMatching) CircularProgressIndicator()
//                             ],
//                           ),

//                           const Spacer(),
//                           if (_canAuthenticate)
//                             CustomButton(
//                               text: "Authenticate",
//                               onTap: () {
//                                 setState(() => isMatching = true);
//                                 _fetchUsersAndMatchFace();
//                               },
//                             ),
//                           // SizedBox(height: 0.038.sh),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// //dirct
//   Future _setImage(Uint8List imageToAuthenticate) async {
//     image2.bitmap = base64Encode(imageToAuthenticate);
//     image2.imageType = regula.ImageType.PRINTED;

//     setState(() {
//       _canAuthenticate = true;
//     });
//   }

// //call in _fetchUsersAndMatchFace
//   double compareFaces(FaceFeatures face1, FaceFeatures face2) {
//     double distEar1 = euclideanDistance(face1.rightEar!, face1.leftEar!);
//     double distEar2 = euclideanDistance(face2.rightEar!, face2.leftEar!);

//     double ratioEar = distEar1 / distEar2;

//     double distEye1 = euclideanDistance(face1.rightEye!, face1.leftEye!);
//     double distEye2 = euclideanDistance(face2.rightEye!, face2.leftEye!);

//     double ratioEye = distEye1 / distEye2;

//     double distCheek1 = euclideanDistance(face1.rightCheek!, face1.leftCheek!);
//     double distCheek2 = euclideanDistance(face2.rightCheek!, face2.leftCheek!);

//     double ratioCheek = distCheek1 / distCheek2;

//     double distMouth1 = euclideanDistance(face1.rightMouth!, face1.leftMouth!);
//     double distMouth2 = euclideanDistance(face2.rightMouth!, face2.leftMouth!);

//     double ratioMouth = distMouth1 / distMouth2;

//     double distNoseToMouth1 =
//         euclideanDistance(face1.noseBase!, face1.bottomMouth!);
//     double distNoseToMouth2 =
//         euclideanDistance(face2.noseBase!, face2.bottomMouth!);

//     double ratioNoseToMouth = distNoseToMouth1 / distNoseToMouth2;

//     double ratio =
//         (ratioEye + ratioEar + ratioCheek + ratioMouth + ratioNoseToMouth) / 5;
//     log(ratio.toString(), name: "Ratio");

//     return ratio;
//   }

// //call in compareFaces
// // A function to calculate the Euclidean distance between two points
//   double euclideanDistance(Points p1, Points p2) {
//     final sqr =
//         math.sqrt(math.pow((p1.x! - p2.x!), 2) + math.pow((p1.y! - p2.y!), 2));
//     return sqr;
//   }

// //dirct
//   _fetchUsersAndMatchFace() {
//     if (controller.userInformation.isNotEmpty) {
//       users.clear();

//       UserModel user = UserModel.fromJson({
//         "id": controller.userInformation['emp_id'],
//         "image": controller.userInformation['image'],
//         "faceFeatures": controller.userfeatures[0]
//       });
//       double similarity = compareFaces(_faceFeatures!, user.faceFeatures!);
//       if (similarity >= 0.8 && similarity <= 1.5) {
//         users.add([user, similarity]);
//       }

//       log(users.length.toString(), name: "Filtered Users");
//       setState(() {
//         //Sorts the users based on the similarity.
//         //More similar face is put first.
//         users.sort((a, b) => (((a.last as double) - 1).abs())
//             .compareTo(((b.last as double) - 1).abs()));
//       });

//       _matchFaces();
//       log(trialNumber.toString(), name: " Users");
//     } else {
//       _showFailureDialog(
//         title: "No Users Registered",
//         description:
//             "Make sure users are registered first before Authenticating.",
//       );
//     }
//   }

// //call in _fetchUsersAndMatchFace and _fetchUserByName
//   _matchFaces() async {
//     bool faceMatched = false;
//     for (List user in users) {
//       image1.bitmap = (user.first as UserModel).image;
//       image1.imageType = regula.ImageType.PRINTED;

//       //Face comparing logic.
//       var request = regula.MatchFacesRequest();
//       request.images = [image1, image2];
//       dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));

//       var response = regula.MatchFacesResponse.fromJson(json.decode(value));
//       dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
//           jsonEncode(response!.results), 0.75);

//       var split =
//           regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
//       setState(() {
//         _similarity = split!.matchedFaces.isNotEmpty
//             ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)
//             : "error";
//         log("similarity: $_similarity");

//         if (_similarity != "error" && double.parse(_similarity) > 90.00) {
//           faceMatched = true;
//           loggingUser = user.first;
//         } else {
//           faceMatched = false;
//         }
//       });
//       if (faceMatched) {
//         setState(() {
//           trialNumber = 1;
//           isMatching = false;
//         });

//         if (mounted) {
//           Get.off(() => HomePage(
//                 technicalId: controller.userInformation["technical_id"],
//               ));
//         }
//         break;
//       }
//     }
//     if (!faceMatched) {
//       if (trialNumber == 4) {
//         setState(() => trialNumber = 1);
//         _showFailureDialog(
//           title: "Redeem Failed",
//           description: "Face doesn't match. Please try again.",
//         );
//       } else if (trialNumber == 3) {
//         //After 2 trials if the face doesn't match automatically, the registered name prompt
//         //will be shown. After entering the name the face registered with the entered name will
//         //be fetched and will try to match it with the to be authenticated face.
//         //If the faces match, Viola!. Else it means the user is not registered yet.

//         setState(() {
//           isMatching = false;
//           trialNumber++;
//         });
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text("Enter Name"),
//                 content: TextFormField(
//                   controller: _nameController,
//                   cursorColor: accentColor,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: accentColor,
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: accentColor,
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       if (_nameController.text.trim().isEmpty) {
//                         CustomSnackBar.errorSnackBar("Enter a name to proceed");
//                       } else {
//                         Navigator.of(context).pop();
//                         setState(() => isMatching = true);

//                         _fetchUserByName(_nameController.text.trim());
//                       }
//                     },
//                     child: const Text(
//                       "Done",
//                       style: TextStyle(
//                         color: accentColor,
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             });
//       } else {
//         setState(() => trialNumber++);
//         _showFailureDialog(
//           title: "Redeem Failed",
//           description: "Face doesn't match. Please try again.",
//         );
//       }
//     }
//   }

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

// //call in _fetchUsersAndMatchFace ,_matchFaces and _fetchUserByName
//   _showFailureDialog({
//     required String title,
//     required String description,
//   }) {
//     setState(() => isMatching = false);
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(description),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.offAll(() => LoginPage());
//               },
//               child: const Text(
//                 "Ok",
//                 style: TextStyle(
//                   color: accentColor,
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
// import 'package:car_maintenance_technicians/controllers/home_controller.dart';
// import 'package:car_maintenance_technicians/model/carditals.dart';
// import 'package:car_maintenance_technicians/string/constans.dart';
// import 'package:car_maintenance_technicians/view/login/dblogin/side_input_dblogin.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   List list = [];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SizedBox(
//         width: double.infinity,
//         child: DataTable(
//           // columnSpacing: defaultPadding,
//           // minWidth: 600,
//           columns: [
//             DataColumn(
//               label: Text(
//                 "service".tr,
//                 style: const TextStyle(color: textColor, fontSize: 14),
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 "type".tr,
//                 style: const TextStyle(color: textColor, fontSize: 14),
//               ),
//             ),
//             // DataColumn(
//             //   label: Text("price".tr,
//             //       style: Theme.of(context)
//             //           .textTheme
//             //           .headlineSmall!),
//             // ),
//             DataColumn(
//               label: Center(
//                 child: Text(
//                   "state".tr,
//                   style: const TextStyle(color: textColor, fontSize: 14),
//                 ),
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 " ",
//                 style: const TextStyle(color: textColor, fontSize: 14),
//               ),
//             ),
//           ],
//           rows: List.generate(list.length, (index) {
//             return recentFileDataRow(list[index], context, index);
//           }),
//         ),
//       ),
//     );
//   }

//   DataRow recentFileDataRow(
//       CarDetail carDetail, BuildContext context, int index) {
//     return DataRow(
//       cells: [
//         DataCell(Text(
//           carDetail.en_name.toString() + "-" + carDetail.name!.toString(),
//           style: const TextStyle(color: textColor, fontSize: 12),
//         )),
//         DataCell(Text(
//           carDetail.productId!.toString(),
//           style: const TextStyle(color: textColor, fontSize: 12),
//         )),
//         // DataCell(
//         //   Text(carDetail.unitPrice.toString(),
//         //       style: Theme.of(context).textTheme.bodyLarge!),
//         // ),
//         DataCell(Text(
//           carDetail.state == 'NEW' ? "new".tr : "processing".tr,
//           //== false ? 'New' : carDetail.state.toString(),
//           style: const TextStyle(color: textColor, fontSize: 12),
//         )),
//         DataCell(
//           GetBuilder<HomeController>(
//               id: 'flage',
//               builder: (_) =>
//                   //  controller.flags[index] == true
//                   //     ? const CircularProgressIndicator()
//                   //     :
//                   ElevatedButton(
//                     style: TextButton.styleFrom(
//                       side: const BorderSide(width: 2, color: textColor),
//                       backgroundColor: secondaryColor,
//                       // padding: EdgeInsets.symmetric(
//                       //   horizontal: 20,
//                       //   vertical: defaultPadding /
//                       //       (Responsive.isMobile(context) ? 2 : 1),
//                       // ),
//                     ),
//                     child: Text(
//                       carDetail.state == 'NEW' ? "start".tr : "complet".tr,
//                       style: TextStyle(color: primaryWhite),
//                     ),
//                     onPressed: () async {
//                       //  controller.changeFlage(index);
//                       // controller.getIndex(index);

//                       if (carDetail.state == "NEW") {
//                         CarDetail car = CarDetail(
//                             productId: carDetail.productId,
//                             name: carDetail.name,
//                             id: carDetail.id,
//                             headerId: carDetail.headerId,
//                             technicalisDone: widget.technicalId.toString(),
//                             state: 'started',
//                             unitPrice: carDetail.unitPrice,
//                             completeDate: DateTime.now().toString());
//                         controller.sendDataDetails(dataUpdae: [car]);
//                         //  await Dbcarsdetails.updatecarsdetailtostartdb(
//                         //         car.id!);

//                         controller.updateDataDetails(car).then((value) {
//                           controller.sendLoading.value = false;
//                           loginController.authenticateLoading.value = false;
//                           Get.off(() => LoginPage());
//                         });
//                       } else if (carDetail.state == 'started') {
//                         CarDetail car = CarDetail(
//                             productId: carDetail.productId,
//                             name: carDetail.name,
//                             id: carDetail.id,
//                             headerId: carDetail.headerId,
//                             technicalisDone: widget.technicalId.toString(),
//                             state: 'complete',
//                             unitPrice: carDetail.unitPrice,
//                             completeDate: DateTime.now().toString());
//                         controller.sendDataDetails(
//                           dataUpdae: [car],
//                           // caredId: widget.caredId,
//                           // technicalId: widget.technicalId
//                         ).then((value) {
//                           if (controller.errorissame != true) {
//                             print("===================ds==========");
//                             controller.updateDataDetails(car).then((value) {
//                               controller.sendLoading.value = false;
//                               loginController.authenticateLoading.value = false;
//                               Get.off(() => LoginPage());
//                             });
//                           } else {
//                             Get.snackbar('error',
//                                 "You can't complete the task you started",
//                                 titleText: Text(
//                                   'error',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleMedium!
//                                       .copyWith(color: primaryBlack),
//                                 ),
//                                 messageText: Text(
//                                   "You can't complete the task you started",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleMedium!
//                                       .copyWith(color: primaryBlack),
//                                 ),
//                                 duration: const Duration(seconds: 5),
//                                 snackPosition: SnackPosition.BOTTOM,
//                                 backgroundColor: primaryWhite);
//                           }
//                         });
//                         // await Dbcarsdetails.updatecarsdetailtocompletetdb(
//                         //    car.id!);

//                         controller.errorissame = false;
//                       }
//                     },
//                   )),
//           // Obx(() =>
//           // controller.flags[index] == true
//           //     ? const CircularProgressIndicator()
//           //     :

//           //       ),
//         ),
//       ],
//     );
//   }
// }

// // import 'package:car_maintenance_technicians/controllers/home_controller.dart';
// // import 'package:car_maintenance_technicians/model/carditals.dart';
// // import 'package:car_maintenance_technicians/responsive.dart';
// // import 'package:car_maintenance_technicians/string/constans.dart';
// // import 'package:car_maintenance_technicians/view/home/home_page.dart';
// // import 'package:car_maintenance_technicians/view/home/row_method.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:get/get.dart';

// // class MyWidget extends StatelessWidget {
// //   final int caredId;
// //   final int technicalId;
// //   final String caredName;
// //   MyWidget(
// //       {super.key,
// //       required this.caredId,
// //       required this.technicalId,
// //       required this.caredName});

// //   final HomeController controller = Get.put(HomeController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //           // appBar: AppBar(
// //           //   title: Center(child: Text(caredName.toString())),
// //           //   backgroundColor: bgColor,
// //           //   elevation: 0,
// //           // ),
// //           // backgroundColor: textColor,
// //           body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.end,
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: IconButton(
// //                   onPressed: () {
// //                     Get.off(() => HomePage(technicalId: technicalId));
// //                   },
// //                   icon: const Icon(
// //                     Icons.arrow_forward,
// //                     color: textColor,
// //                     size: 35,
// //                   )),
// //             ),
// //             FutureBuilder(
// //               future: controller.getcar(headerId: caredId),
// //               builder: (BuildContext context, AsyncSnapshot car) {
// //                 if (car.connectionState == ConnectionState.waiting) {
// //                   return Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Center(
// //                         child: SvgPicture.asset(
// //                           "assets/images/Ellipsis-1s-200px.svg",
// //                         ),
// //                       ),
// //                     ],
// //                   );
// //                 } else if (car.hasError) {
// //                   return Text('Error: ${car.error}');
// //                 } else {
// //                   return Card(
// //                     color: bgColor.withOpacity(0.3),
// //                     margin: const EdgeInsets.all(defaultPadding * 2),
// //                     child: Column(
// //                       // crossAxisAlignment: CrossAxisAlignment.end,
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Padding(
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: defaultPadding,
// //                             vertical: defaultPadding * 2,
// //                           ),
// //                           child: Text(
// //                             "Car Details",
// //                             // "تفاصيل السيارة",
// //                             style: Theme.of(context)
// //                                 .textTheme
// //                                 .headlineMedium!
// //                                 .copyWith(color: textColor),
// //                           ),
// //                         ),
// //                         Row(
// //                           children: [
// //                             Expanded(
// //                               child: Table(
// //                                 // border: TableBorder.all(),
// //                                 defaultVerticalAlignment: TableCellVerticalAlignment
// //                                     .top, // Set the vertical alignment of cells
// //                                 columnWidths: const {
// //                                   1: FlexColumnWidth(
// //                                       1), // Set the width of the first column
// //                                   0: FlexColumnWidth(
// //                                       0.5), // Set the width of the second column
// //                                 },
// //                                 children: [
// //                                   rowMethod(
// //                                       context,
// //                                       'Partner',
// //                                       // "اسم العميل",
// //                                       car.data[0]["partner_id"] == false
// //                                           ? car.data[0]["partner_id"]
// //                                           : car.data[0]["partner_id"][1]),
// //                                   rowMethod(
// //                                       context,
// //                                       "Partner Mobile",
// //                                       // "رقم الجوال",
// //                                       car.data[0]["partner_mobile"].toString()),
// //                                   rowMethod(
// //                                       context,
// //                                       "Car Type",
// //                                       // "نوع السيارة",
// //                                       car.data[0]["car_type_id"] == false
// //                                           ? car.data[0]["car_type_id"]
// //                                           : car.data[0]["car_type_id"][1]
// //                                               .toString()),
// //                                   rowMethod(
// //                                       context,
// //                                       "Car Panel No",
// //                                       // "رقم السيارة",
// //                                       car.data[0]["car_panel_no"].toString()),
// //                                   rowMethod(
// //                                       context,
// //                                       "Branch",
// //                                       // "الفرع",
// //                                       car.data[0]["branch_id"] == false
// //                                           ? car.data[0]["branch_id"]
// //                                           : car.data[0]["branch_id"][1]
// //                                               .toString()),
// //                                 ],
// //                               ),
// //                             ),
// //                             Image.asset(
// //                               "assets/images/car.png",
// //                               height: MediaQuery.of(context).size.height / 4,
// //                               width: MediaQuery.of(context).size.width / 4,
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ); // Show the fetched data
// //                 }
// //               },
// //             ),
// //             FutureBuilder(
// //               future: controller.getcarsdetails(
// //                   caredId: caredId, technicalId: technicalId),
// //               builder: (BuildContext context, AsyncSnapshot snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [Container()],
// //                   );
// //                 } else if (snapshot.hasError) {
// //                   return Text(
// //                     'Error: ${snapshot.error}',
// //                     style: Theme.of(context)
// //                         .textTheme
// //                         .bodyLarge!
// //                         .copyWith(color: primaryColor),
// //                   );
// //                 } else {
// //                   return Column(
// //                     children: [
// //                       GetBuilder<HomeController>(
// //                           builder: (_) => controller.carsdetails.isEmpty
// //                               ? Container()
// //                               : Container(
// //                                   margin:
// //                                       const EdgeInsets.all(defaultPadding * 2),
// //                                   padding: const EdgeInsets.all(defaultPadding),
// //                                   decoration: BoxDecoration(
// //                                     color: bgColor.withOpacity(0.3),
// //                                     borderRadius: const BorderRadius.all(
// //                                         Radius.circular(10)),
// //                                   ),
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     // crossAxisAlignment: CrossAxisAlignment.end,
// //                                     children: [
// //                                       Padding(
// //                                         padding: const EdgeInsets.all(10.0),
// //                                         child: Text(
// //                                           "Tasks",
// //                                           // "المهام",
// //                                           style: Theme.of(context)
// //                                               .textTheme
// //                                               .headlineMedium!
// //                                               .copyWith(color: textColor),
// //                                         ),
// //                                       ),
// //                                       SizedBox(
// //                                         width: double.infinity,
// //                                         child: DataTable(
// //                                           columnSpacing: defaultPadding,
// //                                           // dataRowMaxHeight: 100.0,
// //                                           columns: [
// //                                             DataColumn(
// //                                               label: Expanded(
// //                                                 child: Center(
// //                                                   child: Text("name",
// //                                                       // "الخدمة",
// //                                                       textAlign:
// //                                                           TextAlign.center,
// //                                                       style: Theme.of(context)
// //                                                           .textTheme
// //                                                           .headlineSmall!
// //                                                           .copyWith(
// //                                                               color:
// //                                                                   textColor)),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             DataColumn(
// //                                               label: Expanded(
// //                                                 child: Center(
// //                                                   child: Text("product",
// //                                                       // "نوعها",
// //                                                       textAlign:
// //                                                           TextAlign.center,
// //                                                       style: Theme.of(context)
// //                                                           .textTheme
// //                                                           .headlineSmall!
// //                                                           .copyWith(
// //                                                               color:
// //                                                                   textColor)),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             DataColumn(
// //                                               label: Expanded(
// //                                                 child: Center(
// //                                                   child: Text("unitPrice",
// //                                                       // "السعر",
// //                                                       textAlign:
// //                                                           TextAlign.center,
// //                                                       style: Theme.of(context)
// //                                                           .textTheme
// //                                                           .headlineSmall!
// //                                                           .copyWith(
// //                                                               color:
// //                                                                   textColor)),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             DataColumn(
// //                                               label: Expanded(
// //                                                 child: Center(
// //                                                   child: Text("State",
// //                                                       // "الحالة",
// //                                                       textAlign:
// //                                                           TextAlign.center,
// //                                                       style: Theme.of(context)
// //                                                           .textTheme
// //                                                           .headlineSmall!
// //                                                           .copyWith(
// //                                                               color:
// //                                                                   textColor)),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             DataColumn(
// //                                               label: Text(" ",
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .headlineSmall!),
// //                                             ),
// //                                           ],
// //                                           rows: List.generate(
// //                                             controller.carsdetails.length,
// //                                             (index) => recentFileDataRow(
// //                                                 controller.carsdetails[index],
// //                                                 context),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       const SizedBox(
// //                                         height: defaultPadding * 2,
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 )),
// //                       GetBuilder<HomeController>(
// //                         builder: (_) => controller.carsdetails.isEmpty
// //                             ? Container()
// //                             : Row(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   ElevatedButton(
// //                                     style: TextButton.styleFrom(
// //                                       backgroundColor: bgColor,
// //                                       padding: EdgeInsets.symmetric(
// //                                         horizontal: defaultPadding *
// //                                             (Responsive.isMobile(context)
// //                                                 ? 2
// //                                                 : 6),
// //                                         vertical: defaultPadding *
// //                                             (Responsive.isMobile(context)
// //                                                 ? 2
// //                                                 : 2),
// //                                       ),
// //                                     ),
// //                                     child: Text(
// //                                       " Done",
// //                                       style:
// //                                           Theme.of(context).textTheme.bodyLarge,
// //                                     ),
// //                                     onPressed: () {
// //                                       if (controller.saveCarsDetails.isEmpty) {
// //                                         Get.snackbar(
// //                                             'رسالة خطأ', "لا يوجد مهام مكتملة",
// //                                             titleText: Align(
// //                                               alignment: Alignment.topRight,
// //                                               child: Padding(
// //                                                 padding:
// //                                                     const EdgeInsets.all(8.0),
// //                                                 child: Text(
// //                                                   'رسالة خطأ',
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .titleMedium,
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             messageText: Align(
// //                                               alignment: Alignment.topRight,
// //                                               child: Padding(
// //                                                 padding:
// //                                                     const EdgeInsets.all(8.0),
// //                                                 child: Text(
// //                                                   "لا يوجد مهام مكتملة",
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .titleSmall,
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             duration:
// //                                                 const Duration(seconds: 5),
// //                                             snackPosition: SnackPosition.BOTTOM,
// //                                             backgroundColor: primaryColor);
// //                                       } else {
// //                                         controller.sendDataDetails(
// //                                             dataUpdae:
// //                                                 controller.saveCarsDetails);
// //                                       }
// //                                     },
// //                                   ),
// //                                 ],
// //                               ),
// //                       ),
// //                       const SizedBox(
// //                         height: defaultPadding * 2,
// //                       )
// //                     ],
// //                   );
// //                 }
// //               },
// //             ),
// //           ],
// //         ),
// //       )),
// //     );
// //   }

// //   DataRow recentFileDataRow(CarDetail carDetail, BuildContext context) {
// //     return DataRow(
// //       cells: [
// //         DataCell(Expanded(
// //           child: Center(
// //             child: Text(carDetail.name!,
// //                 textAlign: TextAlign.justify,
// //                 overflow: TextOverflow.visible,
// //                 style: Theme.of(context)
// //                     .textTheme
// //                     .bodySmall!
// //                     .copyWith(color: textColor, fontWeight: FontWeight.bold)),
// //           ),
// //         )),
// //         DataCell(Expanded(
// //           child: Center(
// //             child: Text(carDetail.productId!,
// //                 textAlign: TextAlign.justify,
// //                 overflow: TextOverflow.visible,
// //                 style: Theme.of(context)
// //                     .textTheme
// //                     .bodySmall!
// //                     .copyWith(color: textColor, fontWeight: FontWeight.bold)),
// //           ),
// //         )),
// //         DataCell(
// //           Expanded(
// //             child: Center(
// //               child: Text(carDetail.unitPrice.toString(),
// //                   textAlign: TextAlign.justify,
// //                   overflow: TextOverflow.visible,
// //                   style: Theme.of(context)
// //                       .textTheme
// //                       .bodySmall!
// //                       .copyWith(color: textColor, fontWeight: FontWeight.bold)),
// //             ),
// //           ),
// //         ),
// //         DataCell(Expanded(
// //           child: Center(
// //             child: Text(carDetail.state,
// //                 textAlign: TextAlign.center,
// //                 style: Theme.of(context)
// //                     .textTheme
// //                     .bodySmall!
// //                     .copyWith(color: textColor, fontWeight: FontWeight.bold)),
// //           ),
// //         )),
// //         DataCell(Expanded(
// //           child: Center(
// //             child: ElevatedButton(
// //               style: TextButton.styleFrom(
// //                 side: const BorderSide(width: 2, color: textColor),
// //                 backgroundColor: secondaryColor,
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: defaultPadding * 3,
// //                   vertical:
// //                       defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
// //                 ),
// //               ),
// //               child: Text(
// //                 carDetail.technicalisDone == "false"
// //                     ? "مكتمل/completed"
// //                     : " غير مكتمل/uncompleted",
// //                 textAlign: TextAlign.center,
// //                 style: Theme.of(context)
// //                     .textTheme
// //                     .bodySmall!
// //                     .copyWith(color: textColor),
// //               ),
// //               onPressed: () async {
// //                 CarDetail car = CarDetail(
// //                     productId: carDetail.productId,
// //                     name: carDetail.name,
// //                     id: carDetail.id,
// //                     headerId: carDetail.headerId,
// //                     technicalisDone: technicalId.toString(),
// //                     state: 'complete',
// //                     unitPrice: carDetail.unitPrice,
// //                     completeDate: DateTime.now().toString());
// //                 controller.addDataInList(carDetail: car);
// //               },
// //             ),
// //           ),
// //         )),
// //       ],
// //     );
// //   }
// // }

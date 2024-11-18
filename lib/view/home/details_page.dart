
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/login_controller.dart';
import '../../main.dart';
import '../../model/car.dart';
import '../../model/carditals.dart';
import '../../responsive.dart';
import '../../string/constans.dart';
import '../login/login/login_page.dart';
import 'home_page.dart';

class CardDetail extends StatefulWidget {
  final int caredId;
  final int technicalId;
  final String caredName;
  final Car carinfo;
  const CardDetail(
      {super.key,
      required this.caredId,
      required this.technicalId,
      required this.caredName,
      required this.carinfo});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  final HomeController controller = Get.put(HomeController());
  final LoginController loginController = Get.put(LoginController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = widthofpage(context);
    // double height = heightofpage(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor.withOpacity(0.1),
          leadingWidth: 0,
          leading: Container(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await controller.updatecars();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('homepage', true);
                        Get.off(
                            () => HomePage(technicalId: widget.technicalId));
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: textColor,
                        size: 20,
                      )),
                  Text(
                    loginController.pin,
                    style: const TextStyle(color: primaryWhite),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('login', true);
                      if (sharepref!.getBool('dbpage') == true) {
                        sharepref!.setBool('dbpage', false);
                      }
                      sharepref!.setBool('homepage', false);
                      Get.offAll(() => LoginPage());
                    },
                    child: Row(
                      children: [
                        Container(
                          child: const Icon(
                            Icons.login_outlined,
                            color: primaryWhite,
                            size: 17,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Text("logoff".tr,
                              style: const TextStyle(
                                  color: primaryWhite, fontSize: 12)),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      LoginController logincontroller =
                          Get.put(LoginController());

                      await controller.getcarsdetails(
                          caredId: widget.carinfo.carId,
                          technicalId:
                              logincontroller.userInformation["technical_id"]);

                      controller.update(["sendDataDetails"]);

                      // Get.off(CardDetail(
                      //   caredId: widget.carinfo.carId,
                      //   technicalId:
                      //       logincontroller.userInformation["technical_id"],
                      //   caredName: widget.carinfo.carTypeId,
                      //   carinfo: widget.carinfo,
                      // ));
                    },
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {},
                            icon: const Icon(
                              Icons.update,
                              color: textColor,
                              size: 20,
                            )),
                        Container(
                          child: Text("update".tr,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.4),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
              //   child: IconButton(
              //       onPressed: () {
              //         Get.off(() => HomePage(technicalId: widget.technicalId));
              //       },
              //       icon: const Icon(
              //         Icons.arrow_back,
              //         color: textColor,
              //         size: 35,
              //       )),
              // ),
              // FutureBuilder(
              //   future: controller.getcar(headerId: widget.caredId),
              //   builder: (BuildContext context, AsyncSnapshot car) {
              //     if (car.connectionState == ConnectionState.waiting) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Center(
              //             child: SvgPicture.asset(
              //               "assets/images/Ellipsis-1s-200px.svg",
              //             ),
              //           ),
              //         ],
              //       );
              //     } else if (car.hasError) {
              //       return Text('Error: ${car.error}');
              //     } else {
              //       return
              Responsive(
                lassmobile: lessMobile(context, widget.carinfo),
                desktop: carDetails(
                    context: context,
                    car: widget.carinfo,
                    headerstyle: Theme.of(context).textTheme.headlineSmall!,
                    rowstyle: Theme.of(context).textTheme.bodyLarge!,
                    imageflex: 1,
                    dataTableflex: 5,
                    isMobile: false),
                mobile: carDetails(
                    context: context,
                    car: widget.carinfo,
                    headerstyle:
                        const TextStyle(color: textColor, fontSize: 14),
                    rowstyle: const TextStyle(color: textColor, fontSize: 12),
                    imageflex: 1,
                    dataTableflex: 1,
                    isMobile: true),
                tablet: carDetails(
                    context: context,
                    car: widget.carinfo,
                    headerstyle:
                        const TextStyle(color: textColor, fontSize: 16),
                    rowstyle: const TextStyle(color: textColor, fontSize: 14),
                    imageflex: 1,
                    dataTableflex: 5,
                    isMobile: false),
              ),

              // Show the fetched data

              GetBuilder<HomeController>(
                  id: 'sendDataDetails',
                  builder: (_) {
                    // if (controller.carsdetails.isEmpty) {
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     Get.offAll(SideHome(
                    //       technicalId: widget.technicalId,
                    //     ));
                    //   });
                    // }
                    // return FutureBuilder(
                    //   future: controller.getcarsdetails(
                    //       caredId: widget.caredId,
                    //       technicalId: widget
                    //           .technicalId), // Replace with your own future function
                    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [Container()],
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Text(
                    //         'Error: ${snapshot.error}',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyLarge!
                    //             .copyWith(color: primaryColor),
                    //       );
                    //     } else {
                    controller.flags = [];

                    return Column(
                      children: [
                        controller.carsdetails.isEmpty
                            ? Container()
                            : Container(
                                margin: const EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: bgColor.withOpacity(0.3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: DataTable(
                                        // columnSpacing: defaultPadding,
                                        // minWidth: 600,
                                        columns: [
                                          DataColumn(
                                            label: Text(
                                              "service".tr,
                                              style: const TextStyle(
                                                  color: textColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              "type".tr,
                                              style: const TextStyle(
                                                  color: textColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          // DataColumn(
                                          //   label: Text("price".tr,
                                          //       style: Theme.of(context)
                                          //           .textTheme
                                          //           .headlineSmall!),
                                          // ),
                                          DataColumn(
                                            label: Center(
                                              child: Text(
                                                "state".tr,
                                                style: const TextStyle(
                                                    color: textColor,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              " ",
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                        rows: List.generate(
                                            controller.carsdetails.length,
                                            (index) {
                                          controller.addToFlage(false);

                                          return recentFileDataRow(
                                              controller.carsdetails[index],
                                              context,
                                              index);
                                        }),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: defaultPadding * 2,
                                    ),
                                  ],
                                ),
                              ),
                        // GetBuilder<HomeController>(
                        //   builder: (_) => Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       ElevatedButton(
                        //         style: TextButton.styleFrom(
                        //           backgroundColor: bgColor,
                        //           padding: EdgeInsets.symmetric(
                        //             horizontal: defaultPadding * 4,
                        //             vertical: defaultPadding *
                        //                 (Responsive.isMobile(context) ? 2 : 1),
                        //           ),
                        //         ),
                        //         child: Text("Done".tr),
                        //         onPressed: () async {
                        //           Get.offAll(() => const LoginPage());
                        //           SharedPreferences prefs =
                        //               await SharedPreferences.getInstance();
                        //           prefs.setBool('login', true);
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Container lessMobile(BuildContext context, Car car) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            // border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment
                .top, // Set the vertical alignment of cells
            columnWidths: const {
              1: FlexColumnWidth(1), // Set the width of the first column
              0: FlexColumnWidth(0.5), // Set the width of the second column
            },
            children: [
              rowMethod(
                context,
                "custmer_name".tr,
                car.customer,
              ),
              rowMethod(
                  context,
                  "phone_number".tr,
                  car.partnerMobile == false
                      ? 'no number'
                      : car.partnerMobile.toString()),
              rowMethod(context, "typecar".tr, car.carTypeId.toString()),
              rowMethod(context, "Car_Panel".tr, car.carPanelNo.toString()),
              rowMethod(context, "branch".tr, car.branch.toString()),
            ],
          ),
        ],
      ),
    );
  }

  ConstrainedBox carDetails(
      {required BuildContext context,
      required Car car,
      TextStyle? headerstyle,
      TextStyle? rowstyle,
      required bool isMobile,
      required imageflex,
      required dataTableflex}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: dataTableflex,
                  child: DataTable(
                      columnSpacing: 10,

                      //           columnWidths: {
                      //   0: FixedColumnWidth(100), // Set width for the first column
                      // }

                      // border: TableBorder.all(),
                      columns: [
                        DataColumn(
                          numeric: true,
                          label: Container(
                              alignment: Alignment.center,
                              child:
                                  Text("custmer_name".tr, style: headerstyle)),
                        ),
                        DataColumn(
                          numeric: true,
                          label: Container(
                              alignment: Alignment.center,
                              child:
                                  Text("phone_number".tr, style: headerstyle)),
                        ),
                        DataColumn(
                          numeric: true,
                          label: Container(
                              alignment: Alignment.center,
                              child: Text("branch".tr, style: headerstyle)),
                        ),
                        DataColumn(
                          numeric: true,
                          label: Container(
                              alignment: Alignment.center,
                              child: Text("typecar".tr, style: headerstyle)),
                        ),
                        DataColumn(
                          numeric: true,
                          label: Container(
                              alignment: Alignment.center,
                              child: Text("Car_Panel".tr, style: headerstyle)),
                        ),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(car.customer, style: rowstyle)),
                          DataCell(Text(
                              car.partnerMobile == false
                                  ? 'no number'
                                  : car.partnerMobile.toString(),
                              style: rowstyle)),
                          DataCell(
                              Text(car.branch.toString(), style: rowstyle)),
                          DataCell(Text(car.carTypeId.toString(),
                              style: Theme.of(context).textTheme.bodyLarge!)),
                          DataCell(
                              Text(car.carPanelNo.toString(), style: rowstyle)),
                        ]),
                      ]),
                ),
                isMobile
                    ? Container()
                    : Expanded(
                        flex: imageflex,
                        child: Image.asset(
                          "assets/images/car.png",
                          fit: BoxFit.contain,
                          // width: width / 6,
                          // height: height / 6,
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TableRow rowMethod(BuildContext context, text, item) {
    return TableRow(
      // decoration: BoxDecoration(color: secondaryColor.withOpacity(0.3)),
      children: [
        TableCell(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.headlineSmall!,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
            child: Center(
              child: Text(
                item.toString(),
                style: Theme.of(context).textTheme.headlineSmall!,
              ),
            ),
          ),
        ),
      ],
    );
  }

  DataRow recentFileDataRow(
      CarDetail carDetail, BuildContext context, int index) {
    return DataRow(
      cells: [
        DataCell(Text(
          carDetail.default_code == "false"
              ? carDetail.en_name == "false"
                  ? carDetail.name!.toString()
                  : '${carDetail.en_name}-${carDetail.name!}'
              : carDetail.en_name == "false"
                  ? '${carDetail.name!}[${carDetail.default_code}]'
                  : '${carDetail.en_name}[${carDetail.default_code}]-${carDetail.name!}[${carDetail.default_code}]',
          style: const TextStyle(color: textColor, fontSize: 12),
        )),
        DataCell(Text(
          carDetail.categ_id!.toString(),
          style: const TextStyle(color: textColor, fontSize: 12),
        )),
        // DataCell(
        //   Text(carDetail.unitPrice.toString(),
        //       style: Theme.of(context).textTheme.bodyLarge!),
        // ),
        DataCell(Text(
          carDetail.state == 'NEW' ? "new".tr : "processing".tr,
          //== false ? 'New' : carDetail.state.toString(),
          style: const TextStyle(color: textColor, fontSize: 12),
        )),
        DataCell(
          GetBuilder<HomeController>(
              id: 'flage',
              builder: (_) => controller.flags[index] == true
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: TextButton.styleFrom(
                        side: const BorderSide(width: 2, color: textColor),
                        backgroundColor: secondaryColor,
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: 20,
                        //   vertical: defaultPadding /
                        //       (Responsive.isMobile(context) ? 2 : 1),
                        // ),
                      ),
                      child: Text(
                        carDetail.state == 'NEW' ? "start".tr : "complet".tr,
                        style: const TextStyle(color: primaryWhite),
                      ),
                      onPressed: () async {
                        controller.changeFlage(index);
                        // controller.getIndex(index);

                        if (carDetail.state == "NEW") {
                          CarDetail car = CarDetail(
                              default_code: carDetail.default_code,
                              en_name: carDetail.en_name,
                              categ_id: carDetail.categ_id,
                              name: carDetail.name,
                              id: carDetail.id,
                              headerId: carDetail.headerId,
                              technicalisDone: widget.technicalId.toString(),
                              state: 'started',
                              unitPrice: carDetail.unitPrice,
                              completeDate: DateTime.now().toString());
                          controller.sendDataDetails(dataUpdae: [car]);
                          //  await Dbcarsdetails.updatecarsdetailtostartdb(
                          //         car.id!);

                          controller.updateDataDetails(car).then((value) {
                            controller.sendLoading.value = false;
                            loginController.authenticateLoading.value = false;
                            Get.off(() => LoginPage());
                          });
                        } else if (carDetail.state == 'started') {
                          CarDetail car = CarDetail(
                              default_code: carDetail.default_code,
                              categ_id: carDetail.categ_id,
                              name: carDetail.name,
                              en_name: carDetail.en_name,
                              id: carDetail.id,
                              headerId: carDetail.headerId,
                              technicalisDone: widget.technicalId.toString(),
                              state: 'complete',
                              unitPrice: carDetail.unitPrice,
                              completeDate: DateTime.now().toString());
                          controller.sendDataDetails(
                            dataUpdae: [car],
                            // caredId: widget.caredId,
                            // technicalId: widget.technicalId
                          ).then((value) {
                            if (controller.errorissame != true) {
                              print("===================ds==========");
                              controller.updateDataDetails(car).then((value) {
                                controller.sendLoading.value = false;
                                loginController.authenticateLoading.value =
                                    false;
                                Get.off(() => LoginPage());
                              });
                            } else {
                              Get.snackbar('error',
                                  "You can't complete the task you started",
                                  titleText: Text(
                                    'error',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: primaryBlack),
                                  ),
                                  messageText: Text(
                                    "You can't complete the task you started",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: primaryBlack),
                                  ),
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: primaryWhite);
                            }
                          });
                          // await Dbcarsdetails.updatecarsdetailtocompletetdb(
                          //    car.id!);

                          controller.errorissame = false;
                        }
                      },
                    )),
          // Obx(() =>
          // controller.flags[index] == true
          //     ? const CircularProgressIndicator()
          //     :

          //       ),
        ),
      ],
    );
  }
}

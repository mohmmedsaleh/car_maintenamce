import 'package:car_maintenance_technicians/controllers/home_controller.dart';
import 'package:car_maintenance_technicians/model/car.dart';
import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:car_maintenance_technicians/view/home/details_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileInfoCard extends StatelessWidget {
  FileInfoCard({
    Key? key,
    required this.infoCar,
    required this.technicalId,
    required this.cars,
  }) : super(key: key);
  final HomeController controller = Get.put(HomeController());
  final Car infoCar;
  final int technicalId;
  final List cars;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.getcarsdetails(
            caredId: infoCar.carId, technicalId: technicalId);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setBool('homepage', false);
        controller.carid = infoCar.carId;
        controller.update();
        Get.to(() =>
            // MyWidget(
            //           caredName: infoCar.carTypeId,
            //           caredId: infoCar.carId,
            //           technicalId: technicalId,
            //         )

            CardDetail(
              carinfo: infoCar,
              caredName: infoCar.carTypeId,
              caredId: infoCar.carId,
              technicalId: technicalId,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                "images/configuration.png",
                fit: BoxFit.cover,

                // height:16/5 ,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    child: Row(
                      children: [
                        Text(
                          "workno".tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          infoCar.carId.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    child: (() {
                      if (infoCar.carTypeId.isNotEmpty) {
                        return Row(
                          children: [
                            Text(
                              "carType".tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            Text(
                              infoCar.carTypeId,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text(""); // or return null;
                      }
                    })(),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    // padding: EdgeInsets.all(5),
                    // decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(30)),
                    child:
                        // Text(
                        //   "car Panel No: ",
                        //   style: TextStyle(color: Colors.white, fontSize: 20),
                        // ),
                        Row(
                      children: [
                        Text(
                          "Panelno".tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          infoCar.carPanelNo,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   "Car Panel No.: ",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  // Text(
                  //   infoCar.carPanelNo,
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  // Text(
                  //   "Mobile No: ",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  // Text(
                  //   infoCar.partnerMobile,
                  //   style: TextStyle(color: Colors.white),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

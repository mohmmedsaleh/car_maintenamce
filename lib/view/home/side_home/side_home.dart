
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/home_controller.dart';
import '../../../controllers/login_controller.dart';
import '../../../main.dart';
import '../../../responsive.dart';
import '../../../string/constans.dart';
import '../../login/login/login_page.dart';
import 'file_info_card_grid_view.dart';

class SideHome extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final technicalId;
  SideHome({super.key, required this.technicalId});

  final HomeController controller = Get.put(HomeController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFF0f3c66),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF0f3c66),
                border: Border(bottom: BorderSide(color: Colors.white)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loginController.pin,
                    style: const TextStyle(color: primaryWhite),
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
                          HomeController homeController =
                              Get.put(HomeController());

                          await homeController.updatecars();
                        },
                        child: Row(
                          children: [
                            Container(
                              child: const Icon(
                                Icons.update,
                                color: primaryWhite,
                                size: 17,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Text("update".tr,
                                  style: const TextStyle(
                                      color: primaryWhite, fontSize: 12)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<HomeController>(
                  id: 'carsmantains',
                  builder: (_) {
                    return FutureBuilder(
                      future: controller.getcars(
                          technicalId:
                              technicalId), // Replace with your own future function
                      builder:
                          (BuildContext context, AsyncSnapshot snapshotCars) {
                        if (snapshotCars.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  "assets/images/Ellipsis-1s-200px.svg",
                                ),
                              ),
                            ],
                          ); // Show a loading indicator
                        } else if (snapshotCars.hasError) {
                          return Text(
                              'Error: ${snapshotCars.error}'); // Show an error message
                        } else {
                          List data = snapshotCars.data;

                          return data.isEmpty
                              ? Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/Completed-pana.svg",
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover),
                                        Text(
                                          "no_tasks".tr,
                                          style: subtitlestyle2,
                                        ),
                                        // ButtonElevated(
                                        //     right: size.width / 5,
                                        //     left: size.width / 5,
                                        //     minimumSize: 40,
                                        //     text: "logoff".tr,
                                        //     onPressed: () async {
                                        //       SharedPreferences prefs =
                                        //           await SharedPreferences
                                        //               .getInstance();

                                        //       prefs.setBool('homepage', false);
                                        //       Get.offAll(() => LoginPage());
                                        //     })
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding /
                                        (Responsive.isMobile(context) ? 2 : 1),
                                  ),
                                  child: Responsive(
                                    mobile: FileInfoCardGridView(
                                      technicalId: technicalId,
                                      allcar: snapshotCars.data,
                                      childAspectRatio:
                                          size.width < 650 && size.width > 350
                                              ? 1.3
                                              : 1,
                                    ),
                                    tablet: FileInfoCardGridView(
                                      technicalId: technicalId,
                                      allcar: snapshotCars.data,
                                    ),
                                    desktop: FileInfoCardGridView(
                                      technicalId: technicalId,
                                      allcar: snapshotCars.data,
                                      childAspectRatio:
                                          size.width < 1400 ? 1.1 : 1.4,
                                    ),
                                  ),
                                );
                        }
                      },
                    );
                  }),
            ),
          ],
        ));
  }
}

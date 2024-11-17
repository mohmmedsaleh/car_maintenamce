import 'package:car_maintenance_technicians/controllers/home_controller.dart';
import 'package:car_maintenance_technicians/controllers/login_controller.dart';
import 'package:car_maintenance_technicians/local/localcontroller.dart';
import 'package:car_maintenance_technicians/main.dart';
import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:car_maintenance_technicians/view/register/adminlogin/adminlogin.dart';
import 'package:car_maintenance_technicians/view/home/home_page.dart';
import 'package:car_maintenance_technicians/view/login/dblogin/dblogin.dart';
import 'package:car_maintenance_technicians/view/login/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideContainer extends StatefulWidget {
  const SideContainer({super.key});

  @override
  State<SideContainer> createState() => _SideContainerState();
}

class _SideContainerState extends State<SideContainer> {
  bool? login;
  bool? dbpage;
  bool? home_page = false;
  sherd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("============");
    print(prefs.getBool("login"));
    if (prefs.getBool('homepage') != null) {
      setState(() {
        home_page = prefs.getBool('homepage');
      });
    }

    if (prefs.getBool("login") == true) {
      setState(() {
        home_page = false;
        login = true;
      });
    } else {
      setState(() {
        login = false;
      });
    }
    if (prefs.getBool("dbpage") == true) {
      setState(() {
        dbpage = true;
      });
    } else {
      setState(() {
        dbpage = false;
      });
    }
  }

  @override
  void initState() {
    sherd();
    // TODO: implement initState
    super.initState();
  }

  MyLocalController controller = Get.put(MyLocalController());
  @override
  Widget build(BuildContext context) {
    // double height = heightofpage(context);
    return Stack(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "شركه ميزان المجد ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const Text(
                    "لصيانه السيارات وقطع الغيار",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "welcome".tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  Text(
                    "system_name".tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
              Image.asset(
                alignment: Alignment.bottomLeft,
                "assets/images/image.png",
                // height: double.infinity,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.off(() => LoginPage());
                    },
                    child: SizedBox(
                      height: dbpage == true ? 35 : 120 / 2,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.login,
                              color: Colors.blue,
                              size: 17,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text("login emplloyee".tr,
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => Regiteradmin());
                    },
                    child: SizedBox(
                      height: dbpage == true ? 35 : 120 / 2,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.login,
                              color: Colors.blue,
                              size: 17,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text("login admin".tr,
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // showPopover(
              //               direction: PopoverDirection.bottom,
              //               context: mountcontext,
              //               height: 400,
              //               width: 250,
              //               bodyBuilder: (contex) => MenuItems(
              //                     children: searchmonths
              //                         .map((item) => Container(
              //                               padding: const EdgeInsets.all(5),
              //                               child: GestureDetector(
              //                                   onTap: () {
              //                                     setState(() {
              //                                       mounth.text = item[0];
              //                                     });
              //                                   },
              //                                   child:
              //                                       Text(item[0].toString())),
              //                             ))
              //                         .toList(),
              //                   ));
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (buildcontext) {
                    return InkWell(
                      onTap: () => showPopover(
                          direction: PopoverDirection.top,
                          context: buildcontext,
                          width: 150,
                          height: dbpage == true ? 80 : 120,
                          backgroundColor: Colors.blue,
                          bodyBuilder: (context) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Builder(builder: (langcontext) {
                                    return InkWell(
                                      onTap: () {
                                        showPopover(
                                            direction: PopoverDirection.right,
                                            context: langcontext,
                                            width: 80,
                                            height: 60,
                                            backgroundColor: Colors.blue,
                                            bodyBuilder: (context) {
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .cangelanguge("ar");
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text("arabic".tr,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12)),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .cangelanguge("en");
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text("english".tr,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12)),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: SizedBox(
                                        height: dbpage == true ? 35 : 120 / 2,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              child: const Icon(
                                                Icons.language,
                                                color: Colors.white,
                                                size: 17,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              child: Text("language".tr,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12)),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  () {
                                    if (dbpage == true) {
                                      return Container();
                                    } else {
                                      return InkWell(
                                        onTap: () {
                                          sharepref!
                                              .setBool('verification', false);
                                          sharepref!.setBool('dbpage', true);
                                          sharepref!.setBool('login', false);
                                          sharepref!.setBool('homepage', false);
                                          Get.offAll(() => Dblogin(
                                                isUpdate: true,
                                              ));
                                        },
                                        child: SizedBox(
                                          height: login == true
                                              ? 120 / 2
                                              : dbpage == true
                                                  ? 120
                                                  : 120 / 3,
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: const Icon(
                                                  Icons.update,
                                                  color: Colors.white,
                                                  size: 17,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                    "change_database".tr,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12)),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }(),
                                ]);
                          }),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            color: Colors.blue,
                            size: 17,
                          ),
                          Text("settings".tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12))
                        ],
                      ),
                    );
                  }),
                  // InkWell(
                  //   onTap: () async {
                  //     HomeController homeController = Get.put(HomeController());
                  //     LoginController controller =
                  //         await homeController.updatecars();
                  //     Get.offAll(() => HomePage(
                  //         technicalId:
                  //             controller.userInformation["technical_id"]));
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         child: const Icon(
                  //           Icons.update,
                  //           color: Colors.blue,
                  //           size: 17,
                  //         ),
                  //       ),
                  //       Container(
                  //         padding: const EdgeInsets.all(5),
                  //         child: Text("update".tr,
                  //             style: const TextStyle(
                  //                 color: Colors.blue, fontSize: 12)),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // () {
                  //   if (home_page == false) {
                  //     return Container();
                  //   } else {
                  //     return InkWell(
                  //       onTap: () async {
                  //         HomeController homeController =
                  //             Get.put(HomeController());
                  //         LoginController controller =
                  //             await homeController.updatecars();
                  //         Get.offAll(() => HomePage(
                  //             technicalId:
                  //                 controller.userInformation["technical_id"]));
                  //       },
                  //       child: Row(
                  //         children: [
                  //           Container(
                  //             child: const Icon(
                  //               Icons.update,
                  //               color: Colors.blue,
                  //               size: 17,
                  //             ),
                  //           ),
                  //           Container(
                  //             padding: const EdgeInsets.all(5),
                  //             child: Text("update".tr,
                  //                 style: const TextStyle(
                  //                     color: Colors.blue, fontSize: 12)),
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }
                  // }(),
                  // () {
                  //   if (login == true) {
                  //     return Container();
                  //   } else {
                  //     return InkWell(
                  //       onTap: () async {
                  //         SharedPreferences prefs =
                  //             await SharedPreferences.getInstance();
                  //         prefs.setBool('login', true);
                  //         if (sharepref!.getBool('dbpage') == true) {
                  //           sharepref!.setBool('dbpage', false);
                  //         }
                  //         sharepref!.setBool('homepage', false);
                  //         Get.offAll(() => LoginPage());
                  //       },
                  //       child: Row(
                  //         children: [
                  //           Container(
                  //             child: const Icon(
                  //               Icons.login_outlined,
                  //               color: Colors.blue,
                  //               size: 17,
                  //             ),
                  //           ),
                  //           Container(
                  //             padding: const EdgeInsets.all(5),
                  //             child: Text("logoff".tr,
                  //                 style: const TextStyle(
                  //                     color: Colors.blue, fontSize: 12)),
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }
                  // }(),
                ],
              ),
            ],
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: defaultPadding,
        //     vertical: defaultPadding / 2,
        //   ),
        //   decoration: BoxDecoration(
        //     color: primaryColor.withOpacity(0.4),
        //   ),
        // ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.symmetric(
        //         horizontal: defaultPadding,
        //         vertical:
        //             defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        //       ),
        //       child:
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Image.asset(
        //             "assets/images/logo.png",
        //             height: 38,
        //           ),
        //           const SizedBox(
        //             width: defaultPadding,
        //           ),
        //           !Responsive.isTablet(context) ?
        //           Flexible(
        //             child: Text(
        //               "Dashboard",
        //               style: Theme.of(context).textTheme.titleLarge,
        //             ),
        //           ):
        //           Container(),
        //         ],
        //       ),
        //     ),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           "أهلا وسهلا بكم",
        //           style: Theme.of(context).textTheme.titleLarge,
        //         ),
        //         Text(
        //           "تطبيق المجدي للسيارات",
        //           style: Theme.of(context).textTheme.titleLarge,
        //         ),
        //       ],
        //     ),
        //     Container()
        //   ],
        // ),
      ],
    );
  }
}

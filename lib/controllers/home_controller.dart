
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/carditals.dart';
import '../view/login/login/login_page.dart';
import 'login_controller.dart';

class HomeController extends GetxController {
  final loanLoading = false.obs;
  final sendLoading = false.obs;
  List<CarDetail> shareDataitems = [];
  List<CarDetail> carsdetails = [];
  List flags = [];
  List<CarDetail> saveCarsDetails = [];
  final LoginController loginController = Get.find();
  int carid = 0;
  OdooClient get odooClient => loginController.odooClient!;
  bool errorissame = false;

  var index = 0.obs;
  // void getIndex(int ind) {
  //   index.value = ind;
  // }

  void addToFlage(bool flage) {
    flags.add(flage);
    update(['flage']);
  }

  void changeFlage(int index) {
    if (flags[index] = true) {
      flags[index] = false;
    } else {
      flags[index] = true;
    }

    update(['flage']);
  }

//اولا يتم جلب التفاصيل وبعدين نجيب الماستر
  // Future getcarsLins({
  //   required technicalId,
  // }) async {
  //   try {
  //     try {
  //       await odooClient.checkSession();
  //     } catch (e) {
  //       Get.off(() => const LoginPage());
  //     }
  //     var carsLins = odooClient.callKw({
  //       'model': 'mizan.car.work.procedure.line',
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [
  //           ['technical_name', '=', technicalId],
  //           ['state', '=', 'un_complete']
  //         ],
  //         // 'limit': 4
  //       },
  //     });
  //     print(carsLins);
  //     return carsLins;
  //   } on OdooException catch (e) {
  //     print(e);
  //   }
  // }

  // عرض كافة السيارات المسندة للموظف
  Future getcars({
    required int technicalId,
  }) async {
    try {
      ///////////////////////////////////////////////////////////
      // try {
      //   await odooClient.checkSession();
      // } catch (e) {
      //   Get.off(() => const LoginPage());
      // }

      // List carnotcomplet = await Dbcarsdetails.getcarsnotcomplet();
      // List index = [];
      // List carforemployee = [];
      // for (var i = 0; i < carnotcomplet.length; i++) {
      //   List car = await DbCars.getcarsbyiddb(carnotcomplet[i]["headerId"]);

      //   if (index.contains(car[0]['id']) == false) {
      //     index.add(car[0]['id']);
      //     carforemployee.add(car[0]);
      //   }

      //   // carforemployee.add(car[0]);
      // }
      List carforemployee = loginController.cars;
      return carforemployee;
    } catch (e) {
      loanLoading.value = false;
      print(e);
    }
  }

  // عرض كافة السيارات المسندة للموظف
  // Future getcars({
  //   required List headerIds,
  // }) async {
  //   try {
  //     try {
  //       await odooClient.checkSession();
  //     } catch (e) {
  //       Get.off(() => const LoginPage());
  //     }
  //     var cares = odooClient.callKw({
  //       'model': 'mizan.car.work.procedure.master',
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [
  //           ['id', 'in', headerIds],
  //           ['state', '=', 'execute_completed']
  //         ],
  //         // 'limit': 2
  //       },
  //     });
  //     return cares;
  //   } on OdooException catch (e) {
  //     loanLoading.value = false;
  //     print(e);
  //   }
  // }
  // عرض السيارة
  // Future getcar({
  //   required int headerId,
  // }) async {
  //   try {
  //     // try {
  //     //   await odooClient.checkSession();
  //     // } catch (e) {
  //     //   Get.off(() => const LoginPage());
  //     // }
  //     // var car = odooClient.callKw({
  //     //   'model': 'mizan.car.work.procedure.master',
  //     //   'method': 'search_read',
  //     //   'args': [],
  //     //   'kwargs': {
  //     //     'context': {},
  //     //     'domain': [
  //     //       ['id', '=', headerId],
  //     //     ],
  //     //   },
  //     // });

  //     List car = await DbCars.getcarsbyiddb(headerId);

  //     return car;
  //   } on OdooException catch (e) {
  //     loanLoading.value = false;
  //     print(e);
  //   }
  // }

//عرض تفاصيل السيارة
  Future getcarsdetails({
    required caredId,
    required technicalId,
  }) async {
    try {
      carsdetails = [];
      update(["carsdetails"]);
      try {
        await odooClient.checkSession();
      } catch (e) {
        Get.off(() => LoginPage());
      }

      List cars = await odooClient.callKw({
        'model': 'mizan.car.work.procedure.line',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            [
              'header_id',
              '=',
              [caredId]
            ],
            ['technical_name', '=', technicalId],
            ['state', '!=', 'complete']
          ],
          'fields': [
            'id',
            'name',
            'product_id',
            'header_id',
            'technical_is_done',
            'state',
            'complete_date',
            'unit_price',
            //  "en_name"
          ],
        },
      });
      print("object");
      print(cars);
      // var name_en = await odooClient.callKw({
      //   'model': 'mizan.car.work.procedure.master',
      //   'method': 'return_product_en_name',
      //   'args': [65840],
      //   'kwargs': {
      //     'context': {},
      //   },
      // });

      // List cars = await Dbcarsdetails.getcarsnotcompletBYID(caredId);
      // carsdetails = [];

      for (var carJson in cars) {
        List detailsservices = await odooClient.callKw({
          'model': 'product.product',
          'method': 'search_read',
          'args': [],
          'kwargs': {
            'context': {},
            'domain': [
              ['id', '=', carJson['product_id'][0]],
            ],
            'fields': ['name', 'default_code', "categ_id", 'en_name'],
          },
        });
        print(detailsservices);
        var car = {
          'id': carJson['id'] as int,
          'headerId': carJson['header_id'].runtimeType != int
              ? carJson['header_id'][0] as int
              : carJson['header_id'] as int,
          'categ_id': detailsservices[0]['categ_id'].runtimeType != String
              ? detailsservices[0]['categ_id'][1].toString()
              : detailsservices[0]['categ_id'] as String,
          'name': carJson['name'] as String,
          'en_name': detailsservices[0]['en_name'].runtimeType == bool
              ? "false"
              : detailsservices[0]['en_name'],
          'default_code': detailsservices[0]['default_code'].runtimeType == bool
              ? "false"
              : detailsservices[0]['default_code'],
          'technical_is_done': carJson['technical_is_done'].runtimeType != bool
              ? carJson['technical_is_done'][0].toString()
              : carJson['technical_is_done'].toString(),
          'state': carJson['state'] == false ? 'NEW' : carJson['state'],
          'complete_date': carJson['complete_date'] == String
              ? carJson['complete_date']
              : carJson['complete_date'].toString(),
          'unit_price': carJson['unit_price']
        };
        print(car);
        CarDetail carDetail = CarDetail.fromJson(car);
        carsdetails.add(carDetail);
        carsdetails.sort((a, b) => a.id!.compareTo(b.id!));
        update(["carsdetails"]);
      }
      update(["carsdetails"]);
      return carsdetails;
    } on OdooException catch (e) {
      print(e);
    }
  }

//إضافة البيانات الى اللست
  // Future addDataInList({required CarDetail carDetail}) async {
  //   try {
  //     if (carsdetails.any((item) => item.id == carDetail.id)) {
  //       if (saveCarsDetails.any((item) => item.id == carDetail.id)) {
  //         if (saveCarsDetails.any(
  //             (item) => item.id == carDetail.id && carDetail.state == "NEW")) {}
  //         saveCarsDetails.removeWhere((item) => item.id == carDetail.id);
  //         carsdetails.removeWhere((item) => item.id == carDetail.id);
  //         CarDetail newCar = CarDetail(
  //             name: carDetail.name,
  //             productId: carDetail.productId,
  //             id: carDetail.id,
  //             unitPrice: carDetail.unitPrice,
  //             headerId: carDetail.headerId,
  //             state: carDetail.state,
  //             technicalisDone: 'false',
  //             completeDate: 'fale');
  //         print(newCar.state);
  //         carsdetails.add(newCar);
  //         carsdetails.sort((a, b) => a.id!.compareTo(b.id!));
  //         update();
  //       } else {
  //         print(carsdetails.any((item) =>
  //             item.id == carDetail.id && carDetail.state == "started"));
  //         if (carsdetails.any((item) =>
  //             item.id == carDetail.id && carDetail.state == "complete")) {
  //           carsdetails.removeWhere((item) => item.id == carDetail.id);
  //           carsdetails.add(carDetail);
  //           carsdetails.sort((a, b) => a.id!.compareTo(b.id!));
  //           saveCarsDetails.add(carDetail);
  //           sendDataDetails(dataUpdae: saveCarsDetails);
  //           update();
  //         }
  //         if (carsdetails.any((item) =>
  //             item.id == carDetail.id && carDetail.state == "started")) {
  //           saveCarsDetails.add(carDetail);
  //           update();
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // جلب البيانات من الشيربريفنس
// Future getDataInSharedPreferences({required cardId}) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       // List<Map<String, dynamic>> dataitems = [];
//       var data = prefs.getStringList('items_done') ?? [];
//       if (data.isNotEmpty) {
//         // return userJsonList.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
//         var items =
//             data.map((item) => CarDetail.fromJson(jsonDecode(item))).toList();

//         shareDataitems =
//             items.where((card) => card.headerId == cardId).toList();
//         update();
//       }

//       return shareDataitems;
//     } catch (e) {
//       print(e);
//     }
//   }

  // //إضافة البيانات الى الشيربريفنس
  // Future addDataInSharedPreferences({required CarDetail carDetail}) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     List<CarDetail> items = (prefs.getStringList('items_done') ?? [])
  //         .map((item) => CarDetail.fromJson(jsonDecode(item)))
  //         .toList();

  //     if (items.any((item) => item.id == carDetail.id)) {
  //       items.removeWhere((item) => item.id == carDetail.id);
  //     } else {
  //       items.add(carDetail);
  //     }

  //     List<String> updatedList =
  //         items.map((item) => jsonEncode(item.toJson())).toList();
  //     await prefs.setStringList('items_done', updatedList);
  //     shareDataitems = items;
  //     update();
  //     // return shareDataitems;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//حذف البيانات من الشيربريفنس بعد عملية إرسال البيانات الى الاودوو
  // void deleteUserFromListSharedPreferences(CarDetail carDetail) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Retrieve the list of User objects from SharedPreferences
  //   List<String>? detailCarListJson = prefs.getStringList('items_done');
  //   if (detailCarListJson != null) {
  //     List<CarDetail> cardDetailList = detailCarListJson
  //         .map((cardDetail) => CarDetail.fromJson(jsonDecode(cardDetail)))
  //         .toList();

  //     // Remove the desired User object from the list
  //     cardDetailList.removeWhere(
  //         (user) => user.id == carDetail.id && user.name == carDetail.name);

  //     // Convert the updated list back to JSON
  //     List<String> updatedCarListJson =
  //         cardDetailList.map((user) => jsonEncode(user.toJson())).toList();

  //     // Save the updated list back to SharedPreferences
  //     await prefs.setStringList('items_done', updatedCarListJson);
  //     shareDataitems = cardDetailList;
  //     update();
  //   }
  // }

  // //تحديث البيانات بعد عملية الاكتمال
  // Future updateDataDetails({
  //   required List<CarDetail> lineIds,
  //   required List<CarDetail> sharedData,
  // }) async {
  //   try {
  //     List<CarDetail> itemsLoop = [];
  //     try {
  //       await odooClient.checkSession();
  //     } catch (e) {
  //       Get.off(() => const LoginPage());
  //     }

  //     itemsLoop = lineIds
  //         .where((item1) => sharedData.any((item2) => item1.id == item2.id))
  //         .toList();

  //     for (int item = 0; item < itemsLoop.length; item++) {
  //       odooClient.callKw({
  //         'model': 'mizan.car.work.procedure.line',
  //         'method': 'write',
  //         'args': [itemsLoop[item].id, itemsLoop[item].toJson()],
  //         'kwargs': {
  //           'context': {},
  //           // 'limit': 4
  //         },
  //       });
  //       deleteUserFromListSharedPreferences(itemsLoop[item]);
  //     }

  //     return true;
  //   } on OdooException catch (e) {
  //     print(e);
  //   }
  // }

  //تحديث البيانات بعد عملية الاكتمال
  Future sendDataDetails({
    required List<CarDetail> dataUpdae,
    // required caredId,
    // required technicalId,
  }) async {
    sendLoading.value = true;
    try {
      try {
        await odooClient.checkSession();
      } catch (e) {
        sendLoading.value = false;
        Get.off(() => LoginPage());
      }

      for (int item = 0; item < dataUpdae.length; item++) {
        print(dataUpdae.length);

        if (dataUpdae[item].state == 'started') {
          odooClient.callKw({
            'model': 'mizan.car.work.procedure.line',
            'method': 'write',
            'args': [
              dataUpdae[item].id,
              {
                'start_Service_date':
                    dataUpdae[item].completeDate.substring(0, 19),
                'state': dataUpdae[item].state,
                // 'technical_is_done': dataUpdae[item].technicalisDone,
                'technical_is_started': dataUpdae[item].technicalisDone,
              }
            ],
            'kwargs': {
              'context': {},
            },
          });
        }
        if (dataUpdae[item].state == 'complete') {
          List cars = await odooClient.callKw({
            'model': 'mizan.car.work.procedure.line',
            'method': 'search_read',
            'args': [],
            'kwargs': {
              'context': {},
              'domain': [
                [
                  'id',
                  '=',
                  dataUpdae[item].id,
                ]
                // [
                //   'header_id',
                //   '=',
                //   [caredId]
                // ],
                // ['technical_name', '=', technicalId],
                // ['state', '!=', 'complete']
              ],
              'fields': [
                'id',
                'technical_is_done',
                'technical_name',
              ],
            },
          });
          print("cars$cars");
          if (cars[0]['technical_name'].length > 1) {
            if (cars[0]['technical_is_done'][0].toString() ==
                dataUpdae[item].technicalisDone) {
              errorissame = true;
              print("same=================");
            } else {
              odooClient.callKw({
                'model': 'mizan.car.work.procedure.line',
                'method': 'write',
                'args': [
                  dataUpdae[item].id,
                  {
                    'complete_date':
                        dataUpdae[item].completeDate.substring(0, 19),
                    'state': dataUpdae[item].state,
                    'technical_is_done': dataUpdae[item].technicalisDone
                  }
                ],
                'kwargs': {
                  'context': {},
                },
              });
              carsdetails.removeWhere(
                  (removeitem) => removeitem.id == dataUpdae[item].id);
            }
          } else {
            odooClient.callKw({
              'model': 'mizan.car.work.procedure.line',
              'method': 'write',
              'args': [
                dataUpdae[item].id,
                {
                  'complete_date':
                      dataUpdae[item].completeDate.substring(0, 19),
                  'state': dataUpdae[item].state,
                  'technical_is_done': dataUpdae[item].technicalisDone
                }
              ],
              'kwargs': {
                'context': {},
              },
            });
            carsdetails.removeWhere(
                (removeitem) => removeitem.id == dataUpdae[item].id);
          }
        }
        update(["sendDataDetails"]);
        // carsdetails
        //     .removeWhere((removeitem) => removeitem.id == dataUpdae[item].id);
        // update(["sendDataDetails", ""]);
      }

      return true;
    } on OdooException catch (e) {
      sendLoading.value = false;
      print(e);
    }
  }

  Future updateDataDetails(CarDetail car) async {
    // carsdetails.indexOf(element)
    var index = carsdetails.indexWhere((element) => element.id == car.id);

    // carsdetails.removeWhere((element) => element.id == car.id);
    if (car.state == "started") {
      carsdetails[index].technicalisDone = car.technicalisDone;
      carsdetails[index].completeDate = car.completeDate;
      carsdetails[index].state = car.state;
    }
    if (car.state == "complete") {
      carsdetails.removeWhere((element) => element.id == car.id);
    }
    update([
      "sendDataDetails",
    ]);
  }

  Future<LoginController> updatecars() async {
    LoginController controller = Get.put(LoginController());
    try {
      await odooClient.checkSession();
    } catch (e) {
      sendLoading.value = false;
      Get.off(() => LoginPage());
    }
    List carsnew = await odooClient.callKw({
      'model': 'mizan.car.work.procedure.master',
      'method': 'return_car_data',
      'args': [controller.userInformation["technical_id"]],
      'kwargs': {
        'context': {},
      },
    });

    controller.cars = carsnew;
    controller.update();
    update(['carsmantains']);
    print("after update");
    print(controller.cars);
    return controller;
  }
}

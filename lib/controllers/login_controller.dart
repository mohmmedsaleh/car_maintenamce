import 'package:car_maintenance_technicians/model/loginmodel.dart';
import 'package:get/get.dart';

import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final authenticateLoading = false.obs;
  bool hasData = false;
  bool hasfeatures = false;
  var userInformation = {};
  var userfeatures = [];
  OdooClient? odooClient;
  List cars = [];
  List carsdetails = [];
  String pin = "";
  Future authenticate({required LoginModel loginModel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("login======start==================");
    try {
      authenticateLoading.value = true;
      odooClient = OdooClient(loginModel.url);
      // odooClient = OdooClient('http://20.20.20.141:8013');
      await odooClient!
          .authenticate(loginModel.db, loginModel.login, loginModel.password);

      var data = await odooClient!.callKw({
        'model': 'mizan.car.work.procedure.master',
        'method': 'return_technical_id',
        'args': [loginModel.pin],
        'kwargs': {
          'context': {},
        },
      });
      pin = "";
      pin = loginModel.pin!;
      if (data != false) {
        userInformation = data;
        // userfeatures = await odooClient!.callKw({
        //   'model': 'emp.face.features',
        //   'method': 'search_read',
        //   'args': [],
        //   'kwargs': {
        //     'context': {},
        //     'domain': [
        //       ['employee_id', '=', userInformation["emp_id"]]
        //     ],
        //   },
        // });
        hasData = true;
        // if (userfeatures.length != 0) {
        // hasfeatures = true;
        cars = await odooClient!.callKw({
          'model': 'mizan.car.work.procedure.master',
          'method': 'return_car_data',
          'args': [userInformation["technical_id"]],
          'kwargs': {
            'context': {},
          },
        });
        // }
        // if (userfeatures.length == 0) {
        //   hasfeatures = false;
        // }
        print("login========================");

        // Dbcarsdetails.createcarsdetailsTable();

        // DbCars.createcarsTable();
        // //Dbcarsdetails.dropcarsdetaildb();
        // DbCars.deletecarsdb();

        // Dbcarsdetails.deletecarsdetaildb();

        // for (var i = 0; i < cars.length; i++) {
        //   var carrow = Car.fromJson(cars[i]);

        //   // DbCars.insertRowcarsdb(carsData: carrow);

        //   for (var i = 0; i < carsdetails.length; i++) {
        //     var cardetailsrow = CarDetail.fromJson(carsdetails[i]);

        //     //Dbcarsdetails.insertRowcarsdetaildb(carsdetailData: cardetailsrow);
        //   }
        // }

        //   var x = Dbcarsdetails.updatecarsdetailtostartdb(25821);
        prefs.setBool('homepage', true);

        prefs.setBool('verification', true);
        update();
      } else {
        hasData = false;
        authenticateLoading.value = false;
        update();
      }

      return "true";
    } catch (e) {
      authenticateLoading.value = false;
      return "Odoo Server Error";
    }
  }

  // returnTechnicalId(
  //   ) async {
  //   try {

  //     getemployeeLoading.value = false;
  //     print(data);

  //     return data;
  //   } catch (e) {
  //     getemployeeLoading.value = false;
  //     print(e);
  //   }
  // }
  Future cheakconnection({required LoginModel loginModel}) async {
    try {
      authenticateLoading.value = true;
      OdooClient odooClient = OdooClient(loginModel.url);
      // odooClient = OdooClient('http://20.20.20.141:8013');
      await odooClient.authenticate(
          loginModel.db, loginModel.login, loginModel.password);
      authenticateLoading.value = false;

      return "true";
    } catch (e) {
      authenticateLoading.value = false;
      return "Odoo Server Error";
    }
  }
}


import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../model/loginmodel.dart';
import '../model/user_model.dart';

class registerController extends GetxController {
  final authenticateLoading = false.obs;
  bool hasData = false;
  var userInformation = {};
  OdooClient? odooClient;

  Future authenticate({required LoginModel loginModel}) async {
    try {
      authenticateLoading.value = true;
      odooClient = OdooClient(loginModel.url);
      // odooClient = OdooClient('http://20.20.20.141:8013');
      await odooClient!
          .authenticate(loginModel.db, loginModel.login, loginModel.password);

      authenticateLoading.value = false;
      update();
      return true;
    } catch (e) {
      authenticateLoading.value = false;
      return "Odoo Server Error";
    }
  }

  Future cheackpin({required pin}) async {
    try {
      authenticateLoading.value = true;
      var data = await odooClient!.callKw({
        'model': 'mizan.car.work.procedure.master',
        'method': 'return_technical_id',
        'args': [pin],
        'kwargs': {
          'context': {},
        },
      });
      print("data$data");
      if (data != false) {
        hasData = true;
        userInformation = data;
        print(userInformation);
      }
      authenticateLoading.value = false;
      update();
    } catch (e) {
      print(e);
      authenticateLoading.value = false;
      return "Odoo Server Error";
    }
  }

  Future adduser({required UserModel user}) async {
    try {
      authenticateLoading.value = true;

      await odooClient!.callKw({
        'model': 'hr.employee',
        'method': 'write',
        'args': [
          user.id,
          {'image_1920': user.image}
        ],
        'kwargs': {
          'context': {},
        },
      });
      List userfeatures = await odooClient!.callKw({
        'model': 'emp.face.features',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['employee_id', '=', user.id]
          ],
        },
      });
      if (userfeatures.isNotEmpty) {
        await odooClient!.callKw({
          'model': 'emp.face.features',
          'method': 'write',
          'args': [user.id, user.toJson()],
          'kwargs': {
            'context': {},
          },
        });
      }
      if (userfeatures.isEmpty) {
        await odooClient!.callKw({
          'model': 'emp.face.features',
          'method': 'create',
          'args': [user.toJson()],
          'kwargs': {
            'context': {},
          },
        });
      }
      authenticateLoading.value = false;

      update();
    } catch (e) {
      authenticateLoading.value = false;
      return "Odoo Server Error";
    }
  }
}

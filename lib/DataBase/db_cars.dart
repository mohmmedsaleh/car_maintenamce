// import 'package:car_maintenance_technicians/DataBase/db_helper.dart';
// import 'package:car_maintenance_technicians/model/car.dart';

// class DbCars {
//   static const String tableName = 'cars';

//   static Future<void> createcarsTable() async {
//     var db = await DbHelper.openDatabase();
//     await db.execute('''
//     CREATE TABLE IF NOT EXISTS $tableName (
//       id INTEGER ,
//       partner_name TEXT,
//       partner_mobile TEXT,
//       car_type TEXT,
//       car_panel_no TEXT,
//       state TEXT,
//       branch_name TEXT
//     )
//   ''');
//     print('create cars Table successfully');
//   }

//   static Future<bool> checkcarsExists({required int carsId}) async {
//     var db = await DbHelper.openDatabase();

//     final result = await db.query(
//       tableName,
//       where: 'id = ?',
//       whereArgs: [carsId],
//     );
//     // await db.close();

//     return result.isNotEmpty;
//   }

//   static Future<void> updatecarsInDatabase(
//       {required int carsId, required Car updatedData}) async {
//     print("update accountjournalsetting In Database");
//     var db = await DbHelper.openDatabase();
//     await db.update(
//       tableName,
//       updatedData.toJson(),
//       where: 'id = ?',
//       whereArgs: [carsId],
//     );

//     // await db.close();
//   }

//   static void insertRowcarsdb({required Car carsData}) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       print(carsData.carId);
//       await db.insert(tableName, carsData.toJson());
//       await db.close();
//     } catch (e) {
//       print(e);
//       print("can no insert into carsdb");
//     }
//   }

//   static void insertcarsdb({required List carsData}) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       for (var item in carsData) {
//         bool exists = await checkcarsExists(carsId: item["id"]);
//         if (exists) {
//           await updatecarsInDatabase(
//               carsId: item["id"], updatedData: Car.fromJson(item));
//           print('Item updated in the local database');
//         } else {
//           print('Item does not exist in the local database');
//           Car cars = Car.fromJson(item);
//           await db.insert(tableName, cars.toJson());
//         }
//       }

//       print("close");
//     } catch (e) {
//       print("can no insert into carsdb");
//     }
//   }

//   static Future<List> getcarsdb() async {
//     try {
//       var db = await DbHelper.openDatabase();
//       var query = await db.query(tableName);
//       print("query++++++++++++cars");
//       print(query.length);
//       return query;
//     } catch (e) {
//       print("tabe cars is come");
//       return [];
//     }
//   }

//   static Future<List> getcarsbyiddb(int idcar) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       var query =
//           await db.rawQuery('''SELECT * FROM $tableName where id =$idcar''');

//       print("query++++++++++++cars");
//       print(query.length);
//       return query;
//     } catch (e) {
//       print("tabe cars is come");
//       return [];
//     }
//   }
//   // static Future<List> getallsettingdb() async {
//   //   try {
//   //     var db = await DbHelper.openDatabase();
//   //     var query = await db.rawQuery('''
//   //   SELECT $tableName.id,Setting.id AS Setting_id,Setting.name AS Setting_name,Setting.cash_partner_id,Setting.cash_partner_name,Setting.credit_journal_id,Setting.credit_journal_name,Setting.pos_warehouses_id,Setting.pos_warehouses_name,Setting.out_picking_type_id,Setting.out_picking_type_name,Setting.in_picking_type_id,Setting.in_picking_type_name,Setting.use_employee_flag,accountjornal.id AS accountjornal_id,accountjornal.name AS accountjornal_name
//   //   FROM Setting
//   //   INNER JOIN $tableName ON Setting.id = $tableName.settingID
//   //   INNER JOIN accountjornal ON $tableName.accountjournalID = accountjornal.id
//   //   ''');
//   //     print(query);

//   //     await db.close();
//   //     print("query++++++++++++accountjournalsetting");
//   //     print(query.length);
//   //     print(query);
//   //     return query;
//   //   } catch (e) {
//   //     print("tabe accountjournalsetting is come");
//   //     return [];
//   //   }
//   // }

//   static void deletecarsdb() async {
//     var db = await DbHelper.openDatabase();
//     // Delete the table
//     await db.delete(tableName);
//     // Close the database

//     print('Table deleted successfully');
//   }
// }

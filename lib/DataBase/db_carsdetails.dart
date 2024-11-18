// import 'package:car_maintenance_technicians/DataBase/db_helper.dart';
// import 'package:car_maintenance_technicians/model/carditals.dart';

// class Dbcarsdetails {
//   static const String tableName = 'carsdetails';

//   static Future<void> createcarsdetailsTable() async {
//     var db = await DbHelper.openDatabase();
//     await db.execute('''
//     CREATE TABLE IF NOT EXISTS $tableName (
//       id INTEGER ,
//       headerId INTEGER,
//       productId TEXT,
//       name TEXT,
//       unit_price REAL,
//       technical_is_done TEXT,
//       state TEXT,
//       complete_date TEXT,
      
//       FOREIGN KEY (headerId) REFERENCES cars(id)
//     )
//   ''');
//     print('create carsdetails Table successfully');
//   }

//   static Future<bool> checkcarsdetailsExists(
//       {required int carsdetailsId}) async {
//     var db = await DbHelper.openDatabase();

//     final result = await db.query(
//       tableName,
//       where: 'id = ?',
//       whereArgs: [carsdetailsId],
//     );
//     // await db.close();

//     return result.isNotEmpty;
//   }

//   static Future<void> updatecarsdetailsInDatabase(
//       {required int carsdetailsId, required CarDetail updatedData}) async {
//     print("update carsdetail In Database");
//     var db = await DbHelper.openDatabase();
//     await db.update(
//       tableName,
//       updatedData.toJson(),
//       where: 'id = ?',
//       whereArgs: [carsdetailsId],
//     );

//     // await db.close();
//   }

//   static void insertRowcarsdetaildb({required CarDetail carsdetailData}) async {
//     try {
//       var db = await DbHelper.openDatabase();

//       await db.insert(tableName, carsdetailData.toJson());
//     } catch (e) {
//       print(e);
//       print("can no insert into carsdetaildb");
//     }
//   }

//   static void insertcarsdetaildb({required List carsdetailData}) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       for (var item in carsdetailData) {
//         bool exists = await checkcarsdetailsExists(carsdetailsId: item["id"]);
//         if (exists) {
//           await updatecarsdetailsInDatabase(
//               carsdetailsId: item["id"], updatedData: CarDetail.fromJson(item));
//           print('Item updated in the local database');
//         } else {
//           print('Item does not exist in the local database');
//           CarDetail carsdetail = CarDetail.fromJson(item);
//           await db.insert(tableName, carsdetail.toJson());
//         }
//       }
//       //  await db.close();
//       print("close");
//     } catch (e) {
//       print("can no insert into  carsdetaildb");
//     }
//   }

//   static Future<List> getcarsdetaildb() async {
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

//   static void deletecarsdetaildb() async {
//     var db = await DbHelper.openDatabase();
//     // Delete the table
//     await db.delete(tableName);
//     // Close the database

//     print('Table deleted successfully');
//   }

//   static void dropcarsdetaildb() async {
//     var db = await DbHelper.openDatabase();
//     // Delete the table
//     await db.execute('''
// Drop Table $tableName
// ''');
//     // Close the database

//     print('Table drop successfully');
//   }

//   static Future<List> getcarsdetailbyiddb(int idcar) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       var query = await db
//           .rawQuery('''SELECT * FROM $tableName where headerId =$idcar''');

//       print("query++++++++++++cars");
//       print(query.length);
//       return query;
//     } catch (e) {
//       print("tabe cars is come");
//       return [];
//     }
//   }

//   static Future<int> updatecarsdetailtostartdb(int id) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       var query = await db.rawUpdate(
//           'UPDATE $tableName SET state = ? WHERE id = ?', ['started', id]);

//       print("query++++++++++++cars");

//       return query;
//     } catch (e) {
//       print("tabe cars is come");
//       return 0;
//     }
//   }

//   static Future<int> updatecarsdetailtocompletetdb(int id) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       var query = await db.rawUpdate(
//           'UPDATE $tableName SET state = ? WHERE id = ?', ['complete', id]);

//       print("query++++++++++++cars");

//       return query;
//     } catch (e) {
//       print("tabe cars is come");
//       return 0;
//     }
//   }

//   static Future<List> getcarsnotcomplet() async {
//     try {
//       var db = await DbHelper.openDatabase();
//       var query = await db.rawQuery(
//           'SELECT * FROM $tableName WHERE state = ? OR state = ?',
//           ['NEW', 'started']);

//       print("query++++++yyy++++++cars");
//       print(query);
//       return query;
//     } catch (e) {
//       print("tabe cars is come");
//       return [];
//     }
//   }

//   static Future<List> getcarsnotcompletBYID(int id) async {
//     try {
//       var db = await DbHelper.openDatabase();
//       var query = await db.rawQuery(
//           ' SELECT * FROM $tableName WHERE headerId = ? AND (state = ? OR state =? )',
//           [id, 'NEW', 'started']);

//       print("query++++++yyy++++++cars");
//       print(query);
//       return query;
//     } catch (e) {
//       print(e);
//       print("tabe cars is come");
//       return [];
//     }
//   }
// }

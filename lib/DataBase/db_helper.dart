// // ignore_for_file: file_names, depend_on_referenced_packages

// import 'dart:ffi';
// import 'dart:io' as io;
// import 'package:path/path.dart' as p;

// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:path/path.dart';

// class DbHelper {
//   static const String dbName = 'carsmaintains.db';

//   static Future<String> dbPath() async {
//     String path = join(await getDatabasesPath(), dbName);
//     print(path);
//     return path;
//   }

//   static DatabaseFactory databaseFactory() {
//     return databaseFactoryFfi;
//   }

//   static Future<Database> openDatabase() async {
//     var databaseFactory = databaseFactoryFfi;
//     final io.Directory appDocumentsDir =
//         await getApplicationDocumentsDirectory();

//     //Create path for database
//     String dbPath = p.join(appDocumentsDir.path, "databases", dbName);
//     var db = await databaseFactory.openDatabase(
//       dbPath,
//     );

//     print('Database open successfully');
//     return db;
//   }

//   static Future<void> deleteDatabase() async {}

//   static Future<void> closeDatabase() async {
//     var db = await openDatabase();
//     db.close;
//     print('Database close successfully');
//   }

// //   static Future<bool> checkInternetConnectivity() async {
// //     print("checkInternetConnectivity");
// //   var connectivityResult = await ConnectivityWrapper.instance.isConnected;
// //   print("connectivityResult");
// //   print(connectivityResult);
// //     if(connectivityResult){
// //       print("Internet connection is available");
// //       return true;
// //     }
// //     else{
// //       print("Internet connection is  not available");
// //       return false;
// //     }

// // }

//   // static Future<bool> checkInternetConnectivity() async {
//   //   try {
//   //     final result = await InternetAddress.lookup('google.com');
//   //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//   //       return true; // Internet connection is available
//   //     }
//   //   } on SocketException catch (_) {
//   //     return false; // No internet connection
//   //   }
//   //   return false; // No internet connection
//   // }

//   // static Future<bool> checkInternet() async {
//   //   bool isConnected = await checkInternetConnectivity();
//   //   if (isConnected) {
//   //     print('Internet is available');
//   //     return true;
//   //   } else {
//   //     print('No internet connection');
//   //     return false;
//   //   }
//   // }

// //   static socketDatabase() async {
// //     print("socketDatabase");
// //     IO.Socket socket;
// //     socket = IO.io('http://20.20.20.120:8069', <String, dynamic>{
// //       'transports': ['websocket'],
// //       'autoConnect': false,
// //     });
// //     print("connect");
// //     print(socket.connect());
// //     socket.emit('fetch_data', {
// //       'model': 'product.product',
// //       'method': 'search_read',
// //       'args': [
// //         [],
// //         ['name', 'list_price'], // Specify the fields you want to retrieve
// //       ],
// //     });
// //     socket.on('data_response', (data) {
// //       print(data);
// //   // Process the received data
// //   List<dynamic> records = data;

// //   // Do something with the data
// // });
// //     // socket.on('my_custom_function', (data) {
// //     //   // Process the received product data
// //     //   List<dynamic> products = data;
// //     //   print(products.length);
// //     //   // Do something with the product data
// //     // });
// //     // print(socket.open());
// //     // print(socket.disconnected);
// //     // socket.on('connect', (_) {
// //     //   print('Connected to Odoo server');
// //     //   // Authenticate and get product data
// //     // });
// //     // socket.on('disconnect', (_) {
// //     //   print('Disconnected from Odoo server');
// //     //   // Close the connection
// //     //   socket.close();
// //     // });
// //   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
import 'package:hotel_grand_capitol/Screen/DashboardScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Model/UserModel.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BookedRoomModelAdapter());
  await Hive.openBox<UserModel>('betaUserBox');
  await Hive.openBox<BookedRoomModel>('betaBookedRoomBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}



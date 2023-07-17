import 'dart:async';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/screen/dashboard/dashboard_screen.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

final AuthController authController = Get.put(AuthController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  await Upgrader.clearSavedSettings();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Akij Takaful',
      debugShowCheckedModeBanner: false,
      theme: authController.theme.value,
      home: UpgradeAlert(child: const DashboardScreen()),
    );
  }
}

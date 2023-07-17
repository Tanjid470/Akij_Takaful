import 'dart:io';

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() => Scaffold(
          extendBody: true,
          body: authController.pages[authController.currentTab.value],
          bottomNavigationBar: SizedBox(
            height: Platform.isAndroid
                ? kBottomNavigationBarHeight
                : kBottomNavigationBarHeight + 40,
            child: BottomNavigationBar(
              elevation: 0,
              iconSize: 20,
              backgroundColor: AppColors.bgCol,
              selectedIconTheme:
                  const IconThemeData(color: Colors.white, size: 23),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[400],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: authController.onItemTapped,
              currentIndex: authController.currentTab.value,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.location_on_outlined,
                    ),
                    label: "Location"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.contact_phone,
                    ),
                    label: "Contact"),
              ],
            ),
          ),
        ));
  }
}

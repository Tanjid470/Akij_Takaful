import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const BaseAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Obx(
      () => AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.title,
        ),
        actions: <Widget>[
          authController.loggedIn.value
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      authController.onLogoutPressed();
                    },
                    child: SvgPicture.asset(
                      AppAsset.logout,
                      color: Colors.white,
                    ),
                  ))
              : Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: SvgPicture.asset(
                      AppAsset.login,
                      color: Colors.white,
                    ),
                  )),
        ],
        centerTitle: true,
        elevation: 0.00,
        backgroundColor: AppColors.bgCol,
        iconTheme: const IconThemeData(size: 28),
      ),
    );
  }
}

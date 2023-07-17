import 'dart:math' as math;

import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/src/view/components/navbar/navbar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/view/screen/auth/login/center_widget/center_widget.dart';
import 'package:akij_login_app/src/view/screen/auth/login/component/login_content.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -30 * math.pi / 180,
      child: Container(
        width: 0.9 * screenWidth,
        height: 0.9 * screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(125),
            gradient: const LinearGradient(
                begin: Alignment(-2.1, -0.6),
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00b0e599),
                  Color(0xB3759865),
                ])),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.2 * screenWidth,
      height: 1.2 * screenWidth,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment(0.6, -1.1),
              end: Alignment(0.7, 0.8),
              colors: [
                Color(0xDB81b26c),
                Color(0x00759875),
              ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: AppColors.bgCol,
        appBar: const BaseAppBar(
          title: '',
        ),
        drawer: const Navbar(),
        body: Stack(
          children: [
            Positioned(
              top: -100,
              left: -40,
              child: topWidget(screenSize.width),
            ),
            Positioned(
                bottom: -180, left: -60, child: bottomWidget(screenSize.width)),
            CenterWidget(size: screenSize),
            const LoginContent(),
          ],
        ),
      ),
    );
  }
}

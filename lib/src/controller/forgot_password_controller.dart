import 'dart:convert';

import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/auth/password_reset_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:akij_login_app/src/view/screen/auth/login/forgot_password/otp_forgot_password.dart';
import 'package:akij_login_app/src/view/screen/auth/login/forgot_password/reset_password_screen.dart';
import 'package:akij_login_app/src/view/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  final authController = Get.find<AuthController>();

  final codeEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  String pin1 = '';
  String pin2 = '';
  String pin3 = '';
  String pin4 = '';
  String pin5 = '';
  String pin6 = '';
  String totalPin = '';
  RxString myUser = ''.obs;
  RxBool isLoading = false.obs;

  List<String> userTypeList = [
    'PolicyHolder',
    'Producer',
    'Group',
    'Admin',
  ];
  Rx<String?> myUserType = Rx<String?>(null);

  void onChangedUserType(String value) => myUserType.value = value;

  checkUserType() {
    switch (myUserType.value) {
      case "Admin":
        myUser.value = "Administrator";
        break;
      case "PolicyHolder":
        myUser.value = "PH";
        break;
      case "Producer":
        myUser.value = "Agent";
        break;
    }
  }

  Future<void> getForgotPassOtp() async {
    try {
      checkUserType();

      isLoading(true);

      var response = await http.post(
        Uri.parse('${authController.baseUrl}v1/Apps/PasswordRecovery'),
        headers: {
          'token': authController.getToken(),
        },
        body: {
          "UserType": myUser.value,
          "UserId": codeEditingController.text,
          "Otp": "",
          "Password": "",
          "ConfirmPassword": ""
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getForgotPassOtp();
      }

      final passwordResetModels = passwordResetModelsFromJson(response.body);

      isLoading(false);
      // if success
      if (passwordResetModels[1].value == 'success') {
        Get.to(() => OtpForgotPassword(
            code: codeEditingController.text,
            userType: myUser.value,
            msg: passwordResetModels[0].value.toString()));
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            passwordResetModels[0].value,
            "Cancel",
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "Please Contact Admin",
          "Try Again",
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp() async {
    totalPin = "$pin1$pin2$pin3$pin4$pin5$pin6".trim();

    isLoading(true);

    var response = await http.post(
      Uri.parse('${authController.baseUrl}v1/Apps/MatchOtp'),
      headers: {
        'token': authController.getToken(),
      },
      body: {
        "UserType": myUser.value,
        "UserId": codeEditingController.text,
        "Otp": totalPin,
        "Password": "",
        "ConfirmPassword": ""
      },
    );

    if (response.statusCode == 401) {
      await authController.refreshToken();
      verifyOtp();
    }

    var data = json.decode(response.body);

    isLoading(false);
    // if yes
    if (data['Message'] == 'success') {
      Get.to(() => const ResetPasswordScreen());
    } else {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "OTP does not match!",
          "Try Again",
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    }
  }

  Future<void> resetPassword() async {
    totalPin = "$pin1$pin2$pin3$pin4$pin5$pin6".trim();

    isLoading(true);

    var response = await http.post(
      Uri.parse('${authController.baseUrl}v1/Apps/SetNewPassword'),
      headers: {
        'token': authController.getToken(),
      },
      body: {
        "UserType": myUser.value,
        "UserId": codeEditingController.text,
        "Otp": totalPin,
        "Password": passwordEditingController.text,
        "ConfirmPassword": confirmPasswordEditingController.text
      },
    );

    if (response.statusCode == 401) {
      await authController.refreshToken();
      resetPassword();
    }

    var data = json.decode(response.body);

    isLoading(false);
    // if yes
    if (data == 'success') {
      clearAllVars();
      actionAlert('Success!', 'Password Reset Successfully', 'Log In',
          Icons.done_outline, Colors.green, const LoginScreen());
    } else {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "Something went wrong! Please try again",
          "Try Again",
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    }
    clearAllVars();
  }

  void clearAllVars() {
    pin1 = '';
    pin2 = '';
    pin3 = '';
    pin4 = '';
    pin5 = '';
    pin6 = '';
    totalPin = '';
    myUserType = Rx<String?>(null);
    codeEditingController.clear();
    passwordEditingController.clear();
    confirmPasswordEditingController.clear();
  }
}

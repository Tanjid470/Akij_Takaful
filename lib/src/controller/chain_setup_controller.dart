import 'dart:convert';

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/controller/business_report_controller.dart';
import 'package:akij_login_app/src/model/business/business_report_model.dart';
import 'package:akij_login_app/src/model/chain_setup/chain_setup_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChainSetupController extends GetxController {
  final authController = Get.find<AuthController>();
  final businessReportController = Get.put(BusinessReportController());

  var codeEditingController = TextEditingController();

  RxBool isDataLoading = false.obs;
  RxBool dataExists = false.obs;
  List<ChainSetupModel> chainSetupList = <ChainSetupModel>[].obs;
  List<BusinessReportModel> businessItems = <BusinessReportModel>[].obs;

  final List<Color> levelColors = [
    const Color(0xFF8AC7BD), // Level 1 - Light Aqua
    const Color(0xFF659A8F), // Level 2 - Light Greenish Teal
    const Color(0xFFB395C8), // Level 3 - Light Lavender
    const Color(0xFFA0C7C4), // Level 4 - Light Bluish Green
    const Color(0xFFD19393), // Level 5 - Light Coral
    const Color(0xFFC6D8A4), // Level 6 - Light Sage
    const Color(0xFF91BFD6), // Level 7 - Light Steel Blue
  ];

  getChainSetup(String code) async {
    try {
      isDataLoading(true);

      var response = await http.post(
        Uri.parse('${authController.baseUrl}v1/Apps/ChainSetup'),
        headers: {
          'token': authController.getToken(),
        },
        body: {"Code": code},
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getChainSetup(code);
      }

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        if (responseBody is List && responseBody.isEmpty) {
          AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
              "Nothing Found", "Cancel", Colors.red, Colors.red, Icons.close);
        } else {
          List<ChainSetupModel> newChainSetupList = List<ChainSetupModel>.from(
              json
                  .decode(response.body)
                  .map((x) => ChainSetupModel.fromJson(x)));

          chainSetupList.addAll(newChainSetupList);

          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            "Could not fetch list",
            "Try Again",
            Colors.blue,
            Colors.blue,
            Icons.details);
        throw Exception("Error");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error");
    } finally {
      isDataLoading(false);
    }
  }

  getBusiness(String code) async {
    try {
      AlertBoxBuilder.circularProgressAlertBox(
          Get.context as BuildContext, "Please Wait");

      var response = await http.post(
        Uri.parse("${authController.baseUrl}v1/Apps/BusinessReport"),
        headers: {
          'token': authController.getToken(),
        },
        body: {
          'BusinessMonthFrom':
              "${DateFormat('MMMM').format(DateTime.now())},${DateTime.now().year.toString()}",
          'BusinessMonthTo':
              "${DateFormat('MMMM').format(DateTime.now())},${DateTime.now().year.toString()}",
          'Year': DateTime.now().year.toString(),
          'CodeNo': code,
        },
      );

      Get.back();

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getBusiness(code);
      }

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data.isEmpty) {
          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Info",
              "No Data Yet!",
              "Try Later",
              Colors.blue,
              Colors.blue,
              Icons.redo_rounded);
        } else {
          List<BusinessReportModel> reportList = [];

          for (var report in data) {
            BusinessReportModel businessReport = BusinessReportModel(
              name: report['Name'],
              fPR: report['FPR'],
              def: report['Def'],
              firstYear: report['FirstYear'],
              renewal: report['Renewal'],
              total: report['Total'],
              target: report['Target'],
              targetAchivePercentage: report['TargetAchivePercentage'],
              businessMonth: report['BusinessMonth'],
            );

            reportList.add(businessReport);
          }
          businessItems.assignAll(reportList);

          String show = "";

          for (var item in businessItems) {
            show =
                "FPR: ${StringCurrencyFormatter().formatDouble(item.fPR!)} Tk\n"
                "Def: ${StringCurrencyFormatter().formatDouble(item.def!)} Tk\n"
                "First Year: ${StringCurrencyFormatter().formatDouble(item.firstYear!)} Tk\n"
                "Renewal: ${StringCurrencyFormatter().formatDouble(item.renewal!)} Tk\n"
                "Total: ${StringCurrencyFormatter().formatDouble(item.total!)} Tk\n"
                "Achieve: ${item.targetAchivePercentage}%";
          }

          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "${DateFormat('MMMM').format(DateTime.now())}, ${DateTime.now().year.toString()} Business",
              show,
              "Close",
              AppColors.bgCol,
              AppColors.bgCol,
              Icons.info_rounded);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            "Nothing Found",
            "Cancel",
            Colors.red,
            Colors.red,
            Icons.close_fullscreen_rounded);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  onClear() {
    chainSetupList = <ChainSetupModel>[].obs;
  }
}

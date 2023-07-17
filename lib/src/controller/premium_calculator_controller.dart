import 'dart:convert';

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/calculate_age.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/controller/products_controller.dart';
import 'package:akij_login_app/src/model/calculator/calculator_result_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PremiumCalculatorController extends GetxController {
  final authController = Get.find<AuthController>();
  final productsController = Get.put(ProductsController());

  var birthdateEditingController = TextEditingController();
  var sumEditingController = TextEditingController();

  var selectedBirthdate = ''.obs;
  var currentDate = DateTime.now().obs;
  Rxn<DateDuration> duration = Rxn<DateDuration>();

  void updateSelectedBirthdate(DateTime? date, var selectedDate) async {
    if (date != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);

      duration.value = AgeCalculator.age(DateTime.parse(formattedDate));

      if (duration.value!.years > 18) {
        selectedBirthdate.value = formattedDate;
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Information",
            "Age must be 18 or over!",
            'OK',
            Colors.yellow.shade600,
            Colors.yellow.shade600,
            Icons.info_rounded);
      }
    }
  }

  calculatePremium() async {
    if (sumEditingController.text.isEmpty) {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "Please enter a sum assured!",
          'OK',
          Colors.blue,
          Colors.blue,
          Icons.close_rounded);
    } else if (productsController.selectedTerm.value == null) {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "Please select a term!",
          'OK',
          Colors.blue,
          Colors.blue,
          Icons.close_rounded);
    } else if (productsController.selectedMode.value == null) {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "Please select a mode!",
          'OK',
          Colors.blue,
          Colors.blue,
          Icons.close_rounded);
    } else {
      try {
        final birthdate = DateTime.parse(selectedBirthdate.value);

        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/AkijWebsite/PostForPremium'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              "DateOfBirth":
                  "${birthdate.day.toString()}/${birthdate.month.toString()}/${birthdate.year.toString()}",
              "PlanNo": productsController.selectedproduct.value!.table,
              "Term": productsController.selectedTerm.value!.term,
              "Mode": productsController.selectedMode.value!.value,
              "SumAssured": sumEditingController.text,
              "ADDB": productsController.selectedExtra.value!.name == "ADDB"
                  ? "ADDB"
                  : "",
              "ADB": productsController.selectedExtra.value!.name == "ADB"
                  ? "ADB"
                  : ""
            });

        if (response.body.isEmpty || response.statusCode == 401) {
          await authController.refreshToken();
          calculatePremium();
        }

        final resultJson =
            CalculatorResultModel.fromJson(json.decode(response.body));

        var formatter = NumberFormat('#,##,###');

        String show =
            "Basic Premium: ${formatter.format(resultJson.basicBremium)} Tk\n"
            "AD&D Premium: ${formatter.format(resultJson.aDDBPremium)} Tk\n"
            "ADB Premium: ${formatter.format(resultJson.aDBPremium)} Tk\n\n"
            "Total Premium: ${formatter.format(resultJson.totalPremium)} Tk";

        if (response.statusCode == 200) {
          AlertBoxBuilder.alertBox(Get.context as BuildContext, "Result", show,
              "OK", AppColors.bgCol, AppColors.bgCol, Icons.check_rounded);
        } else {
          throw Exception(response.body);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  clearProductsList() {
    productsController.products.value = [];
    productsController.selectedproduct.value = null;

    clearDropDowns();
  }

  clearDropDowns() {
    productsController.terms.value = [];
    productsController.modes.value = [];
    productsController.extras.value = [];
    productsController.selectedTerm.value = null;
    productsController.selectedMode.value = null;
    productsController.selectedExtra.value = null;
    sumEditingController.clear();
  }
}

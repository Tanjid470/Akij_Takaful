import 'dart:convert';

import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/business/business_report_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:akij_login_app/src/view/screen/business_report/current/current_business_month.dart';
import 'package:akij_login_app/src/view/screen/business_report/current/current_business_year.dart';
import 'package:akij_login_app/src/view/screen/business_report/previous/previous_business_year.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class BusinessReportController extends GetxController {
  final authController = Get.find<AuthController>();

  final currentMonthEditingController = TextEditingController();
  final currentYearEditingController = TextEditingController();
  final previousYearEditingController = TextEditingController();

  String entry = "";
  RxBool dataLoading = false.obs;
  RxBool dataExist = false.obs;
  RxBool isFunctionCalled = false.obs;
  RxString name = "".obs;
  RxString year = "".obs;
  RxString month = "".obs;
  RxString ncp = "".obs;
  RxString def = "".obs;
  RxString fycp = "".obs;
  RxString renewal = "".obs;
  RxString total = "".obs;
  RxString target = "".obs;
  RxString achievePercent = "".obs;

  List currentBusinessMonthItems = [].obs;
  List<BusinessReportModel> currentBusinessYearItems =
      <BusinessReportModel>[].obs;
  List<BusinessReportModel> previousBusinessYearItems =
      <BusinessReportModel>[].obs;

  List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<String> prevYearList = generateYearList(DateTime.now().year);

  List<String> currYearList = [
    '${DateTime.now().year}',
  ];
  Rx<String?> myMonthFrom = Rx<String?>(null);
  Rx<String?> myMonthTo = Rx<String?>(null);
  Rx<String?> myPrevYear = Rx<String?>(null);
  Rx<String?> myCurrYear = Rx<String?>(null);

  void onChangedMonthFrom(String value) => myMonthFrom.value = value;
  void onChangedMonthTo(String value) => myMonthTo.value = value;
  void onChangedPrevYear(String value) => myPrevYear.value = value;
  void onChangedCurrYear(String value) => myCurrYear.value = value;

  @override
  void onClose() {
    dataLoading(false);
    dataExist(false);
    name.value = '';
    year.value = '';
    month.value = '';
    ncp.value = '';
    def.value = '';
    fycp.value = '';
    renewal.value = '';
    total.value = '';
    target.value = '';
    achievePercent.value = '';
    myMonthFrom = Rx<String?>(null);
    myMonthTo = Rx<String?>(null);
    myPrevYear = Rx<String?>(null);
    myCurrYear = Rx<String?>(null);
    currentMonthEditingController.clear();
    currentYearEditingController.clear();
    previousYearEditingController.clear();
    super.onClose();
  }

  final List<ItemInfo> items = [
    ItemInfo(
        title: "Previous Business Year",
        icon: Icons.calendar_view_month,
        path: const PreviousBusinessYear()),
    ItemInfo(
        title: "Current Business Month",
        icon: Icons.business_center_rounded,
        path: const CurrentBusinessMonth()),
    ItemInfo(
        title: "Current Business Year",
        icon: Icons.admin_panel_settings,
        path: const CurrentBusinessYear()),
  ];

  Future<void> getCurrentMonthBusinessReport() async {
    try {
      if (currentMonthEditingController.text.isNotEmpty) {
        entry = currentMonthEditingController.text;
      } else {
        entry = authController.getPolicyNo();
      }
      dataLoading(true);
      var response = await http.get(
        Uri.parse(
            'https://www.atlplc.com/api/GetProducerCurrentBusiness?username=$entry'),
      );
      var data = json.decode(response.body);

      if (data['result'] == null || data['result'].length == 0) {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            "Nothing Found",
            "Cancel",
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      } else {
        data = data['result'][0];

        currentBusinessMonthItems = [
          MonthInfo(
            "Name",
            data['Name'].toString(),
          ),
          MonthInfo("NCP",
              "${AppAsset.taka}${StringCurrencyFormatter().format(data['FPR'].toString())}"),
          MonthInfo("Deff Premium",
              "${AppAsset.taka}${StringCurrencyFormatter().format(data['Def'].toString())}"),
          MonthInfo("FYCP",
              "${AppAsset.taka}${StringCurrencyFormatter().format(data['FirstYear'].toString())}"),
          MonthInfo("Renewal",
              "${AppAsset.taka}${StringCurrencyFormatter().format(data['Renewal'].toString())}"),
          MonthInfo("Total",
              "${AppAsset.taka}${StringCurrencyFormatter().format(data['Total'].toString())}"),
          MonthInfo("Target",
              "${AppAsset.taka}${StringCurrencyFormatter().format(data['Target'].toString())}"),
          MonthInfo(
            "Achieve Percentage",
            "${data['TargetAchivePercentage'].toString()}%",
          ),
        ];
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      dataLoading(false);
    }
  }

  dynamic prevYearReportState(List<BusinessReportModel> list) {
    previousBusinessYearItems = list;
  }

  Future<void> getPreviousYearBusinessReport() async {
    try {
      if (previousYearEditingController.text.isEmpty) {
        entry = authController.getPolicyNo();
      } else if (previousYearEditingController.text.isNotEmpty) {
        entry = previousYearEditingController.text;
      }
      myMonthFrom.value ??= "January";
      myMonthTo.value ??= "December";
      myPrevYear.value ??= (DateTime.now().year - 1).toString();

      dataLoading(true);

      var response = await http.post(
        Uri.parse("${authController.baseUrl}v1/Apps/BusinessReport"),
        headers: {
          'token': authController.getToken(),
        },
        body: {
          'BusinessMonthFrom': '$myMonthFrom,${myPrevYear.toString()}',
          'BusinessMonthTo': '$myMonthTo,${myPrevYear.toString()}',
          'Year': myPrevYear.toString(),
          'CodeNo': entry,
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getPreviousYearBusinessReport();
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
              Icons.details);
        } else {
          name.value = data[0]["Name"];
          year.value =
              RegExp(r'\d{4}').stringMatch(data[0]["BusinessMonth"]).toString();

          dataExist(true);

          List<BusinessReportModel> reportList = [];

          for (var report in data) {
            BusinessReportModel reportModel = BusinessReportModel(
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

            reportList.add(reportModel);
          }
          previousBusinessYearItems.assignAll(reportList);
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
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      dataLoading(false);
    }
  }

  dynamic currYearReportState(List<BusinessReportModel> list) {
    currentBusinessYearItems = list;
  }

  Future<void> getCurrentYearBusinessReport() async {
    try {
      if (currentYearEditingController.text.isEmpty) {
        entry = authController.getPolicyNo();
      } else if (currentYearEditingController.text.isNotEmpty) {
        entry = currentYearEditingController.text;
      }
      myMonthFrom.value ??= "January";
      myMonthTo.value ??= "December";
      myCurrYear.value ??= DateTime.now().year.toString();

      dataLoading(true);

      var response = await http.post(
        Uri.parse("${authController.baseUrl}v1/Apps/BusinessReport"),
        headers: {
          'token': authController.getToken(),
        },
        body: {
          'BusinessMonthFrom': '$myMonthFrom,${myCurrYear.toString()}',
          'BusinessMonthTo': '$myMonthTo,${myCurrYear.toString()}',
          'Year': myCurrYear.toString(),
          'CodeNo': entry,
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getCurrentYearBusinessReport();
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
          name.value = data[0]["Name"];
          year.value =
              RegExp(r'\d{4}').stringMatch(data[0]["BusinessMonth"]).toString();

          dataExist(true);

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
          currentBusinessYearItems.assignAll(reportList);
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
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      dataLoading(false);
    }
  }
}

List<String> generateYearList(int currentYear) {
  List<String> yearList = [];

  for (int year = currentYear - 1; year >= 2021; year--) {
    yearList.add(year.toString());
  }

  return yearList;
}

class ItemInfo {
  final String title;
  final IconData icon;
  final Widget path;

  ItemInfo({
    required this.title,
    required this.icon,
    required this.path,
  });
}

class MonthInfo {
  final String title;
  final String count;

  MonthInfo(
    this.title,
    this.count,
  );
}

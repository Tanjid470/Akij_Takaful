import 'dart:convert';
import 'dart:io';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/office/office_model.dart';
import 'package:akij_login_app/src/model/policy/policy_info_model.dart';
import 'package:akij_login_app/src/model/policy/policy_list_details_model.dart';
import 'package:akij_login_app/src/model/policy/policy_list_model.dart';
import 'package:akij_login_app/src/model/policy/policy_model.dart';
import 'package:akij_login_app/src/view/screen/online_payment/submission_screen.dart';
import 'package:akij_login_app/src/view/screen/policy_list/menus/branch_wise.dart';
import 'package:akij_login_app/src/view/screen/policy_list/menus/code_wise.dart';
import 'package:akij_login_app/src/view/screen/policy_list/menus/due_date_wise.dart';
import 'package:akij_login_app/src/view/screen/policy_list/menus/month_wise.dart';
import 'package:akij_login_app/src/view/screen/policy_list/menus/plan_wise.dart';
import 'package:akij_login_app/src/view/screen/policy_list/menus/policy_wise.dart';
import 'package:akij_login_app/src/view/screen/policy_statement/component/policy_statement_pdf_export.dart.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class PolicyController extends GetxController {
  final authController = Get.find<AuthController>();

  late PolicyInfoModel policyInfoModel;
  late PolicyListModel policyListModel;
  late PolicyModel policyModel;

  String entry = "";
  RxString name = "".obs;
  RxString policyNo = "".obs;
  RxString sumAssured = "".obs;
  RxString totalPremium = "".obs;
  RxString mode = "".obs;
  RxString riskDate = "".obs;
  RxString maturity = "".obs;
  RxString nextPayment = "".obs;
  RxString status = "".obs;
  RxString totalPaid = "".obs;
  RxList policyList = [].obs;
  var offices = <Office>[].obs;
  List<PolicyListDetailsModel> policyListDetails =
      <PolicyListDetailsModel>[].obs;

  Rx<Office?> selectedOffice = Rx<Office?>(null);

  RxString customerID = "".obs;
  RxString customerName = "".obs;
  RxString dob = "".obs;
  RxString fatherName = "".obs;
  RxDouble amount = 0.0.obs;
  RxString sessionID = "".obs;

  var selectedNextDueDateStart = ''.obs;
  var selectedNextDueDateEnd = ''.obs;
  var selectedBusinessMonth = ''.obs;

  var isAllDataLoaded = false.obs;
  var isDataLoading = false.obs;
  var isDownloadFileLoading = false.obs;
  RxBool dataExists = false.obs;
  RxBool isFunctionCalled = false.obs;

  var policyEditingController = TextEditingController();
  var codeEditingController = TextEditingController();
  var branchEditingController = TextEditingController();
  var monthEditingController = TextEditingController();
  var startDateEditingController = TextEditingController();
  var endDateEditingController = TextEditingController();
  var planEditingController = TextEditingController();

  final menus = [
    MenuInfo(
      title: "Code Wise",
      icon: Icons.numbers_outlined,
      iconColor: Colors.pinkAccent.shade400,
      path: () => const CodeWise(),
    ),
    MenuInfo(
      title: "Branch Wise",
      icon: Icons.home_work_outlined,
      iconColor: Colors.blue.shade400,
      path: () => const BranchWise(),
    ),
    MenuInfo(
      title: "Month Wise",
      icon: Icons.calendar_month_outlined,
      iconColor: Colors.yellowAccent.shade700,
      path: () => const MonthWise(),
    ),
    MenuInfo(
      title: "Due Date Wise",
      icon: Icons.date_range,
      iconColor: Colors.blueGrey.shade600,
      path: () => const DueDateWise(),
    ),
    MenuInfo(
      title: "Policy No. Wise",
      icon: Icons.format_list_numbered_rounded,
      iconColor: Colors.brown.shade400,
      path: () => const PolicyWise(),
    ),
    MenuInfo(
      title: "Plan No. Wise",
      icon: Icons.production_quantity_limits,
      iconColor: Colors.deepPurple.shade600,
      path: () => const PlanWise(),
    )
  ];

  void callFunctionInitially(String page) {
    switch (page) {
      case "CodeWise":
        if (authController.getUserType() == 'Agent' &&
            !isFunctionCalled.value) {
          getpolicyListDetailsCodeWise(authController.getPolicyNo());
          isFunctionCalled(true);
        }
        break;
      case "BranchWise":
        if (authController.getUserType() == 'Agent' &&
            !isFunctionCalled.value) {
          Future.delayed(Duration.zero, () {
            getpolicyListDetailsBranchWise('AAA1001');
            isFunctionCalled(true);
          });
        }
        break;
      case "MonthWise":
        if (authController.getUserType() == 'Agent' &&
            !isFunctionCalled.value) {
          Future.delayed(Duration.zero, () {
            getpolicyListDetailsMonthWise(
                DateFormat('yyyy-MM-01').format(DateTime.now()),
                authController.getPolicyNo());
            isFunctionCalled(true);
          });
        }
        break;
      case "DueDateWise":
        if (authController.getUserType() == 'Agent' &&
            !isFunctionCalled.value) {
          Future.delayed(Duration.zero, () {
            getpolicyListDetailsDueDateWise(
                DateFormat('yyyy-MM-01').format(DateTime.now()),
                DateFormat('yyyy-MM-31').format(DateTime.now()),
                authController.getPolicyNo());
            isFunctionCalled(true);
          });
        }
        break;
      default:
    }
  }

  getPolicyInfo() async {
    if (policyEditingController.text.isNotEmpty) {
      try {
        AlertBoxBuilder.circularProgressAlertBox(
            Get.context as BuildContext, "Please Wait");

        var response = await http.get(
          Uri.parse(
              '${authController.policyUrl}GetPolicyInfo?policyno=${policyEditingController.text}'),
        );

        var data = jsonDecode(response.body);

        Get.back();

        if (data['PolicyNo'] != null) {
          var infoList = jsonDecode(response.body);

          policyInfoModel = PolicyInfoModel.fromJson(infoList);
          name.value = policyInfoModel.name.toString();
          policyNo.value = policyInfoModel.policyNo.toString();
          sumAssured.value = policyInfoModel.sumassured.toString();
          totalPremium.value = policyInfoModel.totalPrem.toString();
          mode.value = policyInfoModel.mode.toString();
          riskDate.value = policyInfoModel.riskDate.toString();
          maturity.value = policyInfoModel.maturityDate.toString();
          nextPayment.value = policyInfoModel.nextDueDate.toString();
          status.value = policyInfoModel.status.toString();
          totalPaid.value = policyInfoModel.totalPaid.toString();
        } else {
          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Not Found!",
              "No policy found",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        }
      } catch (e) {
        throw Exception(e);
      }
    } else {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Blank Field",
          "Please enter a policy number",
          'OK',
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    }
  }

  getPolicyList() async {
    if (policyEditingController.text.isNotEmpty) {
      try {
        isDataLoading(true);
        var response = await http.get(
          Uri.parse(
              '${authController.policyUrl}GetPolicyOrList?policyno=${policyEditingController.text}'),
        );

        if (response.statusCode == 200) {
          policyList.value = json.decode(response.body);
          policyList.value = RxList<PolicyListModel>.from(policyList.map((i) {
            return PolicyListModel.fromJson(i);
          }));
        }
      } catch (e) {
        throw Exception(e);
      } finally {
        isAllDataLoaded(true);
        isDataLoading(false);
      }
    }
  }

  payPremium() async {
    if (policyEditingController.text.isNotEmpty) {
      try {
        AlertBoxBuilder.circularProgressAlertBox(
            Get.context as BuildContext, "Please Wait");

        var response = await http.get(
          Uri.parse(
              '${authController.baseUrl}v1/Apps/CheckId/${policyEditingController.text}'),
          headers: {
            'token': authController.getToken(),
            'content-type': 'application/json'
          },
        );

        if (response.statusCode == 401) {
          await authController.refreshToken();
          payPremium();
        }

        var data = json.decode(response.body);

        Get.back();

        if (data["errorCode"] == "0") {
          customerID.value = data['custId'];
          customerName.value = data['custName'];
          dob.value = data['dateOfBirth'];
          fatherName.value = data['fatherName'];
          amount.value = data['amount'];
          sessionID.value = data['sessionId'];

          Get.to(() => SubmissionScreen(
              policyNumber: policyEditingController.text,
              token: authController.getToken(),
              customerID: customerID.value,
              customerName: customerName.value,
              dob: dob.value,
              fatherName: fatherName.value,
              amount: amount.value,
              sessionID: sessionID.value));
        } else {
          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Error!",
              "No payment is due",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Blank Field!",
          "Blank Field Not Allowed",
          "OK",
          Colors.blue,
          Colors.blue,
          Icons.close);
    }
  }

  downloadPolicyStatement() async {
    try {
      policyModel = PolicyModel(
        customer: name.value,
        policyNo: policyNo.value,
        comDate: riskDate.value,
        sumAssured: sumAssured.value,
        issueDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        maturity: maturity.value,
        totalPremium: totalPremium.value,
        nextDate: nextPayment.value,
        mode: mode.value,
        status: status.value,
        basicPrem: policyInfoModel.basic.toString(),
        address: policyInfoModel.address.toString(),
        pDAB: policyInfoModel.pDABPrem.toString(),
        extra: policyInfoModel.extraPrem.toString(),
        tableAndTerm: policyInfoModel.tableAndTerm.toString(),
        suspense: policyInfoModel.suspance.toString(),
        insPaid: policyInfoModel.installmentNo.toString(),
        totalPaid: policyInfoModel.totalPaid.toString(),
        riskDate: policyInfoModel.riskDate.toString(),
        lastPremDate: policyInfoModel.lastPremiumdate.toString(),
        dOB: policyInfoModel.birthDate.toString(),
        age: policyInfoModel.age.toString(),
        gender: policyInfoModel.sex.toString(),
        occupation: policyInfoModel.occupation.toString(),
        nominee: policyInfoModel.nomineeNameAgeRelation.toString(),
        chainCode: policyInfoModel.chain.toString(),
        items: policyList
            .map(
              (data) => LineItem(
                instNo: data.ins.toString(),
                oRNo: data.oRNO.toString(),
                oRDate: data.oRDate.toString(),
                dueDate: data.dueDate.toString(),
                insPaid: data.insPaid.toString(),
                pRNo: data.pRNo.toString(),
                pRDate: data.pRDate.toString(),
                type: data.billType.toString(),
                oRAmount: data.amount.toString(),
              ),
            )
            .toList(),
      );

      final pdf = await makePdfForPolicyStatement(policyModel);
      openFile(pdf);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future openFile(File file) async {
    final url = file.path;
    await OpenFilex.open(url);
  }

  void updateSelectedStartDate(DateTime? date, var selectedDate) {
    if (date != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      selectedNextDueDateStart.value = formattedDate;
    }
  }

  void updateSelectedEndDate(DateTime? date, var selectedDate) {
    if (date != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      selectedNextDueDateEnd.value = formattedDate;
    }
  }

  void updateSelectedMonth(DateTime? date, var selectedDate) {
    if (date != null) {
      final formattedDate = DateFormat('yyyy-MM-01').format(date);
      // selectedDate.value = formattedDate;
      selectedBusinessMonth.value = formattedDate;
    }
  }

  getOfficeList() async {
    try {
      var response = await http.get(
        Uri.parse('${authController.baseUrl}v1/Apps/OfficeList'),
        headers: {
          'token': authController.getToken(),
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getOfficeList();
      }

      final officesJson = jsonDecode(response.body) as List<dynamic>;
      final offices = officesJson
          .map((officeJson) =>
              Office.fromJson(officeJson as Map<String, dynamic>))
          .toList();
      this.offices.assignAll(offices);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onOfficeSelected(Office office) {
    selectedOffice.value = office;
  }

  getpolicyListDetailsCodeWise(String code) async {
    try {
      if (code.isNotEmpty) {
        isDataLoading(true);

        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/PolicyListDetails'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              'Code': code,
              'BusinessMonth':
                  '${DateTime.now().year}-${DateTime.now().month}-01',
            });

        if (response.statusCode == 401) {
          await authController.refreshToken();
          getpolicyListDetailsCodeWise(code);
        }

        if (json.decode(response.body).isEmpty) {
          policyListDetails = <PolicyListDetailsModel>[].obs;
          dataExists(false);
          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Empty List",
              "No list found!",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        } else {
          policyListDetails = List<PolicyListDetailsModel>.from(json
              .decode(response.body)
              .map((x) => PolicyListDetailsModel.fromJson(x)));
          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty Code",
            "Please enter a code!",
            'OK',
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {
      isDataLoading(false);
    }
  }

  getpolicyListDetailsBranchWise(String branchCode) async {
    try {
      if (branchCode.isNotEmpty) {
        isDataLoading(true);

        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/PolicyListDetails'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              'Branchcode': branchCode,
              'BusinessMonth':
                  '${DateTime.now().year}-${DateTime.now().month}-01'
            });

        if (response.statusCode == 401) {
          await authController.refreshToken();
          getpolicyListDetailsCodeWise(branchCode);
        }

        if (json.decode(response.body).isEmpty) {
          selectedOffice = Rx<Office?>(null);
          policyListDetails = <PolicyListDetailsModel>[].obs;
          codeEditingController.clear();
          dataExists(false);

          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Empty List",
              "No list found in $branchCode",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        } else {
          policyListDetails = List<PolicyListDetailsModel>.from(json
              .decode(response.body)
              .map((x) => PolicyListDetailsModel.fromJson(x)));
          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty Branch",
            "Please enter a branch!",
            'OK',
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {
      isDataLoading(false);
    }
  }

  getpolicyListDetailsMonthWise(String month, String? code) async {
    try {
      if (month.isNotEmpty) {
        isDataLoading(true);
        final agentCode = code != '' ? code : authController.getPolicyNo();

        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/PolicyListDetails'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              'Code': agentCode,
              'BusinessMonth': month,
            });

        if (response.statusCode == 401) {
          await authController.refreshToken();
          getpolicyListDetailsMonthWise(month, code);
        }

        if (json.decode(response.body).isEmpty) {
          selectedBusinessMonth.value = '';
          policyListDetails = <PolicyListDetailsModel>[].obs;
          codeEditingController.clear();
          dataExists(false);

          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Empty List",
              "No list found!",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        } else {
          policyListDetails = List<PolicyListDetailsModel>.from(json
              .decode(response.body)
              .map((x) => PolicyListDetailsModel.fromJson(x)));
          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty Month",
            "Please enter a month!",
            'OK',
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {
      isDataLoading(false);
    }
  }

  getpolicyListDetailsDueDateWise(
      String startDate, String endDate, String? code) async {
    try {
      if (startDate.isNotEmpty && endDate.isNotEmpty) {
        isDataLoading(true);
        final agentCode = code != '' ? code : authController.getPolicyNo();

        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/PolicyListDetails'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              'Code': agentCode,
              'NextDueDateStart': startDate,
              'NextDueDateEnd': endDate,
            });

        if (response.statusCode == 401) {
          await authController.refreshToken();
          getpolicyListDetailsDueDateWise(startDate, endDate, code);
        }

        if (json.decode(response.body).isEmpty) {
          selectedNextDueDateStart.value = '';
          selectedNextDueDateEnd.value = '';
          policyListDetails = <PolicyListDetailsModel>[].obs;
          codeEditingController.clear();
          dataExists(false);

          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Empty List",
              "No list found!",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        } else {
          policyListDetails = List<PolicyListDetailsModel>.from(json
              .decode(response.body)
              .map((x) => PolicyListDetailsModel.fromJson(x)));
          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty Month",
            "Please enter a month!",
            'OK',
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {
      isDataLoading(false);
    }
  }

  getpolicyListDetailsPolicyWise(String policyNumber) async {
    try {
      if (policyNumber.isNotEmpty) {
        isDataLoading(true);

        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/PolicyListDetails'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              'Policyno': policyNumber
            });

        if (response.statusCode == 401) {
          await authController.refreshToken();
          getpolicyListDetailsPolicyWise(policyNumber);
        }

        if (json.decode(response.body).isEmpty) {
          policyListDetails = <PolicyListDetailsModel>[].obs;
          policyEditingController.clear();
          dataExists(false);

          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Empty List",
              "No list found for $policyNumber",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        } else {
          policyListDetails = List<PolicyListDetailsModel>.from(json
              .decode(response.body)
              .map((x) => PolicyListDetailsModel.fromJson(x)));
          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty Code",
            "Please enter a Policy No.",
            'OK',
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {
      isDataLoading(false);
    }
  }

  getpolicyListDetailsPlanWise(String planNo) async {
    try {
      if (planNo.isNotEmpty) {
        isDataLoading(true);

        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/PolicyListDetails'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              'Planno': planNo,
              'BusinessMonth':
                  '${DateTime.now().year}-${DateTime.now().month}-01'
            });

        if (response.statusCode == 401) {
          await authController.refreshToken();
          getpolicyListDetailsPlanWise(planNo);
        }

        if (json.decode(response.body).isEmpty) {
          policyListDetails = <PolicyListDetailsModel>[].obs;
          dataExists(false);

          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Empty List",
              "No list found for $planNo",
              'OK',
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        } else {
          policyListDetails = List<PolicyListDetailsModel>.from(json
              .decode(response.body)
              .map((x) => PolicyListDetailsModel.fromJson(x)));
          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty Plan",
            "Please Select a Plan No.",
            'OK',
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {
      isDataLoading(false);
    }
  }

  @override
  void onInit() async {
    await getOfficeList();
    super.onInit();
  }

  @override
  void onClose() {
    dataExists(false);
    isFunctionCalled(false);
    codeEditingController.clear();
    branchEditingController.clear();
    policyEditingController.clear();
    planEditingController.clear();
    policyListDetails = <PolicyListDetailsModel>[].obs;
    selectedBusinessMonth.value = "";
    selectedNextDueDateStart.value = "";
    selectedNextDueDateEnd.value = "";
    selectedOffice = Rx<Office?>(null);
    super.onClose();
  }
}

class MenuInfo {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget Function() path;

  MenuInfo({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.path,
  });
}

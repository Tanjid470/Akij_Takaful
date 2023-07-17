import 'dart:convert';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/controller/payment_controller.dart';
import 'package:akij_login_app/src/model/policy/proposal_List_model.dart';
import 'package:akij_login_app/src/model/products/product_list_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:akij_login_app/src/view/screen/online_payment/submission_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProposalController extends GetxController {
  final authController = Get.find<AuthController>();
  final paymentController = Get.put(PaymentController());

  final products = <ProductListModel>[].obs;
  Rx<ProductListModel?> selectedProduct = Rx<ProductListModel?>(null);

  RxString proposalNo = ''.obs;
  RxString entry = ''.obs;
  RxList<ProposalListModel> proposalsList = <ProposalListModel>[].obs;
  RxBool dataLoading = false.obs;
  RxBool initialScreen = true.obs;

  final tierEditingController = TextEditingController();
  final proposaltEditingController = TextEditingController();
  final codeEditingController = TextEditingController();
  final proNameEditingController = TextEditingController();
  final sumAssuredEditingController = TextEditingController();
  final premiumEditingController = TextEditingController();
  final mobileEditingController = TextEditingController();

  void getProductList() async {
    try {
      var response = await http.get(
        Uri.parse('${authController.baseUrl}v1/AkijWebsite/GetInsProduct'),
        headers: {
          'token': authController.getToken(),
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getProductList();
      }

      var productsJson = json.decode(response.body) as List<dynamic>;
      final products = productsJson
          .map((tierJson) =>
              ProductListModel.fromJson(tierJson as Map<String, dynamic>))
          .toList();
      this.products.assignAll(products);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onProductSelected(ProductListModel product) {
    selectedProduct.value = product;
  }

  Future<void> submitButton(BuildContext context) async {
    if (proposaltEditingController.text.isNotEmpty &&
        proNameEditingController.text.isNotEmpty &&
        tierEditingController.text.isNotEmpty &&
        sumAssuredEditingController.text.isNotEmpty &&
        selectedProduct.value.toString().isNotEmpty &&
        premiumEditingController.text.isNotEmpty &&
        mobileEditingController.text.isNotEmpty) {
      if (mobileEditingController.text.length != 11) {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            "Enter Valid Phone No",
            "Cancel",
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      } else {
        try {
          var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/ProposalEnlist'),
            headers: {
              'token': authController.getToken(),
            },
            body: {
              "ProposalNo": proposaltEditingController.text,
              "Tayer1": tierEditingController.text,
              "ProposalDate":
                  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
              "ProposersName": proNameEditingController.text,
              "sumassured": sumAssuredEditingController.text,
              "planno": selectedProduct.value?.table.toString(),
              "TotalPremium": premiumEditingController.text,
              "MobileNo": mobileEditingController.text,
              "UserName": authController.getUsername().toString()
            },
          );

          if (response.statusCode == 401) {
            await authController.refreshToken();
            submitButton(Get.context as BuildContext);
          }

          var data = json.decode(response.body);

          if (data["errCode"] == "0") {
            AlertBoxBuilder.alertBox(
                Get.context as BuildContext,
                "Success",
                "Enlisted Successfully",
                "OK",
                Colors.green,
                Colors.green,
                Icons.check_rounded);

            tierEditingController.clear();
            proposaltEditingController.clear();
            proNameEditingController.clear();
            sumAssuredEditingController.clear();
            premiumEditingController.clear();
            mobileEditingController.clear();
            selectedProduct = Rx<ProductListModel?>(null);
          } else {
            AlertBoxBuilder.alertBox(
                Get.context as BuildContext,
                "Error",
                "Problem Occured",
                "Try Again",
                Colors.red,
                Colors.red,
                Icons.report_problem);
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    } else {
      AlertBoxBuilder.alertBox(
          context,
          "Blank Field",
          "Blank Field Not Allowed",
          "Close",
          Colors.blue,
          Colors.blue,
          Icons.info_rounded);
    }
  }

  Future<void> callForProposalList() async {
    try {
      initialScreen(false);
      if (codeEditingController.text.isEmpty) {
        entry.value = authController.getPolicyNo();
        proposalNo.value = "";
      } else if (codeEditingController.text.isNotEmpty) {
        entry.value = codeEditingController.text;
        proposalNo.value = proposaltEditingController.text;
      }
      dataLoading(true);

      var response = await http.post(
          Uri.parse('${authController.baseUrl}v1/Apps/ProposalList'),
          headers: {
            'token': authController.getToken()
          },
          body: {
            'userName': entry.value,
            'ProposalNumber': proposalNo.value,
          });

      if (response.statusCode == 401) {
        await authController.refreshToken();
        callForProposalList();
      }

      if (response.statusCode == 500) {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            "No List Found",
            "Try Again",
            Colors.blue,
            Colors.blue,
            Icons.error);

        initialScreen(true);
        dataLoading(false);
      }

      if (response.statusCode == 200) {
        var statusCode = json.decode(response.body)[0]['errCode'];

        if (statusCode == "0") {
          var data = json.decode(response.body)[0]['response'];

          initialScreen(false);
          dataLoading(false);

          List<ProposalListModel> proposals = [];

          for (var proposalInfo in data) {
            ProposalListModel proposal = ProposalListModel(
              proposalno: proposalInfo['Proposalno'],
              proposersName: proposalInfo['ProposersName'],
              comdate: proposalInfo['Comdate'],
              tayer1: proposalInfo['Tayer1'],
              uNDRequirment: proposalInfo['UNDRequirment'],
              medicalDrDecission: proposalInfo['MedicalDrDecission'],
              underwritingDecission: proposalInfo['UnderwritingDecission'],
              logInUserName: proposalInfo['LogInUserName'],
              status: proposalInfo['Status'],
            );

            proposals.add(proposal);
          }
          proposalsList.assignAll(proposals);
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
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error");
    }
  }

  Future<void> payProposal(BuildContext context, String proposalNo) async {
    try {
      AlertBoxBuilder.circularProgressAlertBox(
          Get.context as BuildContext, "Please Wait");

      var response = await http.get(
        Uri.parse('${authController.baseUrl}v1/Apps/CheckPro/$proposalNo'),
        headers: {
          'token': authController.getToken(),
          'content-type': 'application/json'
        },
      );

      Get.back();

      if (response.statusCode == 401) {
        await authController.refreshToken();
        payProposal(Get.context as BuildContext, proposalNo.toString());
      }

      var data = json.decode(response.body);

      if (data["errorCode"] == "0") {
        paymentController.customerID.value = data['custId'];
        paymentController.customerName.value = data['custName'];
        paymentController.dob.value = data['dateOfBirth'];
        paymentController.fatherName.value = data['fatherName'];
        paymentController.amount.value = data['amount'];
        paymentController.sessionID.value = data['sessionId'];

        Get.to(
          () => SubmissionScreen(
            policyNumber: proposalNo.toString(),
            token: authController.getToken(),
            customerID: paymentController.customerID.value,
            customerName: paymentController.customerName.value,
            dob: paymentController.dob.value,
            fatherName: paymentController.fatherName.value,
            amount: paymentController.amount.value,
            sessionID: paymentController.sessionID.value,
          ),
        );
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            "Payment Not Allowed",
            "OK ",
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    getProductList();
    if (authController.getUserType() == "Agent") {
      callForProposalList();
    }
    super.onInit();
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/payment/online_payment_invoice.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:akij_login_app/src/view/screen/online_payment/component/online_payment_pdf_export.dart';
import 'package:akij_login_app/src/view/screen/online_payment/online_payment_screen.dart';
import 'package:akij_login_app/src/view/screen/online_payment/payment_slip_screen.dart';
import 'package:akij_login_app/src/view/screen/online_payment/submission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';

class PaymentController extends GetxController {
  final authController = Get.find<AuthController>();

  late OnlinePaymentInvoiceModel onlinePaymentInvoiceModel;

  RxString customerID = "".obs;
  RxString customerName = "".obs;
  RxString dob = "".obs;
  RxString fatherName = "".obs;
  RxDouble amount = 0.0.obs;
  RxString sessionID = "".obs;

  List<String> typeList = ['Select Payment Type', 'Recurrent', 'New'];
  final myType = 'Select Payment Type'.obs;

  var policyNoEditingController = TextEditingController();

  void onChangedType(String value) => myType.value = value;

  void checkPolicy() async {
    if (policyNoEditingController.text.isNotEmpty && myType.value.isNotEmpty) {
      if (myType.value == 'Recurrent') {
        try {
          AlertBoxBuilder.circularProgressAlertBox(
              Get.context as BuildContext, "Please Wait");

          var response = await http.get(
            Uri.parse(
                '${authController.baseUrl}v1/Apps/CheckId/${policyNoEditingController.text}'),
            headers: {
              'token': authController.getToken(),
              'content-type': 'application/json'
            },
          );

          Get.back();

          if (response.statusCode == 401) {
            await authController.refreshToken();
            checkPolicy();
          }

          var data = json.decode(response.body);

          if (data["errorCode"] == "0") {
            customerID.value = data['custId'];
            customerName.value = data['custName'];
            dob.value = data['dateOfBirth'];
            fatherName.value = data['fatherName'];
            amount.value = data['amount'];
            sessionID.value = data['sessionId'];

            Get.to(() => SubmissionScreen(
                policyNumber: policyNoEditingController.text,
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
                "Error",
                "No Information Found",
                "Try Again",
                Colors.red,
                Colors.red,
                Icons.close_rounded);
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      } else if (myType.value == 'New') {
        try {
          AlertBoxBuilder.circularProgressAlertBox(
              Get.context as BuildContext, "Please Wait");

          var response = await http.get(
            Uri.parse(
                '${authController.baseUrl}v1/Apps/CheckPro/${policyNoEditingController.text}'),
            headers: {
              'token': authController.getToken(),
              'content-type': 'application/json'
            },
          );

          Get.back();

          if (response.statusCode == 401) {
            await authController.refreshToken();
            checkPolicy();
          }

          var data = json.decode(response.body);

          if (data["errorCode"] == "0") {
            customerID.value = data['custId'];
            customerName.value = data['custName'];
            dob.value = data['dateOfBirth'];
            fatherName.value = data['fatherName'];
            amount.value = data['amount'];
            sessionID.value = data['sessionId'];

            Get.to(() => SubmissionScreen(
                policyNumber: policyNoEditingController.text,
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
                "Error",
                "No Information Found",
                "Try Again",
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
            "Payment Type",
            "Please Select a Payment Type",
            "Try Again",
            Colors.red,
            Colors.red,
            Icons.info_rounded);
      }
    } else {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Blank Field",
          "Blank Field Not Allowed",
          "Cancel",
          Colors.blue,
          Colors.blue,
          Icons.info_rounded);
    }
  }

  Future<void> payWithSSLCommerz(
      String policyNumber,
      String token,
      String customerID,
      String customerName,
      String dob,
      String fatherName,
      double amount,
      String sessionID) async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        currency: SSLCurrencyType.BDT,
        product_category: "",
        sdkType: SSLCSdkType.LIVE,
        store_id: "akijtakafullifecombdlive",
        store_passwd: "635111169CDAC62501",
        total_amount: amount,
        tran_id: sessionID,
      ),
    );

    sslcommerz.addCustomerInfoInitializer(
      customerInfoInitializer: SSLCCustomerInfoInitializer(
        customerState: "Dhaka",
        customerName: customerName,
        customerEmail: "",
        customerAddress1: "",
        customerCity: "Dhaka",
        customerPostCode: "1200",
        customerCountry: "Bangladesh",
        customerPhone: "",
      ),
    );

    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        showDialog<String>(
            context: Get.context as BuildContext,
            builder: (BuildContext context) => AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.cancel_rounded,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Failed',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text(
                        "Transaction Failed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(AppColors.bgCol),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)))),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OnlinePaymentScreen(),
                      )),
                      child: const Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ));
      } else {
        var response1 = await http.post(
          Uri.parse('${authController.baseUrl}v1/Apps/PostPayment'),
          headers: {'token': token},
          body: {
            "amount": result.amount,
            "sessionId": sessionID,
            "branchName": "",
            "transactionCode": result.cardNo,
            "custId": customerID
          },
        );

        var data = json.decode(response1.body);
        if (data['errorCode'] == "0") {
          var response2 = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/VerifyPayment'),
            headers: {
              'token': token,
            },
            body: {
              "sessionId": sessionID,
              "transactionCode": result.cardNo,
              "custId": customerID,
              "Amount": result.amount
            },
          );

          var response2data = json.decode(response2.body);

          if (response2data['errorCode'] == "0") {
            showDialog<String>(
                context: Get.context as BuildContext,
                builder: (BuildContext context) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Result',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Transaction is ${result.status} and Amount is ${result.amount} BDT",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  AppColors.bgCol),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)))),
                          onPressed: () => Get.to(
                            () => PaymentSlipScreen(
                              policyNumber: policyNumber,
                              custID: customerID,
                              custName: customerName,
                              paidAmount: result.amount,
                              transDate: result.tranDate,
                              bankGateway: result.cardType,
                              status: result.status,
                              transID: result.cardNo,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ));
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Cancelled",
          "Transaction Cancelled",
          "OK",
          Colors.red,
          Colors.red,
          Icons.cancel_rounded);
    }
  }

  Future<void> payWithNagad() async {
    AlertBoxBuilder.alertBox(
        Get.context as BuildContext,
        "Error",
        "Will be available soon!",
        "Cancel",
        Colors.blueAccent,
        Colors.blue,
        Icons.error);
  }

  downloadPaymentSlip(
      String customer,
      String customerID,
      String address,
      String status,
      String transID,
      String transDate,
      String policyNo,
      String bankGate,
      String paidAmount) async {
    onlinePaymentInvoiceModel = OnlinePaymentInvoiceModel(
      customer: customer,
      customerID: customerID,
      address: '',
      status: status,
      transID: transID,
      transDate: transDate,
      policyNo: policyNo,
      bankGate: bankGate,
      items: [
        LineItem(policyNo, double.parse(paidAmount), status),
      ],
    );

    final pdf = await makePdfForOnlinePayment(onlinePaymentInvoiceModel);
    openFile(pdf);
  }

  Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }

  @override
  void onInit() async {
    if (SharedPrefs().loggedIn == false) {
      await authController.getGuestToken();
    }
    super.onInit();
  }
}

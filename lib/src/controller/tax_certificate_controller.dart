import 'dart:convert';
import 'dart:io';
import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/policy/policy_info_model.dart';
import 'package:akij_login_app/src/model/tax/tax_cert.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:akij_login_app/src/view/screen/tax_certificate/component/tax_certificate_pdf_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';

class TaxCertificateController extends GetxController {
  final authController = Get.find<AuthController>();

  late PolicyInfoModel policyInfoModel;
  late TaxCertificate taxCertificate;

  RxBool downloadFileLoading = false.obs;
  final entry = "".obs;
  final value = NumberFormat("'#,##,###'");

  List<String> yearList = ['Select Financial Year', '2020-2021', '2021-2022'];
  final myYear = 'Select Financial Year'.obs;

  final policyNoEditingController = TextEditingController();
  final usernameEditingController = TextEditingController();

  void onChangedYear(String value) => myYear.value = value;

  Future<PolicyInfoModel> policyInfo(String userPolicyNo) async {
    var response = await http.get(
      Uri.parse(
          '${authController.policyUrl}GetPolicyInfo?policyno=$userPolicyNo'),
    );
    var infoList = jsonDecode(response.body);
    PolicyInfoModel infoContent = PolicyInfoModel.fromJson(infoList);

    return infoContent;
  }

  showCertificate() async {
    {
      if (policyNoEditingController.text.isEmpty) {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty",
            "Policy Number is empty",
            "Cancel",
            Colors.blue,
            Colors.blue,
            Icons.info);
      } else if (myYear.value == "Select Financial Year") {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty",
            "Please Select a Financial Year",
            "OK",
            Colors.blue,
            Colors.blue,
            Icons.info);
      } else {
        var info = await policyInfo(policyNoEditingController.text);
        entry.value = info.name.toString();
        String insuranceMoney = info.sumassured.toString();

        try {
          downloadFileLoading(true);
          var response = await http.post(
              Uri.parse(
                  '${authController.baseUrl}v1/Apps/TaxRebateCertificate'),
              headers: {
                'token': authController.getToken()
              },
              body: {
                "userName": entry.value,
                "policyNo": policyNoEditingController.text,
                "financialYear": myYear.value
              });

          if (response.statusCode == 401) {
            await authController.refreshToken();
            showCertificate();
          }

          var data = json.decode(response.body)[0];

          List certData = data['result'];

          if (data['result']?.length == 0) {
            AlertBoxBuilder.alertBox(
                Get.context as BuildContext,
                "Error",
                "Nothing Found",
                "Cancel",
                Colors.blue,
                Colors.blue,
                Icons.close_rounded);
          } else {
            downloadFileLoading(true);

            taxCertificate = TaxCertificate(
                customer: certData[0]['UserName'],
                policyNo: certData[0]['PolicyNo'],
                issueDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                year: myYear.value,
                insuranceMoney: insuranceMoney,
                items: certData
                    .map(
                      (data) => LineItem(
                        date: DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(data['DueDate'])),
                        amount: StringCurrencyFormatter()
                            .format((data['Amount'].toString())),
                      ),
                    )
                    .toList());

            final pdf = await makePdf(taxCertificate);
            openFile(pdf);
          }
        } catch (e) {
          debugPrint(e.toString());
        } finally {
          downloadFileLoading(false);
        }
      }
    }
  }

  Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
}

import 'package:akij_login_app/src/view/components/info_card.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/view/screen/online_payment/payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionScreen extends StatelessWidget {
  final String policyNumber;
  final String token;
  final String customerID;
  final String customerName;
  final String dob;
  final String fatherName;
  final double amount;
  final String sessionID;

  const SubmissionScreen({
    Key? key,
    required this.policyNumber,
    required this.token,
    required this.customerID,
    required this.customerName,
    required this.dob,
    required this.fatherName,
    required this.amount,
    required this.sessionID,
  }) : super(key: key);

  Future<void> nextButton(BuildContext context) async {
    Get.to(
      () => PaymentMethodScreen(
        policyNumber: policyNumber,
        token: token,
        customerID: customerID,
        customerName: customerName,
        dob: dob,
        fatherName: fatherName,
        amount: amount,
        sessionID: sessionID,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secBgColor,
      appBar: const BaseAppBar(title: 'Review Payment'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 10),
              width: double.infinity,
              child: Wrap(
                runSpacing: 7,
                children: [
                  InfoCard(title: 'ID', icon: AppAsset.id, data: customerID),
                  InfoCard(
                      title: 'Name', icon: AppAsset.person, data: customerName),
                  InfoCard(
                      title: 'Father\'s Name',
                      icon: AppAsset.father,
                      data: fatherName),
                  InfoCard(
                      title: 'Date of Birth', icon: AppAsset.date, data: dob),
                  InfoCard(
                      title: 'Amount',
                      icon: AppAsset.money,
                      data: "${AppAsset.taka} ${numberFormat.format(amount)}"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LargeButton(
          btnText: "Next",
          onPressed: () => {
                {nextButton(context)}
              }),
    );
  }
}

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/payment_controller.dart';
import 'package:akij_login_app/src/view/components/info_card.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/src/view/components/navbar/navbar.dart';
import 'package:akij_login_app/constants/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentSlipScreen extends StatelessWidget {
  final String custID;
  final String custName;
  final String? paidAmount;
  final String? transDate;
  final String? bankGateway;
  final String? status;
  final String? transID;
  final String? policyNumber;

  const PaymentSlipScreen({
    Key? key,
    required this.custID,
    required this.custName,
    required this.paidAmount,
    required this.transDate,
    required this.bankGateway,
    required this.status,
    required this.transID,
    required this.policyNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());

    return Scaffold(
      appBar: const BaseAppBar(title: 'Payment Success'),
      backgroundColor: AppColors.secBgColor,
      drawer: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 30, right: 20, bottom: 30),
              width: double.infinity,
              child: Wrap(
                runSpacing: 7,
                children: [
                  Column(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          AppAsset.success,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.sizedBoxHeight,
                      ),
                      Text(
                        "Payment Successful!",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: AppSize.sizedBoxHeight,
                      ),
                    ],
                  ),
                  InfoCard(
                      title: 'Customer \nName',
                      icon: AppAsset.person,
                      data: custName),
                  InfoCard(
                      title: 'Transaction \nDate',
                      icon: AppAsset.date,
                      data: transDate.toString()),
                  InfoCard(
                      title: 'Transaction \nID',
                      icon: AppAsset.id,
                      data: transID.toString()),
                  InfoCard(
                      title: 'Paid Amount',
                      icon: AppAsset.money,
                      data: "${AppAsset.taka} $paidAmount"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LargeButton(
          btnText: "Download Slip",
          onPressed: () async {
            paymentController.downloadPaymentSlip(
                custName,
                custID,
                '',
                status.toString(),
                transID.toString(),
                transDate.toString(),
                policyNumber.toString(),
                bankGateway.toString(),
                paidAmount.toString());
          }),
    );
  }
}

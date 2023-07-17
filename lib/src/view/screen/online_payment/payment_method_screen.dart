import 'package:akij_login_app/src/controller/payment_controller.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/src/view/components/payment_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatelessWidget {
  final String policyNumber;
  final String token;
  final String customerID;
  final String customerName;
  final String dob;
  final String fatherName;
  final double amount;
  final String sessionID;

  const PaymentMethodScreen({
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

  // Future<void> paySSlCommerz(BuildContext context) async {
  //   Sslcommerz sslcommerz = Sslcommerz(
  //     initializer: SSLCommerzInitialization(
  //       currency: SSLCurrencyType.BDT,
  //       product_category: "",
  //       sdkType: SSLCSdkType.LIVE,
  //       store_id: "akijtakafullifecombdlive",
  //       store_passwd: "635111169CDAC62501",
  //       total_amount: amount,
  //       tran_id: sessionID,
  //     ),
  //   );

  //   sslcommerz.addCustomerInfoInitializer(
  //     customerInfoInitializer: SSLCCustomerInfoInitializer(
  //       customerState: "Dhaka",
  //       customerName: customerName,
  //       customerEmail: "",
  //       customerAddress1: "",
  //       customerCity: "Dhaka",
  //       customerPostCode: "1200",
  //       customerCountry: "Bangladesh",
  //       customerPhone: "",
  //     ),
  //   );

  //   try {
  //     SSLCTransactionInfoModel result = await sslcommerz.payNow();

  //     if (result.status!.toLowerCase() == "failed") {
  //       showDialog<String>(
  //           context: context,
  //           builder: (BuildContext context) => AlertDialog(
  //                 title: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: const [
  //                     Icon(
  //                       Icons.cancel_rounded,
  //                       size: 20,
  //                       color: Colors.red,
  //                     ),
  //                     SizedBox(
  //                       width: 5,
  //                     ),
  //                     Text(
  //                       'Failed',
  //                       style: TextStyle(fontWeight: FontWeight.w600),
  //                     )
  //                   ],
  //                 ),
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: const <Widget>[
  //                     Text(
  //                       "Transaction Failed",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //                 actions: <Widget>[
  //                   TextButton(
  //                     style: ButtonStyle(
  //                         backgroundColor:
  //                             const MaterialStatePropertyAll(AppColors.bgCol),
  //                         shape: MaterialStatePropertyAll(
  //                             RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(50)))),
  //                     onPressed: () =>
  //                         Navigator.of(context).push(MaterialPageRoute(
  //                       builder: (context) => const OnlinePaymentScreenOld(),
  //                     )),
  //                     child: const Center(
  //                       child: Text(
  //                         'OK',
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, color: Colors.white),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ));
  //     } else {
  //       var response1 = await http.post(
  //         Uri.parse('${Network.baseUrl}v1/Apps/PostPayment'),
  //         headers: {'token': token},
  //         body: {
  //           "amount": result.amount,
  //           "sessionId": sessionID,
  //           "branchName": "",
  //           "transactionCode": result.cardNo,
  //           "custId": customerID
  //         },
  //       );

  //       var data = json.decode(response1.body);
  //       if (data['errorCode'] == "0") {
  //         var response2 = await http.post(
  //           Uri.parse('${Network.baseUrl}v1/Apps/VerifyPayment'),
  //           headers: {
  //             'token': token,
  //           },
  //           body: {
  //             "sessionId": sessionID,
  //             "transactionCode": result.cardNo,
  //             "custId": customerID,
  //             "Amount": result.amount
  //           },
  //         );

  //         var response2data = json.decode(response2.body);

  //         if (response2data['errorCode'] == "0") {
  //           showDialog<String>(
  //               context: context,
  //               builder: (BuildContext context) => AlertDialog(
  //                     title: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: const [
  //                         Icon(
  //                           Icons.check_circle,
  //                           size: 20,
  //                           color: Colors.green,
  //                         ),
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           'Result',
  //                           style: TextStyle(fontWeight: FontWeight.w600),
  //                         )
  //                       ],
  //                     ),
  //                     content: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: <Widget>[
  //                         Text(
  //                           "Transaction is ${result.status} and Amount is ${result.amount} BDT",
  //                           textAlign: TextAlign.center,
  //                           style: const TextStyle(
  //                               fontWeight: FontWeight.bold, fontSize: 16),
  //                         ),
  //                       ],
  //                     ),
  //                     actions: <Widget>[
  //                       TextButton(
  //                         style: ButtonStyle(
  //                             backgroundColor: const MaterialStatePropertyAll(
  //                                 AppColors.bgCol),
  //                             shape: MaterialStatePropertyAll(
  //                                 RoundedRectangleBorder(
  //                                     borderRadius:
  //                                         BorderRadius.circular(50)))),
  //                         onPressed: () =>
  //                             Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (context) => PaymentSlip(
  //                             policyNumber: policyNumber,
  //                             custID: customerID,
  //                             custName: customerName,
  //                             paidAmount: result.amount,
  //                             transDate: result.tranDate,
  //                             bankGateway: result.cardType,
  //                             status: result.status,
  //                             transID: result.cardNo,
  //                           ),
  //                         )),
  //                         child: const Center(
  //                           child: Text(
  //                             'OK',
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.white),
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ));
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     AlertBoxBuilder.alertBox(context, "Cancelled", "Transaction Cancelled",
  //         "OK", Colors.red, Colors.red, Icons.cancel_rounded);
  //   }
  // }

  // Future<void> payNagad(BuildContext context) async {
  //   AlertBoxBuilder.alertBox(context, "Error", "Will be available soon!",
  //       "Cancel", Colors.blueAccent, Colors.blue, Icons.error);
  // }

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const BaseAppBar(title: 'Payment Method'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1,
                children: [
                  PaymentButton(
                    logo: AppAsset.nagad,
                    onPressed: () => {
                      {paymentController.payWithNagad()}
                    },
                  ),
                  PaymentButton(
                    logo: AppAsset.rocket,
                    onPressed: () => {
                      {paymentController.payWithNagad()}
                    },
                  ),
                  PaymentButton(
                    logo: AppAsset.bkash,
                    onPressed: () => {
                      {paymentController.payWithNagad()}
                    },
                  ),
                  PaymentButton(
                    logo: AppAsset.upay,
                    onPressed: () => {
                      {paymentController.payWithNagad()}
                    },
                  ),
                  PaymentButton(
                    title: "Others",
                    onPressed: () => {
                      paymentController.payWithSSLCommerz(
                          policyNumber,
                          token,
                          customerID,
                          customerName,
                          dob,
                          fatherName,
                          amount,
                          sessionID)
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

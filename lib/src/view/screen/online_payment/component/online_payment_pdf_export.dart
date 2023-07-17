import 'dart:io';

import 'package:akij_login_app/src/model/payment/online_payment_invoice.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<File> makePdfForOnlinePayment(
    OnlinePaymentInvoiceModel onlinePaymentInvoiceModel) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/company_logo.png'))
          .buffer
          .asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Akij Takaful Life Insurance PLC.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: PdfColors.green700,
                        )),
                    Container(height: 10),
                    Text(
                        "Paltan China Town ( 15th Floor), \nEast Tower, 67/1 Naya Paltan, \nVIP Road, Dhaka-1000"),
                    Container(height: 10),
                    Text("For assistance, please call 09604016761 / 16761"),
                  ],
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Padding(
              child: Text(
                "Acknowledgement Receipt",
                style: Theme.of(context).header1,
              ),
              padding: const EdgeInsets.all(10),
            ),
            Container(height: 20),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText(
                      'Transaction Date',
                    ),
                    PaddedText(
                      onlinePaymentInvoiceModel.transDate,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText('Number'),
                    PaddedText(
                      onlinePaymentInvoiceModel.customerID,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Account Name',
                    ),
                    PaddedText(
                      onlinePaymentInvoiceModel.customer,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Payment Status',
                    ),
                    PaddedText(
                      onlinePaymentInvoiceModel.status,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Transaction ID',
                    ),
                    PaddedText(
                      onlinePaymentInvoiceModel.transID,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText('Payment Gateway'),
                    PaddedText(
                      onlinePaymentInvoiceModel.bankGate,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total Amount Paid',
                    ),
                    PaddedText(
                        'Tk ${(onlinePaymentInvoiceModel.totalCost() * 1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Container(height: 100),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'This is a system generated document and does not require signature.'
                ' Any unauthorized use, disclosure, dissemination or copying of this document'
                ' is strictly prohibited and may be unlawful.',
                style: Theme.of(context).header5.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: PaddedText(
                  'All rights reserved by Akij Takaful Life Insurance PLC.'),
            ),
          ],
        );
      },
    ),
  );

  final bytes = await pdf.save();

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/Akij Takaful.pdf');

  await file.writeAsBytes(bytes);

  return file;
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );

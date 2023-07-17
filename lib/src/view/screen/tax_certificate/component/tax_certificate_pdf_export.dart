import 'dart:io';
import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/model/tax/tax_cert.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<File> makePdf(TaxCertificate taxCertificate) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/company_logo.png'))
          .buffer
          .asUint8List());
  pdf.addPage(
    MultiPage(
        build: (context) => [
              Column(
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
                          Text(
                              "For assistance, please call 09604016761 / 16761"),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(imageLogo),
                      )
                    ],
                  ),
                  Container(height: 10),
                  Divider(
                    height: 1,
                    borderStyle: BorderStyle.solid,
                  ),
                  Container(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Issue Date: ${taxCertificate.issueDate}"),
                        Text("Fiscal Year: ${taxCertificate.year}"),
                      ]),
                  Container(height: 20),
                  Padding(
                    child: Text(
                      "Premium Payment Certificate",
                      style: Theme.of(context).header1,
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(height: 20),
                  Text(
                    "This is to certify that ${taxCertificate.customer} is a respectful policy holder of Akij"
                    "Takaful Life Insurance PLC. His/Her policy number is ${taxCertificate.policyNo} and "
                    "policy amount TK ${StringCurrencyFormatter().format(taxCertificate.insuranceMoney)}. His/Her paid premium of ${taxCertificate.year}"
                    " fiscal year is down below:- ",
                    style: Theme.of(context).paragraphStyle,
                  ),
                  Container(height: 30),
                  buildInvoice(taxCertificate),
                  buildTotal(taxCertificate),
                  Container(height: 30),
                  Divider(
                    height: 1,
                    borderStyle: BorderStyle.dashed,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'This is a system generated document and does not require signature.'
                      ' Any unauthorized use, disclosure, dissemination or copying of this document'
                      ' is strictly prohibited and may be unlawful.',
                      style: Theme.of(context).paragraphStyle.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: paddedText(
                        'All rights reserved by Akij Takaful Life Insurance PLC.'),
                  ),
                ],
              )
            ]),
  );

  final bytes = await pdf.save();

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/Akij Takaful Tax Certificate.pdf');

  await file.writeAsBytes(bytes);

  return file;
}

Widget buildInvoice(TaxCertificate taxCertificate) {
  final headers = ['Payment Date', 'Paid Premium Amount'];

  final data = taxCertificate.items.map((item) {
    return [
      item.date,
      'TK ${item.amount}',
    ];
  }).toList();

  return Table.fromTextArray(
    headers: headers,
    data: data,
    headerStyle: TextStyle(fontWeight: FontWeight.bold),
    headerDecoration: const BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
    cellAlignments: {0: Alignment.center, 1: Alignment.center},
  );
}

Widget buildTotal(TaxCertificate taxCertificate) {
  final total = taxCertificate.items
      .map((item) => double.parse(item.amount.replaceAll(',', '')))
      .reduce((item1, item2) => item1 + item2);

  return Container(
    padding: const EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    child: Row(children: [
      Spacer(flex: 6),
      Expanded(
        flex: 4,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("TK ${StringCurrencyFormatter().formatDouble(total)}"),
                ],
              ),
            ),
          ],
        ),
      ),
      Spacer(flex: 3),
    ]),
  );
}

Widget paddedText(
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

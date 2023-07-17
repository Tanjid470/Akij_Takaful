import 'dart:io';

import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/model/policy/policy_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<File> makePdfForPolicyStatement(PolicyModel download) async {
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
                        Text("Print Date: ${download.issueDate}"),
                      ]),
                  Container(height: 20),
                  Padding(
                    child: Text(
                      "Policy Statement",
                      style: Theme.of(context).header1,
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(height: 20),
                  Table(
                    columnWidths: {
                      0: const FlexColumnWidth(2),
                      1: const FlexColumnWidth(3.5),
                      2: const FlexColumnWidth(2),
                      3: const FlexColumnWidth(2),
                      4: const FlexColumnWidth(2),
                      5: const FlexColumnWidth(3.5),
                    },
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      TableRow(
                        children: [
                          paddedText("Name", header: true),
                          paddedText(download.customer),
                          paddedText('Policy No', header: true),
                          paddedText(download.policyNo),
                          paddedText('Sum Assured', header: true),
                          paddedText(
                              "TK ${StringCurrencyFormatter().format(download.sumAssured)}")
                        ],
                      ),
                      TableRow(
                        children: [
                          paddedText('Total Premium', header: true),
                          paddedText(
                              "TK ${StringCurrencyFormatter().format(download.totalPremium)}"),
                          paddedText('Status', header: true),
                          paddedText(download.status),
                          paddedText('Basic Prem', header: true),
                          paddedText(
                              "TK ${StringCurrencyFormatter().format(download.totalPremium)}"),
                        ],
                      ),
                      TableRow(
                        children: [
                          paddedText('Address', header: true),
                          paddedText(download.address),
                          paddedText('Date of Birth', header: true),
                          paddedText(download.dOB),
                          paddedText('Age of Entry', header: true),
                          paddedText(download.age),
                        ],
                      ),
                      TableRow(
                        children: [
                          paddedText('Gender', header: true),
                          paddedText(
                              download.gender == '1' ? 'Male' : 'Female'),
                          paddedText('Occupation', header: true),
                          paddedText(download.occupation),
                          paddedText('Nominee', header: true),
                          paddedText(download.nominee),
                        ],
                      ),
                      TableRow(
                        children: [
                          paddedText('PDAB/DIAB', header: true),
                          paddedText(download.pDAB),
                          paddedText('Extra', header: true),
                          paddedText(download.extra),
                          paddedText('T,T & Mode', header: true),
                          paddedText(
                              '${download.tableAndTerm} - ${download.mode}'),
                        ],
                      ),
                      TableRow(
                        children: [
                          paddedText('Suspense', header: true),
                          paddedText(download.suspense),
                          paddedText('Inst. Paid', header: true),
                          paddedText(download.insPaid),
                          paddedText('Total Paid', header: true),
                          paddedText(
                              "TK ${StringCurrencyFormatter().format(download.totalPaid)}"),
                        ],
                      ),
                      TableRow(
                        children: [
                          paddedText('Com. Date', header: true),
                          paddedText(download.comDate),
                          paddedText('Maturity Date', header: true),
                          paddedText(download.maturity),
                          paddedText('Next Due Date', header: true),
                          paddedText(download.nextDate),
                        ],
                      ),
                      TableRow(
                        children: [
                          paddedText('Chain Code', header: true),
                          paddedText(download.chainCode),
                          paddedText('Last Prem Due Date', header: true),
                          paddedText(download.lastPremDate),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 40),
                  buildInvoice(download),
                  buildTotal(download),
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
  final file = File('${dir.path}/Akij Takaful Policy Statement.pdf');

  await file.writeAsBytes(bytes);

  return file;
}

Widget buildInvoice(PolicyModel download) {
  final headers = [
    'Inst. No',
    'OR No',
    'OR Date',
    'Due Date',
    'Inst. Paid',
    'PR No',
    'PR Date',
    'Amount',
    'Type'
  ];

  final data = download.items.map((item) {
    return [
      item.instNo,
      item.oRNo,
      item.oRDate,
      item.dueDate,
      item.insPaid,
      item.pRNo,
      item.pRDate,
      'TK ${StringCurrencyFormatter().format(item.oRAmount)}',
      item.type
    ];
  }).toList();

  return Table.fromTextArray(
    headers: headers,
    data: data,
    headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
    headerDecoration: const BoxDecoration(color: PdfColors.grey300),
    cellStyle: const TextStyle(fontSize: 8.0),
    cellHeight: 30,
    cellAlignments: {
      0: Alignment.center,
      1: Alignment.center,
      2: Alignment.center,
      3: Alignment.center,
      4: Alignment.center,
      5: Alignment.center,
    },
  );
}

Widget buildTotal(PolicyModel download) {
  final total = download.items
      .map((item) => double.parse(item.oRAmount.replaceAll(',', '')))
      .reduce((item1, item2) => item1 + item2);

  return Container(
    padding: const EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    child: Row(children: [
      Spacer(flex: 8),
      Expanded(
        flex: 8,
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
      Spacer(flex: 2),
    ]),
  );
}

Widget paddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
  final bool header = false,
}) =>
    Container(
        child: Padding(
      padding: const EdgeInsets.all(7),
      child: header
          ? Text(text,
              textAlign: align,
              textScaleFactor: 0.6,
              style: TextStyle(fontWeight: FontWeight.bold))
          : Text(
              text,
              textAlign: align,
              textScaleFactor: 0.6,
            ),
    ));

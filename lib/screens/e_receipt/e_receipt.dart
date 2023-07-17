import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';

class EReceipt extends StatefulWidget {
  const EReceipt({Key? key}) : super(key: key);

  @override
  State<EReceipt> createState() => _EReceiptState();
}

class _EReceiptState extends State<EReceipt> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(title: "E-Receipt"),
      body: Center(child: Text('Will be available at next update.')),
    );
  }
}

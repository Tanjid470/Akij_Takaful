import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';

class PremiumNoticeScreen extends StatefulWidget {
  const PremiumNoticeScreen({Key? key}) : super(key: key);

  @override
  State<PremiumNoticeScreen> createState() => _PremiumNoticeScreenState();
}

class _PremiumNoticeScreenState extends State<PremiumNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(title: "Premium Notice"),
      body: Center(child: Text('Will be available at next update.')),
    );
  }
}

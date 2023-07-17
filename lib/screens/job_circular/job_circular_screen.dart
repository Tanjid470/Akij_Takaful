import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';

class JobCircularScreen extends StatelessWidget {
  const JobCircularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar(title: 'Job Circular'),
      backgroundColor: Colors.white,
      body: Center(child: Text('Will be available at next update.')),
    );
  }
}

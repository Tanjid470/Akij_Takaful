import 'package:akij_login_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircularProgress extends StatefulWidget {
  const CustomCircularProgress({Key? key}) : super(key: key);

  @override
  State<CustomCircularProgress> createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress> {
  // String data = "";

  // Future getData() async {
  //   String dataIn = 'Please Try Again!';
  //   return dataIn;
  // }

  // callMe() async {
  //   await Future.delayed(const Duration(seconds: 10));
  //   if (!mounted) return;

  //   getData().then((value) => {
  //         setState(() {
  //           data = value;
  //         })
  //       });
  // }

  @override
  void initState() {
    super.initState();
    // callMe();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AppColors.secCol,
      strokeWidth: 5,
    ));
  }
}

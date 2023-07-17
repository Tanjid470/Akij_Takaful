import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  final String? type;
  final String email;
  final String phoneNo;
  final String code;
  final String password;
  final String msg;
  final String token;

  const OtpScreen({
    Key? key,
    required this.type,
    required this.email,
    required this.phoneNo,
    required this.code,
    required this.password,
    required this.msg,
    required this.token,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final authController = Get.find<AuthController>();

  bool isLoading = false;

  // late String pin1;
  // late String pin2;
  // late String pin3;
  // late String pin4;
  // late String pin5;
  // late String pin6;
  // late String totalPin;

  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late FocusNode pin5FocusNode;
  late FocusNode pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    super.dispose();
  }

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: 'OTP Verification'),
        body: SafeArea(
          child: isLoading
              ? const CustomCircularProgress()
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Column(
                        children: [
                          BuildTitleSection(
                              title: "OTP Verification",
                              subTitle: widget.msg,
                              align: CrossAxisAlignment.center),
                          SizedBox(height: size.height * 0.2),
                          Form(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.11,
                                  child: TextFormField(
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.04),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                    ),
                                    onChanged: (value) {
                                      authController.pin1 = value;
                                      nextField(
                                          value: value,
                                          focusNode: pin2FocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.11,
                                  child: TextFormField(
                                    focusNode: pin2FocusNode,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.04),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                    ),
                                    onChanged: (value) {
                                      authController.pin2 = value;
                                      nextField(
                                          value: value,
                                          focusNode: pin3FocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.11,
                                  child: TextFormField(
                                    focusNode: pin3FocusNode,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.04),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                    ),
                                    onChanged: (value) {
                                      authController.pin3 = value;
                                      nextField(
                                          value: value,
                                          focusNode: pin4FocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.11,
                                  child: TextFormField(
                                    focusNode: pin4FocusNode,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.04),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                    ),
                                    onChanged: (value) {
                                      authController.pin4 = value;
                                      nextField(
                                          value: value,
                                          focusNode: pin5FocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.11,
                                  child: TextFormField(
                                    focusNode: pin5FocusNode,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.04),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                    ),
                                    onChanged: (value) {
                                      authController.pin5 = value;
                                      nextField(
                                          value: value,
                                          focusNode: pin6FocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.11,
                                  child: TextFormField(
                                    focusNode: pin6FocusNode,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.04),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500)),
                                    ),
                                    onChanged: (value) {
                                      authController.pin6 = value;
                                      pin6FocusNode.unfocus();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: LargeButton(
            btnText: "Submit",
            onPressed: () => {
                  authController.registration(
                      context,
                      authController.myUserType.value,
                      widget.code,
                      widget.email,
                      widget.phoneNo,
                      widget.password)
                }),
      ),
    );
  }
}

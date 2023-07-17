import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/forgot_password_controller.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // final authController = Get.find<AuthController>();
  final forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: ''),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BuildTitleSection(
                  title: "Forgot Password?",
                  subTitle: "Please Fill Up to Reset Password",
                  align: CrossAxisAlignment.center),
              SizedBox(
                height: size.height * 0.03,
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width * 0.91,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.textFieldGrey,
                    borderRadius:
                        BorderRadius.circular(AppSize.textFieldBorderRadius),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSize.textFieldBorderRadius),
                            ),
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              itemHeight: 60.0,
                              isExpanded: true,
                              value: forgotPasswordController.myUserType.value,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select User Type',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  forgotPasswordController
                                      .onChangedUserType(value);
                                }
                              },
                              items: forgotPasswordController.userTypeList
                                  .map<DropdownMenuItem<String>>(
                                      (user) => DropdownMenuItem<String>(
                                            value: user,
                                            child: Text(user),
                                          ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                hintText: "Enter Code / Policy No",
                controller: forgotPasswordController.codeEditingController,
                icon: Icons.colorize_rounded,
                color: AppColors.textFieldGrey,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: LargeButton(
                    btnText: "Submit",
                    onPressed: () => {
                          {forgotPasswordController.getForgotPassOtp()}
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

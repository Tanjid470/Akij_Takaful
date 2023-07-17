import 'package:akij_login_app/src/controller/forgot_password_controller.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // final authController = Get.find<AuthController>();
  final forgotPasswordController = Get.find<ForgotPasswordController>();

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
                  title: "Reset Password",
                  subTitle: "Please Set New Password",
                  align: CrossAxisAlignment.center),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                hintText: "Enter New Password",
                controller: forgotPasswordController.passwordEditingController,
                icon: Icons.password,
                color: AppColors.textFieldGrey,
                password: true,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                hintText: "Confirm New Password",
                controller:
                    forgotPasswordController.confirmPasswordEditingController,
                icon: Icons.password,
                color: AppColors.textFieldGrey,
                password: true,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: LargeButton(
                    btnText: "Reset",
                    onPressed: () => {
                          {forgotPasswordController.resetPassword()}
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/view/screen/auth/login/forgot_password/forgot_password_screen.dart';
import 'package:akij_login_app/src/view/screen/auth/signup/signup_screen.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/screen/auth/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return SafeArea(
        child: authController.isLoading.value
            ? const CustomCircularProgress()
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.09,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          'Hello again, you\'ve been missed',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),

                      //  username text field
                      CustomTextField(
                        hintText: 'Code / Policy No',
                        controller: authController.usernameEditingController,
                        icon: Icons.person,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      //  password text field
                      CustomTextField(
                        hintText: 'Password',
                        controller: authController.passwordEditingController,
                        icon: Icons.lock,
                        password: true,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      //  password recovery
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ForgotPasswordScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.038,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),

                      //  Log In button
                      ButtonWidget(
                        hintText: 'Log In',
                        onTap: () {
                          authController.login(context);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),

                      //  bottom text
                      GestureDetector(
                        onTap: () => Get.to(() => const SignupScreen()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? Register",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.038,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/screen/auth/login/login_screen.dart';
import 'package:akij_login_app/src/view/screen/auth/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupContent extends StatefulWidget {
  const SignupContent({Key? key}) : super(key: key);

  @override
  State<SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<SignupContent> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Obx(
      (() => SafeArea(
            child: authController.isLoading.value
                ? const CustomCircularProgress()
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.width * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: Column(
                              children: [
                                Text(
                                  'Welcome to',
                                  style: TextStyle(
                                      fontSize: size.width * 0.07,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  'Akij Takaful Life Insurance PLC.',
                                  style: TextStyle(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),

                          //  user type dropdown
                          Obx(
                            () => Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: MediaQuery.of(context).size.width * 0.91,
                              height: MediaQuery.of(context).size.width * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(
                                    AppSize.textFieldBorderRadius),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          value:
                                              authController.myUserType.value,
                                          iconSize: 30,
                                          icon: (null),
                                          hint: const Text(
                                            'Select User Type',
                                          ),
                                          onChanged: (value) {
                                            if (value != null) {
                                              authController
                                                  .onChangedUserType(value);
                                            }
                                          },
                                          items: authController.userTypeList
                                              .map<DropdownMenuItem<String>>(
                                                  (user) =>
                                                      DropdownMenuItem<String>(
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

                          //  email text field
                          CustomTextField(
                            hintText: 'Email',
                            controller: authController.emailEditingController,
                            icon: Icons.lock,
                            password: false,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          //  phone no text field
                          CustomTextField(
                            hintText: 'Phone Number',
                            controller: authController.phoneEditingController,
                            icon: Icons.phone,
                            isNum: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          //  code / policy text field
                          CustomTextField(
                            hintText: 'Code / Policy Number',
                            controller: authController.codeEditingController,
                            icon: Icons.numbers_rounded,
                            password: false,
                            isNum: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          //  password text field
                          CustomTextField(
                            hintText: 'Password',
                            controller:
                                authController.passwordEditingController,
                            icon: Icons.lock,
                            password: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          //  confirm password text field
                          CustomTextField(
                            hintText: 'Confirm Password',
                            controller:
                                authController.confirmPasswordEditingController,
                            icon: Icons.lock,
                            password: true,
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),

                          //  Log In button
                          ButtonWidget(
                              hintText: "Sign Up",
                              onTap: () {
                                authController.signup(context);
                              }),
                          SizedBox(
                            height: size.height * 0.04,
                          ),

                          //  bottom text
                          GestureDetector(
                            onTap: () => Get.to(() => const LoginScreen()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? Log In",
                                  style: TextStyle(
                                      fontSize: size.width * 0.038,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}

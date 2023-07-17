// ignore_for_file: prefer_if_null_operators
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterProposal extends StatefulWidget {
  final TextEditingController codeController;
  final TextEditingController proposalNoController;
  final Function() function;

  const FilterProposal({
    Key? key,
    required this.codeController,
    required this.proposalNoController,
    required this.function,
  }) : super(key: key);

  @override
  State<FilterProposal> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterProposal> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: AppSize.textFieldSizedBoxHeight,
                ),
                CustomTextField(
                  hintText: 'Enter Code No',
                  controller: widget.codeController,
                  icon: Icons.code,
                  color: AppColors.textFieldGrey,
                ),
                const SizedBox(
                  height: AppSize.textFieldSizedBoxHeight,
                ),
                CustomTextField(
                  hintText: 'Enter Proposal No',
                  controller: widget.proposalNoController,
                  icon: Icons.edit_note_rounded,
                  color: AppColors.textFieldGrey,
                ),
                const SizedBox(
                  height: AppSize.textFieldSizedBoxHeight,
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: LargeButton(
                      btnText: "Search",
                      onPressed: () => {
                            {widget.function(), Get.back()}
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/payment_controller.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlinePaymentScreen extends StatelessWidget {
  const OnlinePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: 'Online Payment'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: "Policy / Proposal",
                controller: paymentController.policyNoEditingController,
                icon: Icons.policy_rounded,
                color: AppColors.textFieldGrey,
              ),
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  color: AppColors
                      .textFieldGrey, //background color of dropdown button

                  borderRadius:
                      BorderRadius.circular(AppSize.textFieldBorderRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(
                      (() => Expanded(
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  itemHeight: 50,
                                  isExpanded: true,
                                  value: paymentController.myType.value,
                                  iconSize: 30,
                                  icon: (null),
                                  hint: const Text('Select Payment Type'),
                                  onChanged: (newValue) {
                                    paymentController.onChangedType(newValue!);
                                  },
                                  items: paymentController.typeList.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: LargeButton(
                    btnText: "Next",
                    onPressed: () => paymentController.checkPolicy()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

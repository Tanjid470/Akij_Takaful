import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/tax_certificate_controller.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxCertificateScreen extends StatelessWidget {
  const TaxCertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taxCertificateController = Get.put(TaxCertificateController());

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: "Tax Certificate"),
        backgroundColor: AppColors.secBgColor,
        body: Obx(
          () => taxCertificateController.downloadFileLoading.value
              ? const CustomCircularProgress()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      //  Policy/proposal text field
                      CustomTextField(
                        hintText: "Policy Number",
                        controller:
                            taxCertificateController.policyNoEditingController,
                        icon: Icons.policy_rounded,
                        color: AppColors.white,
                      ),

                      const SizedBox(
                        height: AppSize.textFieldSizedBoxHeight,
                      ),

                      //  Premium text field
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        width: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                              AppSize.textFieldBorderRadius),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    itemHeight: 50,
                                    isExpanded: true,
                                    value:
                                        taxCertificateController.myYear.value,
                                    iconSize: 30,
                                    icon: (null),
                                    hint: const Text('Select Financial Year'),
                                    onChanged: (newValue) {
                                      taxCertificateController
                                          .onChangedYear(newValue!);
                                    },
                                    items: taxCertificateController.yearList
                                        .map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //  Next button
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: LargeButton(
                            btnText: "Show",
                            onPressed: () =>
                                taxCertificateController.showCertificate()),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

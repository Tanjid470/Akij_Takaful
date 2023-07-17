import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/controller/business_report_controller.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CurrentBusinessMonth extends StatelessWidget {
  const CurrentBusinessMonth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final businessReportController = Get.put(BusinessReportController());
    final authController = Get.find<AuthController>();

    if (authController.getUserType() == 'Agent' &&
        !businessReportController.isFunctionCalled.value) {
      Future.delayed(Duration.zero, () {
        businessReportController.getCurrentMonthBusinessReport();
        businessReportController.isFunctionCalled(true);
      });
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: AppColors.secBgColor,
        appBar: const BaseAppBar(title: 'Current Business Month'),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 13, bottom: 10),
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSize.textFieldBorderRadius),
                ),
                elevation: 0,
                child: TextField(
                  style: const TextStyle(height: 1),
                  controller:
                      businessReportController.currentMonthEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  // Only numbers can be entered
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    focusColor: AppColors.butCol,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSize.textFieldBorderRadius),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSize.textFieldBorderRadius),
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    hintText: "Enter Code",
                    suffixIcon: IconButton(
                      onPressed: () {
                        businessReportController
                            .getCurrentMonthBusinessReport();
                      },
                      icon: SvgPicture.asset(
                        AppAsset.search,
                        height: AppSize.iconHeight,
                        width: AppSize.iconWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => !businessReportController.dataLoading.value
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: businessReportController
                          .currentBusinessMonthItems.length,
                      itemBuilder: (context, index) {
                        final item = businessReportController
                            .currentBusinessMonthItems[index];

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15, bottom: 10),
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * 0.022),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppSize.textFieldBorderRadius),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      item.count,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CustomCircularProgress()),
            ),
          ]),
        ),
      ),
    );
  }
}

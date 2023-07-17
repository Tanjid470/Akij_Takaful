import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/premium_calculator_controller.dart';
import 'package:akij_login_app/src/controller/products_controller.dart';
import 'package:akij_login_app/src/model/products/extra_model.dart';
import 'package:akij_login_app/src/model/products/ins_product_model.dart';
import 'package:akij_login_app/src/model/products/mode_model.dart';
import 'package:akij_login_app/src/model/products/terms_model.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_date_picker.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremiumCalculatorScreen extends StatelessWidget {
  const PremiumCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final premiumCalculatorController = Get.put(PremiumCalculatorController());
    final productsController = Get.put(ProductsController());

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: 'Premium Calculator'),
        backgroundColor: AppColors.secBgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const BuildTitleSection(
                  title: "Calculator",
                  subTitle: "Find out your premium amount",
                  align: CrossAxisAlignment.center),
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight + 10,
              ),
              CustomDatePicker(
                hintText: 'Select Birthdate',
                controller:
                    premiumCalculatorController.birthdateEditingController,
                icon: Icons.calendar_month_rounded,
                color: AppColors.white,
                readOnly: true,
                controllerText:
                    premiumCalculatorController.selectedBirthdate.value,
                onTap: () async {
                  final DateTime? picked = await customDatePickerColor(context);
                  premiumCalculatorController.updateSelectedBirthdate(
                      picked, premiumCalculatorController.selectedBirthdate);

                  premiumCalculatorController.clearProductsList();

                  await productsController.getProductList();
                },
              ),
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              Obx(
                () => CustomTextField(
                    hintText: premiumCalculatorController.duration.value != null
                        ? "Your age is ${premiumCalculatorController.duration.value!.years.toString()} years ${premiumCalculatorController.duration.value!.months.toString()} months ${premiumCalculatorController.duration.value!.days.toString()} days"
                        : "Please enter your birthdate",
                    readOnly: true,
                    controller:
                        premiumCalculatorController.birthdateEditingController,
                    icon: Icons.calculate_outlined),
              ),
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width * 0.91,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                            child: DropdownButton<InsProductModel>(
                              itemHeight: 60.0,
                              isExpanded: true,
                              value: premiumCalculatorController
                                  .productsController.selectedproduct.value,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select a Plan',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  premiumCalculatorController.productsController
                                      .onProductSelected(value);

                                  premiumCalculatorController.clearDropDowns();

                                  productsController.getTermsList();
                                  productsController.getModeList();
                                  productsController.getPdabList();
                                }
                              },
                              items: premiumCalculatorController
                                  .productsController.products
                                  .map<DropdownMenuItem<InsProductModel>>(
                                      (product) =>
                                          DropdownMenuItem<InsProductModel>(
                                            value: product,
                                            child:
                                                Text(product.name.toString()),
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
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width * 0.91,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                            child: DropdownButton<TermsModel>(
                              itemHeight: 60.0,
                              isExpanded: true,
                              value: premiumCalculatorController
                                  .productsController.selectedTerm.value,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select a Term',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  premiumCalculatorController.productsController
                                      .onTermSelected(value);
                                }
                              },
                              items: premiumCalculatorController
                                  .productsController.terms
                                  .map<DropdownMenuItem<TermsModel>>(
                                      (term) => DropdownMenuItem<TermsModel>(
                                            value: term,
                                            child: Text(term.term.toString()),
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
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width * 0.91,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                            child: DropdownButton<ModeModel>(
                              itemHeight: 60.0,
                              isExpanded: true,
                              value: premiumCalculatorController
                                  .productsController.selectedMode.value,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select a Mode',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  premiumCalculatorController.productsController
                                      .onModeSelected(value);
                                }
                              },
                              items: premiumCalculatorController
                                  .productsController.modes
                                  .map<DropdownMenuItem<ModeModel>>(
                                      (mode) => DropdownMenuItem<ModeModel>(
                                            value: mode,
                                            child: Text(mode.text.toString()),
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
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width * 0.91,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                            child: DropdownButton<ExtraModel>(
                              itemHeight: 60.0,
                              isExpanded: true,
                              value: premiumCalculatorController
                                  .productsController.selectedExtra.value,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select an Extra',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  premiumCalculatorController.productsController
                                      .onExtraSelected(value);
                                }
                              },
                              items: premiumCalculatorController
                                  .productsController.extras
                                  .map<DropdownMenuItem<ExtraModel>>(
                                      (extra) => DropdownMenuItem<ExtraModel>(
                                            value: extra,
                                            child: Text(extra.name.toString()),
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
              const SizedBox(
                height: AppSize.textFieldSizedBoxHeight,
              ),
              CustomTextField(
                hintText: "Enter Sum Assured",
                controller: premiumCalculatorController.sumEditingController,
                icon: Icons.currency_exchange,
                isNum: true,
              ),
            ],
          ),
        ),
        bottomNavigationBar: LargeButton(
            btnText: "Calculate",
            onPressed: () => {
                  {premiumCalculatorController.calculatePremium()}
                }),
      ),
    );
  }
}

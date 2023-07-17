import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/proposal_controller.dart';
import 'package:akij_login_app/src/model/products/product_list_model.dart';
import 'package:akij_login_app/src/view/components/build_form_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProposalEnlistScreen extends StatelessWidget {
  const ProposalEnlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proposalController = Get.put(ProposalController());

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: 'Proposal Enlist'),
        backgroundColor: AppColors.secBgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BuildFormTitleSection(
                title: "Personal Information",
                align: MainAxisAlignment.start,
              ),
              CustomTextField(
                hintText: "Please Type FA Code",
                controller: proposalController.tierEditingController,
                icon: Icons.policy_rounded,
                color: AppColors.white,
                isNum: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Proposer's Name",
                controller: proposalController.proNameEditingController,
                icon: Icons.drive_file_rename_outline,
                color: AppColors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Mobile Number",
                controller: proposalController.mobileEditingController,
                icon: Icons.install_mobile,
                color: AppColors.white,
                isNum: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const BuildFormTitleSection(
                title: "Proposal Details",
                align: MainAxisAlignment.start,
              ),
              CustomTextField(
                hintText: "Proposal Number",
                controller: proposalController.proposaltEditingController,
                icon: Icons.numbers_rounded,
                color: AppColors.white,
                isNum: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Sum Assured",
                controller: proposalController.sumAssuredEditingController,
                icon: Icons.summarize,
                color: AppColors.white,
                isNum: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width * 0.91,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color:
                        AppColors.white, //background color of dropdown button
                    borderRadius:
                        BorderRadius.circular(AppSize.textFieldBorderRadius),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSize.textFieldBorderRadius),
                            ),
                            alignedDropdown: true,
                            child: DropdownButton<ProductListModel>(
                              itemHeight: 60.0,
                              isExpanded: true,
                              value: proposalController.selectedProduct.value,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select Plan No',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  proposalController.onProductSelected(value);
                                }
                              },
                              items: proposalController.products
                                  .map<DropdownMenuItem<ProductListModel>>(
                                      (product) =>
                                          DropdownMenuItem<ProductListModel>(
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
                height: 20,
              ),
              CustomTextField(
                hintText: "Total Premium",
                controller: proposalController.premiumEditingController,
                icon: Icons.add_circle,
                color: AppColors.white,
                isNum: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        bottomNavigationBar: LargeButton(
            btnText: "Submit",
            onPressed: () => {proposalController.submitButton(context)}),
      ),
    );
  }
}

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/policy_controller.dart';
import 'package:akij_login_app/src/controller/products_controller.dart';
import 'package:akij_login_app/src/model/products/ins_product_model.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanWise extends StatefulWidget {
  const PlanWise({Key? key}) : super(key: key);

  @override
  State<PlanWise> createState() => _PlanWiseState();
}

final policyController = Get.find<PolicyController>();
final productsController = Get.put(ProductsController());

class _PlanWiseState extends State<PlanWise> {
  @override
  void initState() {
    productsController.getProductList();
    super.initState();
  }

  @override
  void dispose() {
    productsController.selectedproduct = Rx<InsProductModel?>(null);
    productsController.products = <InsProductModel>[].obs;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        policyController.onClose();
        return true;
      },
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: const BaseAppBar(title: 'Plan Wise List'),
          backgroundColor: AppColors.secBgColor,
          body: SingleChildScrollView(
            child: Column(children: [
              Obx(
                () => Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 13, bottom: 10),
                  margin: const EdgeInsets.only(top: 13),
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
                              value: productsController.selectedproduct.value,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select a Plan',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  productsController.onProductSelected(value);
                                }
                              },
                              items: productsController.products
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
              LargeButton(
                  btnText: "Search",
                  onPressed: () =>
                      policyController.getpolicyListDetailsPlanWise(
                          productsController.selectedproduct.value!.table)),
              Obx(
                () => policyController.isDataLoading.value
                    ? const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: CustomCircularProgress())
                    : Visibility(
                        visible: policyController.dataExists.value,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text(
                                "Policy No",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Proposer's Name",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                label: Text(
                                  "Entry Date",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              DataColumn(
                                  label: Text(
                                "Comdate",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Plan No",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Term",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Mode",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Sum Assured",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Total Premium",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Next Due Date",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Business Month",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Mobile No",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Tayer1",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Branch Name",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                              DataColumn(
                                  label: Text(
                                "Branch Code",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                            ],
                            rows: policyController.policyListDetails
                                .map(
                                  (policy) => DataRow(cells: [
                                    DataCell(Text(
                                      policy.policyno.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.proposersName.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.entryDate.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.comdate.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.planno.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      (policy.term.toString()).toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.mode.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.sumAssured.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.totalPremium.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.nextDueDate.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.businessMonth.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(
                                      GestureDetector(
                                        onTap: () => launchUrl(Uri.parse(
                                            'tel:${policy.mobileNo.toString()}')),
                                        child: Text(
                                          policy.mobileNo.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(
                                      policy.tayer1.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.branchname.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    DataCell(Text(
                                      policy.branchcode.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                  ]),
                                )
                                .toList(),
                          ),
                        ),
                      ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/policy_controller.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/custom_text_with_search.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CodeWise extends StatefulWidget {
  const CodeWise({super.key});

  @override
  State<CodeWise> createState() => _CodeWiseState();
}

final policyController = Get.find<PolicyController>();

class _CodeWiseState extends State<CodeWise> {
  @override
  void initState() {
    policyController.callFunctionInitially("CodeWise");
    super.initState();
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
          appBar: const BaseAppBar(title: 'Code Wise List'),
          backgroundColor: AppColors.secBgColor,
          body: SingleChildScrollView(
            child: Column(children: [
              CustomTextWithSearch(
                controller: policyController.codeEditingController,
                function: () {
                  policyController.getpolicyListDetailsCodeWise(
                      policyController.codeEditingController.text);
                },
                hinText: 'Enter Code',
              ),
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

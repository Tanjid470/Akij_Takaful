import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/controller/policy_controller.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PolicyStatementScreen extends StatelessWidget {
  const PolicyStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final policyController = Get.put(PolicyController());

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: 'Policy Statement'),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                    controller: policyController.policyEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    // Only numbers can be entered
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: "Policy Number",
                      suffixIcon: IconButton(
                        onPressed: () async {
                          await policyController.getPolicyInfo();
                          await policyController.getPolicyList();
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
                (() => !policyController.isAllDataLoaded.value
                    ? Container()
                    : Column(
                        children: [
                          Text(
                            policyController.name.value,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    height: 2,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.bgCol),
                          ),
                          const SizedBox(
                            height: AppSize.sizedBoxHeight,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSize.allPadding),
                            child: Table(
                              border: TableBorder.all(width: 1.5),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FlexColumnWidth(1.2),
                                1: FlexColumnWidth(1.2),
                                2: FlexColumnWidth(1.0),
                                4: FlexColumnWidth(2),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        AppSize.allPadding + 2),
                                    child: Center(
                                        child: Text(
                                      'Policy No',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      policyController.policyNo.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  )),
                                  Center(
                                      child: Text(
                                    'Com. Date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    policyController.riskDate.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        AppSize.allPadding + 2),
                                    child: Center(
                                        child: Text(
                                      'Sum \nAssured',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Center(
                                    child: Text(
                                      StringCurrencyFormatter().format(
                                          policyController.sumAssured.value),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                  Center(
                                      child: Text(
                                    'Maturity',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    policyController.maturity.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        AppSize.allPadding + 2),
                                    child: Center(
                                        child: Text(
                                      'Total \nPremium',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Center(
                                      child: Text(
                                    StringCurrencyFormatter().format(
                                        policyController.totalPremium.value),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )),
                                  Center(
                                      child: Text(
                                    'Next \nPayment',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    policyController.nextPayment.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        AppSize.allPadding + 2),
                                    child: Center(
                                        child: Text(
                                      'Mode',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Center(
                                      child: Text(
                                    policyController.mode.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )),
                                  Center(
                                      child: Text(
                                    'Status',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    policyController.status.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )),
                                ]),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.sizedBoxHeight + 40,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Table(
                                  border: TableBorder.all(width: 1.5),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: const {
                                    0: FlexColumnWidth(0.6),
                                    1: FlexColumnWidth(1.1),
                                    2: FlexColumnWidth(1.1),
                                    4: FlexColumnWidth(2),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            AppSize.allPadding + 2),
                                        child: Center(
                                            child: Text(
                                          'Inst. No',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      Center(
                                          child: Text(
                                        'OR No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                      Center(
                                          child: Text(
                                        'OR Date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                      Center(
                                          child: Text(
                                        'OR Amount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                    ]),
                                  ])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Table(
                                border: TableBorder.all(width: 1.5),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const {
                                  0: FlexColumnWidth(0.6),
                                  1: FlexColumnWidth(1.1),
                                  2: FlexColumnWidth(1.1),
                                  4: FlexColumnWidth(2),
                                },
                                children:
                                    policyController.policyList.map((item) {
                                  return TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                        item.ins.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      )),
                                    ),
                                    Center(
                                        child: Text(
                                      item.oRNO.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )),
                                    Center(
                                        child: Text(
                                      item.oRDate.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )),
                                    Center(
                                        child: Text(
                                      "TK ${StringCurrencyFormatter().format(item.amount.toString())}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )),
                                  ]);
                                }).toList()),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Table(
                              border: TableBorder.all(width: 1.5),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FlexColumnWidth(0.6),
                                1: FlexColumnWidth(1.1),
                                2: FlexColumnWidth(1.1),
                                4: FlexColumnWidth(2),
                              },
                              children: [
                                TableRow(children: [
                                  const Center(child: Text('')),
                                  const Center(child: Text("")),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                        child: Text(
                                      'Total',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Center(
                                    child: Center(
                                        child: Text(
                                      "TK ${StringCurrencyFormatter().format(policyController.totalPaid.value)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 30),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        width: 1, color: AppColors.butCol)),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                              ),
                              onPressed: () =>
                                  policyController.downloadPolicyStatement(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.download,
                                    color: AppColors.butCol,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Download Policy Statement",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx((() => policyController.isAllDataLoaded.value
            ? LargeButton(
                btnText: "Pay Your Premium ${AppAsset.taka}",
                onPressed: () => policyController.payPremium())
            : const SizedBox())),
      ),
    );
  }
}

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/top_ten_controller.dart';
import 'package:akij_login_app/src/model/top_ten/top_ten_model.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopTenScreen extends StatelessWidget {
  const TopTenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topTenController = Get.put(TopTenController());

    return Scaffold(
      appBar: const BaseAppBar(title: 'Top 10 List'),
      backgroundColor: AppColors.secBgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const BuildTitleSection(
                  title: "Top 10",
                  subTitle: "Current Business Month",
                  align: CrossAxisAlignment.center,
                ),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
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
                              child: DropdownButton<Tier>(
                                itemHeight: 60.0,
                                isExpanded: true,
                                value: topTenController.selectedTier.value,
                                iconSize: 30,
                                icon: (null),
                                hint: const Text(
                                  'Select Designation',
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    topTenController.onTierSelected(value);
                                  }
                                },
                                items: topTenController.tiers
                                    .map<DropdownMenuItem<Tier>>((tier) =>
                                        DropdownMenuItem<Tier>(
                                          value: tier,
                                          child: Text(tier.tayer.toString()),
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
                const SizedBox(height: 10),
                Obx(
                  () => topTenController.isDataLoading.value
                      ? const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: CustomCircularProgress())
                      : Visibility(
                          visible: topTenController.dataExists.value,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(
                                    label: Text(
                                  "Rank",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )),
                                DataColumn(
                                    label: Text(
                                  "Designation",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )),
                                DataColumn(
                                  label: Text(
                                    "Code",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                DataColumn(
                                    label: Text(
                                  "Name",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )),
                                DataColumn(
                                    label: Text(
                                  "Policy Count",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )),
                                DataColumn(
                                    label: Text(
                                  "Contact",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )),
                              ],
                              rows: topTenController.topTenList
                                  .map(
                                    (topTen) => DataRow(cells: [
                                      DataCell(Text(
                                        topTen.rankSL.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )),
                                      DataCell(Text(
                                        topTen.designation.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )),
                                      DataCell(Text(
                                        topTen.tierCode.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )),
                                      DataCell(Text(
                                        topTen.name.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )),
                                      DataCell(Text(
                                        (topTen.policyCount?.toInt())
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )),
                                      DataCell(Text(
                                        topTen.contactNo.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )),
                                    ]),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/controller/business_report_controller.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/src/view/screen/business_report/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CurrentBusinessYear extends StatefulWidget {
  const CurrentBusinessYear({Key? key}) : super(key: key);

  @override
  State<CurrentBusinessYear> createState() => _CurrentBusinessYearState();
}

class _CurrentBusinessYearState extends State<CurrentBusinessYear> {
  final businessReportController = Get.put(BusinessReportController());
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    if (authController.getUserType() == 'Agent') {
      businessReportController.getCurrentYearBusinessReport();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        businessReportController.onClose();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const BaseAppBar(title: 'Current Business Year'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 13, bottom: 10),
                color: Colors.white,
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSize.textFieldBorderRadius),
                  ),
                  elevation: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.015),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppSize.textFieldBorderRadius)),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey.shade200,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return FilterBottomSheet(
                                items: businessReportController
                                    .currentBusinessYearItems,
                                valueChanged: businessReportController
                                    .currYearReportState,
                                controller: businessReportController
                                    .currentYearEditingController,
                                function: businessReportController
                                    .getCurrentYearBusinessReport,
                                myYear:
                                    businessReportController.myCurrYear.value,
                                onChange: (String s) {
                                  businessReportController.onChangedCurrYear(s);
                                },
                                yearList: businessReportController.currYearList,
                              );
                            });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAsset.search,
                              height: AppSize.iconHeight,
                              width: AppSize.iconWidth,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Search",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              Obx(
                () => businessReportController.dataLoading.value
                    ? const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CustomCircularProgress())
                    : !businessReportController.dataExist.value
                        ? Container()
                        : Column(
                            children: [
                              BuildTitleSection(
                                  title: businessReportController.name.value,
                                  subTitle:
                                      'Business Year ${businessReportController.year.value}',
                                  align: CrossAxisAlignment.center),
                              const SizedBox(
                                height: AppSize.sizedBoxHeight,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      "Month",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "NCP",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )),
                                    DataColumn(
                                      label: Text(
                                        "Defferred",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                    DataColumn(
                                        label: Text(
                                      "FYCP",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Renewal",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Total",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Target",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Achieve Percentage",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )),
                                  ],
                                  rows: businessReportController
                                      .currentBusinessYearItems
                                      .map(
                                        (report) => DataRow(cells: [
                                          DataCell(Text(
                                            report.businessMonth.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                          DataCell(Text(
                                            "${StringCurrencyFormatter().formatCurr(report.fPR.toString())}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                          DataCell(Text(
                                            "${StringCurrencyFormatter().formatCurr(report.def.toString())}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                          DataCell(Text(
                                            "${StringCurrencyFormatter().formatCurr(report.firstYear.toString())}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                          DataCell(Text(
                                            "${StringCurrencyFormatter().formatCurr(report.renewal.toString())}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                          DataCell(Text(
                                            "${StringCurrencyFormatter().formatCurr(report.total.toString())}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                          DataCell(Text(
                                            "${StringCurrencyFormatter().formatCurr(report.target.toString())}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                          DataCell(Text(
                                            "${report.targetAchivePercentage.toString()}%",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                        ]),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

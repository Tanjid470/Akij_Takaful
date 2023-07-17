// ignore_for_file: prefer_if_null_operators
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/controller/business_report_controller.dart';
import 'package:akij_login_app/src/model/business/business_report_model.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<BusinessReportModel> items;
  final ValueChanged<List<BusinessReportModel>> valueChanged;
  final String? myYear;
  final List<String> yearList;
  final Function(String) onChange;
  final TextEditingController controller;
  final Function() function;

  const FilterBottomSheet(
      {Key? key,
      required this.valueChanged,
      required this.items,
      required this.controller,
      required this.function,
      required this.myYear,
      required this.yearList,
      required this.onChange})
      : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final authController = Get.find<AuthController>();

  final businessReportController = Get.find<BusinessReportController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.51,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: AppSize.textFieldSizedBoxHeight,
                ),
                CustomTextField(
                  hintText: 'Enter Code',
                  controller: widget.controller,
                  icon: Icons.code,
                  color: AppColors.textFieldGrey,
                ),
                const SizedBox(
                  height: AppSize.textFieldSizedBoxHeight,
                ),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    width: MediaQuery.of(context).size.width * 0.91,
                    height: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                      color: AppColors.textFieldGrey,
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
                              child: DropdownButton<String>(
                                itemHeight: 60.0,
                                isExpanded: true,
                                value:
                                    businessReportController.myMonthFrom.value,
                                iconSize: 30,
                                icon: (null),
                                hint: const Text(
                                  'Select Month From',
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    businessReportController
                                        .onChangedMonthFrom(value);
                                  }
                                },
                                items: businessReportController.monthList
                                    .map<DropdownMenuItem<String>>(
                                        (month) => DropdownMenuItem<String>(
                                              value: month,
                                              child: Text(month),
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
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    width: MediaQuery.of(context).size.width * 0.91,
                    height: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                      color: AppColors.textFieldGrey,
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
                              child: DropdownButton<String>(
                                itemHeight: 60.0,
                                isExpanded: true,
                                value: businessReportController.myMonthTo.value,
                                iconSize: 30,
                                icon: (null),
                                hint: const Text(
                                  'Select Month To',
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    businessReportController
                                        .onChangedMonthTo(value);
                                  }
                                },
                                items: businessReportController.monthList
                                    .map<DropdownMenuItem<String>>(
                                        (month) => DropdownMenuItem<String>(
                                              value: month,
                                              child: Text(month),
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
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width * 0.91,
                  height: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.textFieldGrey,
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
                            child: DropdownButton<String>(
                              itemHeight: 60.0,
                              isExpanded: true,
                              value: widget.myYear,
                              iconSize: 30,
                              icon: (null),
                              hint: const Text(
                                'Select Year',
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  widget.onChange(value);
                                }
                              },
                              items: widget.yearList
                                  .map<DropdownMenuItem<String>>(
                                      (year) => DropdownMenuItem<String>(
                                            value: year,
                                            child: Text(year),
                                          ))
                                  .toList(),
                            ),
                          ),
                        ),
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
                      btnText: "Search",
                      onPressed: () => {
                            {widget.function(), Get.back()}
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

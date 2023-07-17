import 'package:akij_login_app/src/controller/business_report_controller.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessReportScreen extends StatelessWidget {
  const BusinessReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final businessReportController = Get.put(BusinessReportController());

    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white,
        appBar: const BaseAppBar(title: 'Business Report'),
        body: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: businessReportController.items.length,
            itemBuilder: (context, index) {
              final item = businessReportController.items[index];

              return InkWell(
                onTap: () {
                  Get.to(item.path);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primCol,
                          ),
                        ),
                        Positioned.fill(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  item.icon,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  item.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}

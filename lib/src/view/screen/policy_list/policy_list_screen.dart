import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/policy_controller.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyListScreen extends StatelessWidget {
  const PolicyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final policyController = Get.put(PolicyController());

    return Scaffold(
      appBar: const BaseAppBar(title: 'Policy List'),
      backgroundColor: AppColors.secBgColor,
      body: SingleChildScrollView(
        child: Column(children: [
          const BuildTitleSection(
            title: "Policy List Statement",
            subTitle: "Select a Category",
            align: CrossAxisAlignment.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: GridView.builder(
                itemCount: policyController.menus.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 17),
                              blurRadius: 17,
                              spreadRadius: -23,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () =>
                                Get.to(policyController.menus[index].path),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  policyController.menus[index].icon,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                  color:
                                      policyController.menus[index].iconColor,
                                ),
                                const SizedBox(height: 10),
                                Text(policyController.menus[index].title,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}

import 'package:akij_login_app/src/controller/links_controller.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RecommendedAppsScreen extends StatelessWidget {
  const RecommendedAppsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linksController = Get.put(LinksController());

    return Scaffold(
      appBar: const BaseAppBar(title: 'Recommended Apps'),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: GridView.builder(
            itemCount: linksController.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 2,
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
                          offset: Offset(0, 27),
                          blurRadius: 27,
                          spreadRadius: -23,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => linksController.onTapApp(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              linksController.items[index].icon,
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              linksController.items[index].title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

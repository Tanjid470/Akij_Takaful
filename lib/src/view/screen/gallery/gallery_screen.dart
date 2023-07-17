import 'package:akij_login_app/src/controller/links_controller.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linksController = Get.put(LinksController());

    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white,
        appBar: const BaseAppBar(title: 'Gallery'),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => linksController.launchImageGallery(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(context.height * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.shade100.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Image Gallery",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.width * 0.04,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => linksController.launchVideoGallery(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(context.height * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Video Gallery",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.width * 0.04,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

import 'package:akij_login_app/src/controller/links_controller.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadFormScreen extends StatelessWidget {
  const DownloadFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linksController = Get.put(LinksController());

    return Stack(children: [
      Scaffold(
        appBar: const BaseAppBar(title: 'Forms'),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => linksController.launchPolicyAltForm(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 10),
                  child: Stack(children: [
                    Container(
                      height: context.height * 0.13,
                      padding: EdgeInsets.all(context.height * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                "Policy Alternation Form",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.width * 0.04,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () => linksController.launchIndGroupForm(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 10),
                  child: Stack(children: [
                    Container(
                      height: context.height * 0.13,
                      padding: EdgeInsets.all(context.height * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade200.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                "Individual Group Form",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.width * 0.04,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () => linksController.launchPolicyAltForm(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 10),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      height: context.height * 0.13,
                      padding: EdgeInsets.all(context.height * 0.05),
                      decoration: BoxDecoration(
                        color:
                            Colors.deepOrangeAccent.shade100.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                "Claim Group Form",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.width * 0.04,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

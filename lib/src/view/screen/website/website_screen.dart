import 'package:akij_login_app/src/controller/links_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebsiteScreen extends StatefulWidget {
  const WebsiteScreen({Key? key}) : super(key: key);

  @override
  State<WebsiteScreen> createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {
  final linksController = Get.put(LinksController());

  @override
  initState() {
    super.initState();
    linksController.launchWebsite();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

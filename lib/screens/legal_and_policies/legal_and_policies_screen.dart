import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/context_value.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalAndPoliciesScreen extends StatefulWidget {
  const LegalAndPoliciesScreen({Key? key}) : super(key: key);

  @override
  State<LegalAndPoliciesScreen> createState() => _LegalAndPoliciesScreenState();
}

class _LegalAndPoliciesScreenState extends State<LegalAndPoliciesScreen> {
  late PackageInfo packageInfo;
  String? version;
  String? buildNumber;

  @override
  initState() {
    super.initState();
    getVersionInfo();
  }

  Future<void> getVersionInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  launchUserManual() async {
    var url = Uri.parse(
        "https://github.com/AkijTakafulLifeInsurancePLC/MATA-User-Manual/raw/main/MATA%20User%20Manual.pdf");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  launchPrivacyPolicy() async {
    var url = Uri.parse(
        "https://sites.google.com/view/my-akij-takaful-privacy-policy/");
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BaseAppBar(title: 'Policies and Manual'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => launchUserManual(),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(context.height * 0.03),
                  decoration: BoxDecoration(
                    color: AppColors.secBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "User Manual",
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
              onTap: () => launchPrivacyPolicy(),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(context.height * 0.03),
                  decoration: BoxDecoration(
                    color: AppColors.secBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Privacy Policy",
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
            Container(
              padding: EdgeInsets.only(top: context.height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    Text(
                      "Version ",
                      style: TextStyle(
                          fontSize: context.width * 0.035,
                          color: AppColors.bgCol),
                    ),
                    Text(
                      "$version ($buildNumber)",
                      style: TextStyle(
                          fontSize: context.width * 0.035,
                          color: AppColors.bgCol,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

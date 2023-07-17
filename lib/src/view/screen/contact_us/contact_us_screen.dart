import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/src/view/components/navbar/navbar.dart';
import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/context_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  final List items = [
    ContactInfo(
        "Loacation",
        "Paltan China Town ( 15th Floor), East Tower, 67/1 Naya Paltan, VIP Road, Dhaka-1000",
        AppAsset.office),
    ContactInfo("Hotline", "09604016761", AppAsset.telephone),
    ContactInfo("Toll Free Number", "08000124124", AppAsset.telephone2),
    ContactInfo("Health Care Number", "09643116761", AppAsset.telephone3),
    ContactInfo("Office Hours",
        "09:00 a.m. till 6:00 p.m. \n(Saturday to Thursday)", AppAsset.time),
    ContactInfo("Support", "support@akijtakafullife.com.bd", AppAsset.support),
    ContactInfo("Info", "info@akijtakafullife.com.bd", AppAsset.info),
    ContactInfo("Trade License No.", "005092/2022", AppAsset.license),
  ];

  ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secBgColor,
      appBar: const BaseAppBar(title: 'Contact Us'),
      drawer: const Navbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            const BuildTitleSection(
              title: "Reach Us On",
              align: CrossAxisAlignment.center,
              subTitle: 'Akij Takaful Life Insurance PLC.',
            ),
            ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () => handleTap(index),
                      child: ListTile(
                        textColor: AppColors.bgCol,
                        tileColor: Colors.white,
                        horizontalTitleGap: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        minVerticalPadding: 15.0,
                        leading: SvgPicture.asset(
                          items[index].icon,
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          items[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.width * 0.04,
                              color: AppColors.primCol),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            items[index].subtitle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.width * 0.035,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }

  handleTap(int index) async {
    if (items[index].title == "Hotline" ||
        items[index].title == "Toll Free Number" ||
        items[index].title == "Health Care Number") {
      final call = Uri.parse('tel:${items[index].subtitle}');
      if (await canLaunchUrl(call)) {
        launchUrl(call);
      } else {
        throw 'Could not launch $call';
      }
    } else if (items[index].title == "Support" ||
        items[index].title == "Info") {
      final email = Uri.parse('mailto:${items[index].subtitle}');
      if (await canLaunchUrl(email)) {
        launchUrl(email);
      } else {
        throw 'Could not launch $email';
      }
    }
  }
}

class ContactInfo {
  final String title;
  final String subtitle;
  final String icon;

  ContactInfo(
    this.title,
    this.subtitle,
    this.icon,
  );
}

import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/screens/about/about_screen.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/screen/auth/login/login_screen.dart';
import 'package:akij_login_app/src/view/screen/branch_offices/branch_offices_screen.dart';
import 'package:akij_login_app/src/view/screen/dashboard/dashboard_screen.dart';
import 'package:akij_login_app/src/view/screen/gallery/gallery_screen.dart';
import 'package:akij_login_app/screens/legal_and_policies/legal_and_policies_screen.dart';
import 'package:akij_login_app/src/view/screen/premium_calculator/premium_calculator_screen.dart';
import 'package:akij_login_app/src/view/screen/recommended_apps/recommended_apps_screen.dart';
import 'package:akij_login_app/src/view/screen/online_payment/online_payment_screen.dart';
import 'package:akij_login_app/src/view/screen/our_products/our_products_screen.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppColors.bgCol,
        child: Obx(
          () => ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text(''),
                accountEmail: Padding(
                  padding: EdgeInsets.only(
                      right: AppSize.rightPadding, top: context.width * 0.04),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SharedPrefs().username.isNotEmpty
                              ? SharedPrefs().username
                              : "",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          SharedPrefs().userId,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.apply(color: Colors.black),
                        ),
                      ]),
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  image: DecorationImage(
                      image: AssetImage(AppAsset.navbarBanner),
                      fit: BoxFit.contain),
                ),
              ),
              buildMenuItem(
                text: 'Home',
                icon: AppAsset.home,
                onClicked: () => selectedItem(context, 0),
              ),
              buildMenuItem(
                text: 'About',
                icon: AppAsset.about,
                onClicked: () => selectedItem(context, 1),
              ),
              buildMenuItem(
                text: 'Premium Calculator',
                icon: AppAsset.calculator,
                onClicked: () => selectedItem(context, 3),
              ),
              buildMenuItem(
                text: 'Online Payment',
                icon: AppAsset.payment,
                onClicked: () => selectedItem(context, 4),
              ),
              const Divider(indent: 10, endIndent: 10, thickness: 2),
              buildMenuItem(
                text: 'Our Products',
                icon: AppAsset.products,
                onClicked: () => selectedItem(context, 5),
              ),
              buildMenuItem(
                text: 'Recommended Apps',
                icon: AppAsset.recommendedApps,
                onClicked: () => selectedItem(context, 7),
              ),
              buildMenuItem(
                text: 'Policies and Manual',
                icon: AppAsset.policiesAndManual,
                onClicked: () => selectedItem(context, 10),
              ),
              const Divider(indent: 10, endIndent: 10, thickness: 2),
              authController.loggedIn.value
                  ? buildMenuItemSvg(
                      text: 'Log Out',
                      icon: AppAsset.logout,
                      onClicked: () => selectedItem(context, 8),
                    )
                  : buildMenuItemSvg(
                      text: 'Log In',
                      icon: AppAsset.login,
                      onClicked: () => selectedItem(context, 9),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 23,
      ),
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      onTap: onClicked,
    );
  }

  Widget buildMenuItemSvg({
    required String text,
    required String icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int i) {
    switch (i) {
      case 0:
        Get.to(() => const DashboardScreen());
        break;
      case 1:
        Get.to(() => const AboutScreen());
        break;
      case 2:
        Get.to(() => const GalleryScreen());
        break;
      case 3:
        Get.to(() => const PremiumCalculatorScreen());
        break;
      case 4:
        Get.to(() => const OnlinePaymentScreen());

        break;
      case 5:
        Get.to(() => const OurProductsScreen());
        break;
      case 6:
        Get.to(() => const BranchOfficesScreen());
        break;
      case 7:
        Get.to(() => const RecommendedAppsScreen());
        break;
      case 8:
        authController.onLogoutPressed();
        break;
      case 9:
        Get.to(() => const LoginScreen());
        break;
      case 10:
        Get.to(() => const LegalAndPoliciesScreen());
        break;
    }
  }
}

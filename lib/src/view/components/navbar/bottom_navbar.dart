import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/view/screen/branch_offices/branch_offices_screen.dart';
import 'package:akij_login_app/src/view/screen/contact_us/contact_us_screen.dart';
import 'package:akij_login_app/src/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 35,
        right: 35,
      ),
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0), // adjust to your liking
          topRight: Radius.circular(12.0), // adjust to your liking
        ),
        color: AppColors.bgCol,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_filled,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BranchOfficesScreen(),
              ));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.contact_phone_rounded,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContactUsScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}

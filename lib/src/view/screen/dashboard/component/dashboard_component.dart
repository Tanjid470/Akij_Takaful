import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/view/components/build_dashboard_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/dashboard_item.dart';
import 'package:akij_login_app/src/view/components/image_carousel.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/src/view/components/navbar/navbar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/view/components/policy_summary_item.dart';
import 'package:akij_login_app/src/view/screen/business_report/business_report_screen.dart';
import 'package:akij_login_app/src/view/screen/chain_setup/chain_setup_screen.dart';
import 'package:akij_login_app/src/view/screen/download_form/download_form_screen.dart';
import 'package:akij_login_app/screens/e_receipt/e_receipt.dart';
import 'package:akij_login_app/src/view/screen/gallery/gallery_screen.dart';
import 'package:akij_login_app/screens/hospital_list/hospital_List_screen.dart';
import 'package:akij_login_app/screens/job_circular/job_circular_screen.dart';
import 'package:akij_login_app/screens/my_card/dashboard_card.dart';
import 'package:akij_login_app/screens/my_card/my_card_screen.dart';
import 'package:akij_login_app/src/view/screen/office/office_screen.dart';
import 'package:akij_login_app/screens/premium_notice/premium_notice_screen.dart';
import 'package:akij_login_app/src/view/screen/policy_list/policy_list_screen.dart';
import 'package:akij_login_app/src/view/screen/premium_calculator/premium_calculator_screen.dart';
import 'package:akij_login_app/src/view/screen/proposal_enlist/proposal_enlist_screen.dart';
import 'package:akij_login_app/src/view/screen/proposal_list/proposal_list_screen.dart';
import 'package:akij_login_app/src/view/screen/recommended_apps/recommended_apps_screen.dart';
import 'package:akij_login_app/src/view/screen/top_ten/top_ten_screen.dart';
import 'package:akij_login_app/src/view/screen/website/website_screen.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:akij_login_app/src/view/screen/online_payment/online_payment_screen.dart';
import 'package:akij_login_app/src/view/screen/our_products/our_products_screen.dart';
import 'package:akij_login_app/src/view/screen/policy_statement/policy_statement_screen.dart';
import 'package:akij_login_app/src/view/screen/tax_certificate/tax_certificate_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardComponent extends StatefulWidget {
  const DashboardComponent({Key? key}) : super(key: key);

  @override
  State<DashboardComponent> createState() => _DashboardComponentState();
}

class _DashboardComponentState extends State<DashboardComponent> {
  final authController = Get.put(AuthController());

  @override
  void initState() {
    if (authController.isProducer.value) {
      authController.getpolicyListSummary(authController.getPolicyNo());
    } else if (authController.isAdmin.value) {
      authController.getMonthlyBusinessSummary();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BaseAppBar(
            title: '',
          ),
        ),
        drawer: const Navbar(),
        body: Obx(() {
          return SingleChildScrollView(
            child: SizedBox(
              child: Stack(children: [
                if (authController.loggedIn.value &&
                    !authController.isPolicyHolder.value) ...[
                  Container(
                    height: 155,
                    decoration: const BoxDecoration(
                      color: AppColors.bgCol,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(150),
                      ),
                    ),
                  ),
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (authController.isPolicyHolder.value) ...[
                      SizedBox(
                          height: size.height * 0.3,
                          child: const DashboardCard()),
                    ],
                    if (authController.loggedIn.value &&
                        !authController.isPolicyHolder.value) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 50, left: 10, right: 10),
                        child: Text(
                          "Hello, ${SharedPrefs().username}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.apply(color: Colors.white),
                        ),
                      ),
                    ] else ...[
                      if (SharedPrefs().loggedIn == false)
                        Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const ImageCarousel()),
                    ],
                    if (authController.isProducer.value) ...[
                      !authController.dataExists.value
                          ? const CustomCircularProgress()
                          : SizedBox(
                              height: size.height * 0.15,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: authController
                                        .policyListSummary.value.code,
                                    subtitle: authController
                                        .policyListSummary.value.tier,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.yellow,
                                    title: "Total Policies",
                                    subtitle: authController
                                        .policyListSummary.value.totalPolicyno,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "Total SumAssured",
                                    subtitle: authController.policyListSummary
                                        .value.totalSumAssured,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "Total Premium",
                                    subtitle: authController
                                        .policyListSummary.value.totalPremium,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "Total Due Policies",
                                    subtitle: authController.policyListSummary
                                        .value.totalDuePolicies,
                                  ),
                                ],
                              ),
                            ),
                    ] else if (authController.isAdmin.value) ...[
                      !authController.dataExists.value
                          ? const CustomCircularProgress()
                          : SizedBox(
                              height: size.height * 0.15,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "FPR",
                                    subtitle: authController
                                        .monthlyBusinessSummary.value.fPR,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.yellow,
                                    title: "Deff",
                                    subtitle: authController
                                        .monthlyBusinessSummary.value.deff,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "Single",
                                    subtitle: authController
                                        .monthlyBusinessSummary.value.single,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "First Year",
                                    subtitle: authController
                                        .monthlyBusinessSummary.value.firstYear,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "Renewal",
                                    subtitle: authController
                                        .monthlyBusinessSummary.value.renewal,
                                  ),
                                  PolicySummaryItem(
                                    color: Colors.red,
                                    title: "Total Premium",
                                    subtitle: authController
                                        .monthlyBusinessSummary
                                        .value
                                        .totalPremium,
                                  ),
                                ],
                              ),
                            ),
                    ],
                    const BuildDashboardTitleSection(
                        title: "Products", align: MainAxisAlignment.start),
                    SizedBox(
                      height: size.height * 0.17,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.85,
                          children: [
                            const DashboardItem(
                              route: OurProductsScreen(),
                              icon: Icons.production_quantity_limits_rounded,
                              color: AppColors.bgCol,
                              title: "Our Products",
                              loginNeeded: false,
                            ),
                            DashboardItem(
                              route: const PremiumCalculatorScreen(),
                              icon: Icons.calculate_outlined,
                              color: Colors.deepOrange.shade400,
                              title: "Premium Calculator",
                              loginNeeded: false,
                            ),
                            const DashboardItem(
                              route: OnlinePaymentScreen(),
                              icon: Icons.attach_money_rounded,
                              color: Colors.lightBlue,
                              title: "Online Payment",
                              loginNeeded: false,
                            ),
                            if (authController.loggedIn.value) ...[
                              DashboardItem(
                                route: const PolicyStatementScreen(),
                                icon: Icons.policy_rounded,
                                color: Colors.pinkAccent.shade400,
                                title: 'Policy Statement',
                                loginNeeded: true,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    if (authController.loggedIn.value) ...[
                      const BuildDashboardTitleSection(
                          title: "Services", align: MainAxisAlignment.start),
                      SizedBox(
                          height: authController.calculateHeight(),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.85,
                              children: [
                                if (!authController.isProducer.value) ...[
                                  if (!authController.isAdmin.value)
                                    DashboardItem(
                                      route: const MyCardScreen(),
                                      icon: Icons.card_membership_sharp,
                                      color: Colors.blue.shade900,
                                      title: 'My Card',
                                      loginNeeded: true,
                                    ),
                                  DashboardItem(
                                    route: const TaxCertificateScreen(),
                                    icon: Icons.newspaper,
                                    color: Colors.yellow.shade400,
                                    title: 'Tax Certificate',
                                    loginNeeded: true,
                                  ),
                                ],
                                if (!authController.isPolicyHolder.value) ...[
                                  DashboardItem(
                                    route: const OfficeScreen(),
                                    icon: Icons.house_siding_rounded,
                                    color: Colors.redAccent.shade700,
                                    title: 'Office',
                                    loginNeeded: true,
                                  ),
                                  DashboardItem(
                                    route: const BusinessReportScreen(),
                                    icon: Icons.business_rounded,
                                    color: Colors.teal.shade400,
                                    title: 'Business Report',
                                    loginNeeded: true,
                                  ),
                                  DashboardItem(
                                    route: const ProposalEnlistScreen(),
                                    icon: Icons.person_add_alt_1_rounded,
                                    color: Colors.blue.shade900,
                                    title: 'Proposal Enlist',
                                    loginNeeded: true,
                                  ),
                                  DashboardItem(
                                    route: const ProposalListScreen(),
                                    icon: Icons.list_alt,
                                    color: Colors.limeAccent.shade700,
                                    title: 'Proposal List',
                                    loginNeeded: true,
                                  ),
                                  DashboardItem(
                                    route: const PolicyListScreen(),
                                    icon: Icons.view_carousel_outlined,
                                    color: Colors.yellow.shade800,
                                    title: 'Policy List',
                                    loginNeeded: true,
                                  ),
                                  DashboardItem(
                                    route: const TopTenScreen(),
                                    icon: Icons.workspace_premium_sharp,
                                    color: Colors.deepPurple.shade400,
                                    title: 'Top 10',
                                    loginNeeded: true,
                                  ),
                                  DashboardItem(
                                    route: const PremiumNoticeScreen(),
                                    icon: Icons.notification_important_rounded,
                                    color: Colors.deepOrangeAccent.shade400,
                                    title: 'Premium Notice',
                                    loginNeeded: true,
                                  ),
                                  DashboardItem(
                                    route: const ChainSetupScreen(),
                                    icon: Icons.insert_link_rounded,
                                    color: Colors.grey.shade700,
                                    title: 'Chain Setup',
                                    loginNeeded: true,
                                  ),
                                ],
                                DashboardItem(
                                  route: const EReceipt(),
                                  icon: Icons.receipt_long,
                                  color: Colors.lightGreen.shade500,
                                  title: 'E-Receipt',
                                  loginNeeded: true,
                                ),
                              ],
                            ),
                          )),
                    ],
                    const BuildDashboardTitleSection(
                        title: "Others", align: MainAxisAlignment.start),
                    SizedBox(
                        height: size.height * 0.39,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.85,
                            children: [
                              const DashboardItem(
                                route: HospitalListScreen(),
                                icon: Icons.local_hospital_rounded,
                                color: Colors.pinkAccent,
                                title: "Hospitals",
                                loginNeeded: false,
                              ),
                              DashboardItem(
                                route: const JobCircularScreen(),
                                icon: Icons.notification_add_rounded,
                                color: Colors.blue.shade600,
                                title: 'Job Circular',
                                loginNeeded: false,
                              ),
                              DashboardItem(
                                route: const DownloadFormScreen(),
                                icon: Icons.download_rounded,
                                color: Colors.deepPurpleAccent.shade400,
                                title: 'Download Form',
                                loginNeeded: false,
                              ),
                              DashboardItem(
                                route: const RecommendedAppsScreen(),
                                icon: Icons.mobile_friendly,
                                color: Colors.green.shade600,
                                title: 'Apps',
                                loginNeeded: false,
                              ),
                              DashboardItem(
                                route: const GalleryScreen(),
                                icon: Icons.image_rounded,
                                color: Colors.greenAccent.shade400,
                                title: 'Gallery',
                                loginNeeded: false,
                              ),
                              DashboardItem(
                                route: const WebsiteScreen(),
                                icon: Icons.desktop_mac_outlined,
                                color: Colors.purple.shade400,
                                title: 'Website',
                                loginNeeded: false,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ]),
            ),
          );
        }));
  }
}

// callForSummary() {
//   if (!authController.dataExists.value) {
//     const CustomCircularProgress();
//   } else {
//     SizedBox(
//       height: 100,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           PolicySummaryItem(
//             color: Colors.red,
//             title: authController.code.value,
//             subtitle: authController.tier.value,
//           ),
//           PolicySummaryItem(
//             color: Colors.yellow,
//             title: "Total Policies",
//             subtitle: authController.totalPolicyNo.value,
//           ),
//           PolicySummaryItem(
//             color: Colors.red,
//             title: "Total SumAssured",
//             subtitle: authController.totalSumAssured.value,
//           ),
//           PolicySummaryItem(
//             color: Colors.red,
//             title: "Total Premium",
//             subtitle: authController.totalPremium.value,
//           ),
//           PolicySummaryItem(
//             color: Colors.red,
//             title: "Total Due Policies",
//             subtitle: authController.totalDuePolicies.value,
//           ),
//         ],
//       ),
//     );
//   }
// }

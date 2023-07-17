import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/capitalize_first_letter.dart';
import 'package:akij_login_app/helpers/get_tier_id.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:akij_login_app/src/controller/chain_setup_controller.dart';
import 'package:akij_login_app/src/model/chain_setup/chain_setup_model.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/custom_text_with_search.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ChainSetupScreen extends StatefulWidget {
  const ChainSetupScreen({Key? key}) : super(key: key);

  @override
  State<ChainSetupScreen> createState() => _ChainSetupScreenState();
}

class _ChainSetupScreenState extends State<ChainSetupScreen> {
  final chainSetupController = Get.put(ChainSetupController());

  @override
  void initState() {
    super.initState();
    if (chainSetupController.authController.isProducer.value) {
      chainSetupController.getChainSetup(SharedPrefs().userId);
    }
  }

  Widget branchTile(ChainSetupModel chainSetup) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.house_siding_rounded),
        dense: true,
        minLeadingWidth: 10.0,
        title: Text(
            "${capitalizeFirstLetterOfEachWord(chainSetup.branchName!)} (${chainSetup.officeCode!})"),
      ),
    );
  }

  Widget phoneTile(ChainSetupModel chainSetup) {
    return GestureDetector(
      onTap: () =>
          launchUrl(Uri.parse('tel:${chainSetup.contructNo.toString()}')),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: const Icon(Icons.call),
          dense: true,
          minLeadingWidth: 10.0,
          title: Text(chainSetup.contructNo!),
        ),
      ),
    );
  }

  Widget chainTile(ChainSetupModel chainSetup) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.link_rounded),
        dense: true,
        minLeadingWidth: 10.0,
        title: Text(
            "${chainSetup.tayer1!} - ${chainSetup.tayer2!} - ${chainSetup.tayer3!} - ${chainSetup.tayer4!} - ${chainSetup.tayer5!} - ${chainSetup.tayer6!} - ${chainSetup.tayer7!}"),
      ),
    );
  }

  Widget businessTile(ChainSetupModel chainSetup) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.remove_red_eye_rounded),
        dense: true,
        minLeadingWidth: 10.0,
        title: const Text("View Business"),
        onTap: () {
          chainSetupController.getBusiness(chainSetup.tayerCode.toString());
        },
      ),
    );
  }

  Widget buildExpansionTile(ChainSetupModel chainSetup) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      expandedCrossAxisAlignment: CrossAxisAlignment.end,
      trailing: const Icon(Icons.arrow_drop_down_rounded),
      textColor: AppColors.primCol,
      iconColor: AppColors.primCol,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(chainSetup.name!,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("${chainSetup.tayer} - ${chainSetup.tayerCode}"),
      children: [
        branchTile(chainSetup),
        chainTile(chainSetup),
        phoneTile(chainSetup),
        businessTile(chainSetup),
      ],
    );
  }

  Widget buildChainSetupList() {
    return Obx(() => Scrollbar(
          interactive: true,
          thickness: 7.0,
          child: ListView.builder(
            itemCount: chainSetupController.chainSetupList.length,
            itemBuilder: (context, index) {
              ChainSetupModel chainSetup =
                  chainSetupController.chainSetupList[index];

              int level = getTierId(chainSetup.tayer!);
              Color tileColor = level <= chainSetupController.levelColors.length
                  ? chainSetupController.levelColors[level - 1]
                  : AppColors.white;
              return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  color: tileColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: buildExpansionTile(chainSetup));
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const BaseAppBar(title: 'Chain Setup'),
        backgroundColor: AppColors.secBgColor,
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (chainSetupController.authController.isAdmin.value) ...[
                CustomTextWithSearch(
                  controller: chainSetupController.codeEditingController,
                  function: () {
                    chainSetupController.onClear();
                    chainSetupController.getChainSetup(
                        chainSetupController.codeEditingController.text);
                  },
                  hinText: 'Enter Code',
                ),
              ],
              Expanded(
                child: chainSetupController.isDataLoading.value
                    ? const Center(child: CustomCircularProgress())
                    : chainSetupController.dataExists.value
                        ? buildChainSetupList()
                        : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

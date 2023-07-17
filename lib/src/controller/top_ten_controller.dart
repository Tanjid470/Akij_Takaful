import 'dart:convert';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/top_ten/top_ten_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TopTenController extends GetxController {
  final authController = Get.find<AuthController>();

  final tiers = <Tier>[].obs;
  Rx<Tier?> selectedTier = Rx<Tier?>(null);
  final topTenList = <TopTenModel>[].obs;

  RxBool dataExists = false.obs;
  RxBool isDataLoading = false.obs;
  RxString entry = "".obs;
  RxString proposalNo = "".obs;
  RxString name = "".obs;
  RxString comDate = "".obs;
  RxString fa = "".obs;
  RxString undRequirement = "".obs;
  RxString medicalDecision = "".obs;
  RxString underwriterDecision = "".obs;
  RxString note = "".obs;
  RxString submitBy = "".obs;
  RxString status = "".obs;

  callForTopTenList(String id) async {
    try {
      isDataLoading(true);

      var response = await http.post(
        Uri.parse('${authController.baseUrl}v1/Apps/TopTenList'),
        headers: {
          'token': authController.getToken(),
        },
        body: {'id': id},
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        callForTopTenList(selectedTier.value!.id);
      }

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        List<TopTenModel> topList = [];

        for (var topTenInfo in data) {
          TopTenModel topTen = TopTenModel(
            rankSL: topTenInfo['RankSL'],
            tierCode: topTenInfo['TierCode'],
            designation: topTenInfo['Designation'],
            name: topTenInfo['Name'],
            totalPremium: double.parse(topTenInfo['TotalPremium'].toString()),
            policyCount: topTenInfo['PolicyCount'],
            contactNo: topTenInfo['ContactNo'],
          );

          topList.add(topTen);
        }
        topTenList.assignAll(topList);

        dataExists(true);
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Error",
            "Could not fetch list",
            "Try Again",
            Colors.blue,
            Colors.blue,
            Icons.details);
        throw Exception("Error");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error");
    } finally {
      isDataLoading(false);
    }
  }

  getTierList() async {
    try {
      var response = await http.get(
        Uri.parse('${authController.baseUrl}v1/Apps/TierList'),
        headers: {
          'token': authController.getToken(),
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getTierList();
      }

      final tiersJson = jsonDecode(response.body) as List<dynamic>;
      final limitedTiersJson =
          tiersJson.take(authController.getDesignation()).toList();
      final tiers = limitedTiersJson
          .map((tierJson) => Tier.fromJson(tierJson as Map<String, dynamic>))
          .toList();
      this.tiers.assignAll(tiers);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTierSelected(Tier tier) {
    selectedTier.value = tier;
    callForTopTenList(tier.id);
  }

  @override
  void onInit() async {
    await callForTopTenList("1");
    await getTierList();
    super.onInit();
  }
}

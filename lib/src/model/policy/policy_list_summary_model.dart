import 'package:akij_login_app/helpers/currency_formatter.dart';

class PolicyListSummaryModel {
  String? tier;
  String? code;
  String? totalPolicyno;
  String? totalSumAssured;
  String? totalPremium;
  String? totalDuePolicies;

  PolicyListSummaryModel(
      {this.tier,
      this.code,
      this.totalPolicyno,
      this.totalSumAssured,
      this.totalPremium,
      this.totalDuePolicies});

  factory PolicyListSummaryModel.fromJson(Map<String, dynamic> json) {
    return PolicyListSummaryModel(
        tier: json['Tier'],
        code: json['Code'],
        totalPolicyno: json['TotalPolicyno'],
        totalSumAssured:
            StringCurrencyFormatter().formatTaka(json['TotalSumAssured']),
        totalPremium:
            StringCurrencyFormatter().formatTaka(json['TotalPremium']),
        totalDuePolicies: json['TotalDuePolicies']);
  }
}

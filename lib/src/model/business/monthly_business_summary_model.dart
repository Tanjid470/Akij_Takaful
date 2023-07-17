import 'package:akij_login_app/helpers/currency_formatter.dart';

class MonthlyBusinessSummaryModel {
  String? fPR;
  String? deff;
  String? single;
  String? firstYear;
  String? renewal;
  String? totalPremium;

  MonthlyBusinessSummaryModel(
      {this.fPR,
      this.deff,
      this.single,
      this.firstYear,
      this.renewal,
      this.totalPremium});

  factory MonthlyBusinessSummaryModel.fromJson(Map<String, dynamic> json) {
    return MonthlyBusinessSummaryModel(
        fPR: StringCurrencyFormatter().formatTaka(json['FPR']),
        deff: StringCurrencyFormatter().formatTaka(json['Deff']),
        single: StringCurrencyFormatter().formatTaka(json['Single']),
        firstYear: StringCurrencyFormatter().formatTaka(json['FirstYear']),
        renewal: StringCurrencyFormatter().formatTaka(json['Renewal']),
        totalPremium:
            StringCurrencyFormatter().formatTaka(json['TotalPremium']));
  }
}

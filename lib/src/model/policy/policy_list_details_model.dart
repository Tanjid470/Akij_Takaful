import 'package:akij_login_app/helpers/currency_formatter.dart';
import 'package:intl/intl.dart';

class PolicyListDetailsModel {
  String policyno;
  String proposersName;
  String entryDate;
  String tayer1;
  String comdate;
  String planno;
  String term;
  String mode;
  String sumAssured;
  String totalPremium;
  String nextDueDate;
  String businessMonth;
  String mobileNo;
  String branchname;
  String branchcode;

  PolicyListDetailsModel({
    required this.policyno,
    required this.proposersName,
    required this.entryDate,
    required this.tayer1,
    required this.comdate,
    required this.planno,
    required this.term,
    required this.mode,
    required this.sumAssured,
    required this.totalPremium,
    required this.nextDueDate,
    required this.businessMonth,
    required this.mobileNo,
    required this.branchname,
    required this.branchcode,
  });

  factory PolicyListDetailsModel.fromJson(Map<String, dynamic> json) {
    return PolicyListDetailsModel(
      policyno: json['Policyno'],
      proposersName: json['ProposersName'],
      entryDate: DateFormat('dd-MM-yyyy')
          .format(DateFormat('dd/MM/yyyy hh:mm:ss a').parse(json['EntryDate'])),
      tayer1: json['Tayer1'],
      comdate: DateFormat('dd-MM-yyyy')
          .format(DateFormat('dd/MM/yyyy hh:mm:ss a').parse(json['Comdate'])),
      planno: json['Planno'],
      term: json['Term'],
      mode: json['Mode'],
      sumAssured: StringCurrencyFormatter().formatCurr(json['SumAssured']),
      totalPremium: StringCurrencyFormatter().formatCurr(json['TotalPremium']),
      nextDueDate: DateFormat('dd-MM-yyyy').format(
          DateFormat('dd/MM/yyyy hh:mm:ss a').parse(json['NextDueDate'])),
      businessMonth: DateFormat('dd-MM-yyyy').format(
          DateFormat('dd/MM/yyyy hh:mm:ss a').parse(json['BusinessMonth'])),
      mobileNo: json['MobileNo'],
      branchname: json['Branchname'],
      branchcode: json['Branchcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Policyno': policyno,
      'ProposersName': proposersName,
      'EntryDate': entryDate,
      'Tayer1': tayer1,
      'Comdate': comdate,
      'Planno': planno,
      'Term': term,
      'Mode': mode,
      'SumAssured': sumAssured,
      'TotalPremium': totalPremium,
      'NextDueDate': nextDueDate,
      'BusinessMonth': businessMonth,
      'MobileNo': mobileNo,
      'Branchname': branchname,
      'Branchcode': branchcode,
    };
  }
}

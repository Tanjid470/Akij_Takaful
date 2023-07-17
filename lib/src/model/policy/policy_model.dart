class PolicyModel {
  final String customer;
  final String policyNo;
  final String issueDate;
  final String sumAssured;
  final String comDate;
  final String maturity;
  final String totalPremium;
  final String nextDate;
  final String mode;
  final String status;
  final String basicPrem;
  final String address;
  final List<LineItem> items;
  final String pDAB;
  final String extra;
  final String tableAndTerm;
  final String suspense;
  final String insPaid;
  final String totalPaid;
  final String riskDate;
  final String lastPremDate;
  final String dOB;
  final String age;
  final String gender;
  final String occupation;
  final String nominee;
  final String chainCode;

  PolicyModel({
    required this.customer,
    required this.policyNo,
    required this.issueDate,
    required this.sumAssured,
    required this.comDate,
    required this.maturity,
    required this.totalPremium,
    required this.nextDate,
    required this.mode,
    required this.status,
    required this.basicPrem,
    required this.address,
    required this.items,
    required this.pDAB,
    required this.extra,
    required this.tableAndTerm,
    required this.suspense,
    required this.insPaid,
    required this.totalPaid,
    required this.riskDate,
    required this.lastPremDate,
    required this.dOB,
    required this.age,
    required this.gender,
    required this.occupation,
    required this.nominee,
    required this.chainCode,
  });
}

class LineItem {
  final String instNo;
  final String oRNo;
  final String oRDate;
  final String dueDate;
  final String insPaid;
  final String pRNo;
  final String pRDate;
  final String type;
  final String oRAmount;

  const LineItem({
    required this.instNo,
    required this.oRNo,
    required this.oRDate,
    required this.dueDate,
    required this.insPaid,
    required this.pRNo,
    required this.pRDate,
    required this.type,
    required this.oRAmount,
  });
}

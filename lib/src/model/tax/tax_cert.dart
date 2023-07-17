class TaxCertificate {
  final String customer;
  final String policyNo;
  final String issueDate;
  final String year;
  final String insuranceMoney;
  final List<LineItem> items;

  TaxCertificate({
    required this.customer,
    required this.policyNo,
    required this.issueDate,
    required this.year,
    required this.insuranceMoney,
    required this.items,
  });
}

class LineItem {
  final String date;
  final String amount;

  const LineItem({
    required this.date,
    required this.amount,
  });
}

class OnlinePaymentInvoiceModel {
  final String customer;
  final String customerID;
  final String address;
  final String status;
  final String transID;
  final String transDate;
  final String policyNo;
  final String bankGate;
  final List<LineItem> items;

  OnlinePaymentInvoiceModel({
    required this.customer,
    required this.customerID,
    required this.address,
    required this.items,
    required this.status,
    required this.transDate,
    required this.transID,
    required this.policyNo,
    required this.bankGate,
  });
  double totalCost() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.amount);
  }
}

class LineItem {
  final String description;
  final double amount;
  final String status;

  LineItem(this.description, this.amount, this.status);
}

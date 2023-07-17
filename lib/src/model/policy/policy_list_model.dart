class PolicyListModel {
  int? totalPaid;
  String? userName;
  String? oRDate;
  int? ins;
  String? insPaid;
  String? pRNo;
  int? amount;
  String? billType;
  String? entryDate;
  String? pRDate;
  String? oRNO;
  String? dueDate;

  PolicyListModel(
      {this.totalPaid,
      this.userName,
      this.oRDate,
      this.ins,
      this.insPaid,
      this.pRNo,
      this.amount,
      this.billType,
      this.entryDate,
      this.pRDate,
      this.oRNO,
      this.dueDate});

  factory PolicyListModel.fromJson(Map<String, dynamic> json) {
    return PolicyListModel(
      totalPaid: json['TotalPaid'],
      userName: json['UserName'],
      oRDate: json['ORDate'],
      ins: json['Ins'],
      insPaid: json['InsPaid'],
      pRNo: json['PRNo'],
      amount: json['Amount'],
      billType: json['BillType'],
      entryDate: json['EntryDate'],
      pRDate: json['PRDate'],
      oRNO: json['ORNO'],
      dueDate: json['DueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalPaid'] = totalPaid;
    data['UserName'] = userName;
    data['ORDate'] = oRDate;
    data['Ins'] = ins;
    data['InsPaid'] = insPaid;
    data['PRNo'] = pRNo;
    data['Amount'] = amount;
    data['BillType'] = billType;
    data['EntryDate'] = entryDate;
    data['PRDate'] = pRDate;
    data['ORNO'] = oRNO;
    data['DueDate'] = dueDate;
    return data;
  }
}

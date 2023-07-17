class Tier {
  String id;
  String tayer;

  Tier({required this.id, required this.tayer});

  factory Tier.fromJson(Map<String, dynamic> json) {
    return Tier(id: json['id'], tayer: json['Tayer']);
  }
}

class TopTenModel {
  String? designation;
  Null? rdoSelectDuration;
  Null? businessMonth;
  Null? year;
  double? totalPremium;
  double? policyCount;
  String? name;
  String? contactNo;
  int? rankSL;
  Null? businessMonthFrom;
  Null? businessMonthTo;
  String? tierCode;
  Null? userName;

  TopTenModel(
      {this.designation,
      this.rdoSelectDuration,
      this.businessMonth,
      this.year,
      this.totalPremium,
      this.policyCount,
      this.name,
      this.contactNo,
      this.rankSL,
      this.businessMonthFrom,
      this.businessMonthTo,
      this.tierCode,
      this.userName});

  TopTenModel.fromJson(Map<String, dynamic> json) {
    designation = json['Designation'];
    rdoSelectDuration = json['rdoSelectDuration'];
    businessMonth = json['BusinessMonth'];
    year = json['Year'];
    totalPremium = json['TotalPremium'];
    policyCount = json['PolicyCount'];
    name = json['Name'];
    contactNo = json['ContactNo'];
    rankSL = json['RankSL'];
    businessMonthFrom = json['BusinessMonthFrom'];
    businessMonthTo = json['BusinessMonthTo'];
    tierCode = json['TierCode'];
    userName = json['UserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Designation'] = designation;
    data['rdoSelectDuration'] = rdoSelectDuration;
    data['BusinessMonth'] = businessMonth;
    data['Year'] = year;
    data['TotalPremium'] = totalPremium;
    data['PolicyCount'] = policyCount;
    data['Name'] = name;
    data['ContactNo'] = contactNo;
    data['RankSL'] = rankSL;
    data['BusinessMonthFrom'] = businessMonthFrom;
    data['BusinessMonthTo'] = businessMonthTo;
    data['TierCode'] = tierCode;
    data['UserName'] = userName;
    return data;
  }
}

class PolicyInfoModel {
  String? policyNo;
  String? name;
  String? address;
  String? nomineeNameAgeRelation;
  String? installmentNo;
  String? basic;
  String? mode;
  String? riskDate;
  String? nextDueDate;
  String? lastPayDate;
  String? suspance;
  String? pRNo1;
  String? pRDate1;
  String? chain;
  int? totalPaid;
  String? maturityDate;
  String? userName;
  int? ins;
  int? amount;
  String? tableAndTerm;
  String? sumassured;
  String? pDABPrem;
  String? extraPrem;
  String? totalPrem;
  String? branch;
  String? birthDate;
  String? age;
  String? pRNo1Amount;
  String? pRNo2Amount;
  String? pRNo3Amount;
  String? inwords;
  String? pdabcode;
  String? std;
  String? staffRebate;
  String? sex;
  String? madical;
  String? ageAdmitted;
  String? comdate;
  String? mobileNo;
  String? occupation;
  String? status;
  String? lastPremiumdate;

  PolicyInfoModel(
      {this.policyNo,
      this.name,
      this.address,
      this.nomineeNameAgeRelation,
      this.installmentNo,
      this.basic,
      this.mode,
      this.riskDate,
      this.nextDueDate,
      this.lastPayDate,
      this.suspance,
      this.pRNo1,
      this.pRDate1,
      this.chain,
      this.totalPaid,
      this.maturityDate,
      this.userName,
      this.ins,
      this.amount,
      this.tableAndTerm,
      this.sumassured,
      this.pDABPrem,
      this.extraPrem,
      this.totalPrem,
      this.branch,
      this.birthDate,
      this.age,
      this.pRNo1Amount,
      this.pRNo2Amount,
      this.pRNo3Amount,
      this.inwords,
      this.pdabcode,
      this.std,
      this.staffRebate,
      this.sex,
      this.madical,
      this.ageAdmitted,
      this.comdate,
      this.mobileNo,
      this.occupation,
      this.status,
      this.lastPremiumdate});

  PolicyInfoModel.fromJson(Map<String, dynamic> json) {
    policyNo = json['PolicyNo'];
    name = json['Name'];
    address = json['Address'];
    nomineeNameAgeRelation = json['NomineeNameAgeRelation'];
    installmentNo = json['InstallmentNo'];
    basic = json['Basic'];
    mode = json['Mode'];
    riskDate = json['RiskDate'];
    nextDueDate = json['NextDueDate'];
    lastPayDate = json['LastPayDate'];
    suspance = json['Suspance'];
    pRNo1 = json['PRNo1'];
    pRDate1 = json['PRDate1'];
    chain = json['Chain'];
    totalPaid = json['TotalPaid'];
    maturityDate = json['MaturityDate'];
    userName = json['UserName'];
    ins = json['Ins'];
    amount = json['Amount'];
    tableAndTerm = json['TableAndTerm'];
    sumassured = json['Sumassured'];
    pDABPrem = json['PDABPrem'];
    extraPrem = json['ExtraPrem'];
    totalPrem = json['TotalPrem'];
    branch = json['Branch'];
    birthDate = json['BirthDate'];
    age = json['Age'];
    pRNo1Amount = json['PRNo1Amount'];
    pRNo2Amount = json['PRNo2Amount'];
    pRNo3Amount = json['PRNo3Amount'];
    inwords = json['Inwords'];
    pdabcode = json['pdabcode'];
    std = json['Std'];
    staffRebate = json['StaffRebate'];
    sex = json['Sex'];
    madical = json['Madical'];
    ageAdmitted = json['AgeAdmitted'];
    comdate = json['Comdate'];
    mobileNo = json['MobileNo'];
    occupation = json['Occupation'];
    status = json['Status'];
    lastPremiumdate = json['LastPremiumdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PolicyNo'] = policyNo;
    data['Name'] = name;
    data['Address'] = address;
    data['NomineeNameAgeRelation'] = nomineeNameAgeRelation;
    data['InstallmentNo'] = installmentNo;
    data['Basic'] = basic;
    data['Mode'] = mode;
    data['RiskDate'] = riskDate;
    data['NextDueDate'] = nextDueDate;
    data['LastPayDate'] = lastPayDate;
    data['Suspance'] = suspance;
    data['PRNo1'] = pRNo1;
    data['PRDate1'] = pRDate1;
    data['Chain'] = chain;
    data['TotalPaid'] = totalPaid;
    data['MaturityDate'] = maturityDate;
    data['UserName'] = userName;
    data['Ins'] = ins;
    data['Amount'] = amount;
    data['TableAndTerm'] = tableAndTerm;
    data['Sumassured'] = sumassured;
    data['PDABPrem'] = pDABPrem;
    data['ExtraPrem'] = extraPrem;
    data['TotalPrem'] = totalPrem;
    data['Branch'] = branch;
    data['BirthDate'] = birthDate;
    data['Age'] = age;
    data['PRNo1Amount'] = pRNo1Amount;
    data['PRNo2Amount'] = pRNo2Amount;
    data['PRNo3Amount'] = pRNo3Amount;
    data['Inwords'] = inwords;
    data['pdabcode'] = pdabcode;
    data['Std'] = std;
    data['StaffRebate'] = staffRebate;
    data['Sex'] = sex;
    data['Madical'] = madical;
    data['AgeAdmitted'] = ageAdmitted;
    data['Comdate'] = comdate;
    data['MobileNo'] = mobileNo;
    data['Occupation'] = occupation;
    data['Status'] = status;
    data['LastPremiumdate'] = lastPremiumdate;
    return data;
  }
}

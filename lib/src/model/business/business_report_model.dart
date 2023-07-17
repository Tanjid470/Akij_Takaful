class BusinessReportModel {
  int? id;
  String? code;
  String? name;
  double? fPR;
  double? def;
  double? firstYear;
  double? renewal;
  double? total;
  double? target;
  int? targetAchivePercentage;
  String? bMName;
  int? fPR1;
  int? def1;
  Null? firstYear1;
  int? renewal1;
  Null? total1;
  Null? bMName1;
  int? fPR2;
  int? def2;
  Null? firstYear2;
  int? renewal2;
  Null? total2;
  Null? bMName2;
  int? fPR3;
  int? def3;
  Null? firstYear3;
  Null? renewal3;
  Null? total3;
  Null? bMName3;
  String? workStation;
  String? workStationName;
  Null? sCCode;
  Null? sCName;
  Null? adminDesig;
  Null? supDesig;
  Null? supCode;
  Null? projectCode;
  Null? projectName;
  String? username;
  String? businessMonth;

  BusinessReportModel(
      {this.id,
      this.code,
      this.name,
      this.fPR,
      this.def,
      this.firstYear,
      this.renewal,
      this.total,
      this.target,
      this.targetAchivePercentage,
      this.bMName,
      this.fPR1,
      this.def1,
      this.firstYear1,
      this.renewal1,
      this.total1,
      this.bMName1,
      this.fPR2,
      this.def2,
      this.firstYear2,
      this.renewal2,
      this.total2,
      this.bMName2,
      this.fPR3,
      this.def3,
      this.firstYear3,
      this.renewal3,
      this.total3,
      this.bMName3,
      this.workStation,
      this.workStationName,
      this.sCCode,
      this.sCName,
      this.adminDesig,
      this.supDesig,
      this.supCode,
      this.projectCode,
      this.projectName,
      this.username,
      this.businessMonth});

  BusinessReportModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
    fPR = json['FPR'];
    def = json['Def'];
    firstYear = json['FirstYear'];
    renewal = json['Renewal'];
    total = json['Total'];
    target = json['Target'];
    targetAchivePercentage = json['TargetAchivePercentage'];
    bMName = json['BMName'];
    fPR1 = json['FPR1'];
    def1 = json['Def1'];
    firstYear1 = json['FirstYear1'];
    renewal1 = json['Renewal1'];
    total1 = json['Total1'];
    bMName1 = json['BMName1'];
    fPR2 = json['FPR2'];
    def2 = json['Def2'];
    firstYear2 = json['FirstYear2'];
    renewal2 = json['Renewal2'];
    total2 = json['Total2'];
    bMName2 = json['BMName2'];
    fPR3 = json['FPR3'];
    def3 = json['Def3'];
    firstYear3 = json['FirstYear3'];
    renewal3 = json['Renewal3'];
    total3 = json['Total3'];
    bMName3 = json['BMName3'];
    workStation = json['WorkStation'];
    workStationName = json['WorkStationName'];
    sCCode = json['SCCode'];
    sCName = json['SCName'];
    adminDesig = json['AdminDesig'];
    supDesig = json['SupDesig'];
    supCode = json['SupCode'];
    projectCode = json['ProjectCode'];
    projectName = json['ProjectName'];
    username = json['Username'];
    businessMonth = json['BusinessMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Code'] = code;
    data['Name'] = name;
    data['FPR'] = fPR;
    data['Def'] = def;
    data['FirstYear'] = firstYear;
    data['Renewal'] = renewal;
    data['Total'] = total;
    data['Target'] = target;
    data['TargetAchivePercentage'] = targetAchivePercentage;
    data['BMName'] = bMName;
    data['FPR1'] = fPR1;
    data['Def1'] = def1;
    data['FirstYear1'] = firstYear1;
    data['Renewal1'] = renewal1;
    data['Total1'] = total1;
    data['BMName1'] = bMName1;
    data['FPR2'] = fPR2;
    data['Def2'] = def2;
    data['FirstYear2'] = firstYear2;
    data['Renewal2'] = renewal2;
    data['Total2'] = total2;
    data['BMName2'] = bMName2;
    data['FPR3'] = fPR3;
    data['Def3'] = def3;
    data['FirstYear3'] = firstYear3;
    data['Renewal3'] = renewal3;
    data['Total3'] = total3;
    data['BMName3'] = bMName3;
    data['WorkStation'] = workStation;
    data['WorkStationName'] = workStationName;
    data['SCCode'] = sCCode;
    data['SCName'] = sCName;
    data['AdminDesig'] = adminDesig;
    data['SupDesig'] = supDesig;
    data['SupCode'] = supCode;
    data['ProjectCode'] = projectCode;
    data['ProjectName'] = projectName;
    data['Username'] = username;
    data['BusinessMonth'] = businessMonth;
    return data;
  }
}

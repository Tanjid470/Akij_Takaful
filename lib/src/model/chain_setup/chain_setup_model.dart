class ChainSetupModel {
  String? tayer;
  String? tayerCode;
  String? name;
  String? contructNo;
  String? officeCode;
  String? branchName;
  String? tayer1;
  String? tayer2;
  String? tayer3;
  String? tayer4;
  String? tayer5;
  String? tayer6;
  String? tayer7;

  ChainSetupModel(
      {this.tayer,
      this.tayerCode,
      this.name,
      this.contructNo,
      this.officeCode,
      this.branchName,
      this.tayer1,
      this.tayer2,
      this.tayer3,
      this.tayer4,
      this.tayer5,
      this.tayer6,
      this.tayer7});

  factory ChainSetupModel.fromJson(Map<String, dynamic> json) {
    return ChainSetupModel(
      tayer: json['Tayer'],
      tayerCode: json['TayerCode'],
      name: json['Name'],
      contructNo: json['ContructNo'],
      officeCode: json['OfficeCode'],
      branchName: json['BranchName'],
      tayer1: json['Tayer1'],
      tayer2: json['Tayer2'],
      tayer3: json['Tayer3'],
      tayer4: json['Tayer4'],
      tayer5: json['Tayer5'],
      tayer6: json['Tayer6'],
      tayer7: json['Tayer7'],
    );
  }
}

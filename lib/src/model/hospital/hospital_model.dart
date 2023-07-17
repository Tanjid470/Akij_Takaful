class HospitalModel {
  int? id;
  String? hospitalCode;
  String? hospitalName;
  String? contractNo;
  String? contractDate;
  String? hospitalAddress;
  String? dist;
  String? distName;
  String? policeStation;
  String? policeStationName;
  String? hospitalEmail;
  String? hospitalPhone;
  String? hospitalArea;
  String? signatoryName;
  String? signatoryDesignation;
  String? facilities;

  HospitalModel(
      {this.id,
      this.hospitalCode,
      this.hospitalName,
      this.contractNo,
      this.contractDate,
      this.hospitalAddress,
      this.dist,
      this.distName,
      this.policeStation,
      this.policeStationName,
      this.hospitalEmail,
      this.hospitalPhone,
      this.hospitalArea,
      this.signatoryName,
      this.signatoryDesignation,
      this.facilities});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    hospitalCode = json['HospitalCode'];
    hospitalName = json['HospitalName'];
    contractNo = json['ContractNo'];
    contractDate = json['ContractDate'];
    hospitalAddress = json['HospitalAddress'];
    dist = json['Dist'];
    distName = json['DistName'];
    policeStation = json['PoliceStation'];
    policeStationName = json['PoliceStationName'];
    hospitalEmail = json['HospitalEmail'];
    hospitalPhone = json['HospitalPhone'];
    hospitalArea = json['HospitalArea'];
    signatoryName = json['SignatoryName'];
    signatoryDesignation = json['SignatoryDesignation'];
    facilities = json['Facilities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['HospitalCode'] = hospitalCode;
    data['HospitalName'] = hospitalName;
    data['ContractNo'] = contractNo;
    data['ContractDate'] = contractDate;
    data['HospitalAddress'] = hospitalAddress;
    data['Dist'] = dist;
    data['DistName'] = distName;
    data['PoliceStation'] = policeStation;
    data['PoliceStationName'] = policeStationName;
    data['HospitalEmail'] = hospitalEmail;
    data['HospitalPhone'] = hospitalPhone;
    data['HospitalArea'] = hospitalArea;
    data['SignatoryName'] = signatoryName;
    data['SignatoryDesignation'] = signatoryDesignation;
    data['Facilities'] = facilities;
    return data;
  }
}

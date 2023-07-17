class Office {
  String officeCode;
  String officeName;

  Office({required this.officeCode, required this.officeName});

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
        officeCode: json['OfficeCode'], officeName: json['OfficeName']);
  }
}

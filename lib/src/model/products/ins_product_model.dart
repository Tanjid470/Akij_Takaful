class InsProductModel {
  String table;
  String name;
  double minSumAssured;
  double maxSumAssured;
  double startAge;
  double maxMaturityAge;

  InsProductModel(
      {required this.table,
      required this.name,
      required this.minSumAssured,
      required this.maxSumAssured,
      required this.startAge,
      required this.maxMaturityAge});

  factory InsProductModel.fromJson(Map<String, dynamic> json) {
    return InsProductModel(
        table: json['Table'],
        name: json['Name'],
        minSumAssured: json['MinSumAssured'],
        maxSumAssured: json['MaxSumAssured'],
        startAge: json['StartAge'],
        maxMaturityAge: json['MaxMaturityAge']);
  }
}

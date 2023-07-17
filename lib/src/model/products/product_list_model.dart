class ProductListModel {
  String? table;
  String? name;
  double? minSumAssured;
  double? maxSumAssured;
  double? startAge;
  double? maxMaturityAge;

  ProductListModel(
      {this.table,
      this.name,
      this.minSumAssured,
      this.maxSumAssured,
      this.startAge,
      this.maxMaturityAge});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    table = json['Table'];
    name = json['Name'];
    minSumAssured = json['MinSumAssured'];
    maxSumAssured = json['MaxSumAssured'];
    startAge = json['StartAge'];
    maxMaturityAge = json['MaxMaturityAge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Table'] = table;
    data['Name'] = name;
    data['MinSumAssured'] = minSumAssured;
    data['MaxSumAssured'] = maxSumAssured;
    data['StartAge'] = startAge;
    data['MaxMaturityAge'] = maxMaturityAge;
    return data;
  }
}

class ExtraModel {
  final String table;
  final String name;

  ExtraModel({required this.table, required this.name});

  factory ExtraModel.fromJson(Map<String, dynamic> json) {
    return ExtraModel(
      table: json['Table'],
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Table': table,
      'Name': name,
    };
  }
}

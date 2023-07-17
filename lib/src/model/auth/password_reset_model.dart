import 'dart:convert';

List<PasswordResetModel> passwordResetModelsFromJson(String str) =>
    List<PasswordResetModel>.from(
        json.decode(str).map((x) => PasswordResetModel.fromJson(x)));

String passwordResetModelsToJson(List<PasswordResetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PasswordResetModel {
  String? key;
  String? value;

  PasswordResetModel({
    this.key,
    this.value,
  });

  factory PasswordResetModel.fromJson(Map<String, dynamic> json) =>
      PasswordResetModel(
        key: json["Key"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Key": key,
        "Value": value,
      };
}

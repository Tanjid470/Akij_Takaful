class ModeModel {
  final String value;
  final String text;

  ModeModel({required this.value, required this.text});

  factory ModeModel.fromJson(Map<String, dynamic> json) {
    return ModeModel(
      value: json['Value'],
      text: json['Text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Value': value,
      'Text': text,
    };
  }
}

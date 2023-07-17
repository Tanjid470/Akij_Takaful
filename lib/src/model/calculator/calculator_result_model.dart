class CalculatorResultModel {
  double? basicBremium;
  double? totalPremium;
  double? aDDBPremium;
  double? aDBPremium;
  Null? errorCode;
  Null? errorMsg;

  CalculatorResultModel(
      {this.basicBremium,
      this.totalPremium,
      this.aDDBPremium,
      this.aDBPremium,
      this.errorCode,
      this.errorMsg});

  factory CalculatorResultModel.fromJson(Map<String, dynamic> json) {
    return CalculatorResultModel(
      basicBremium: json['BasicBremium'],
      totalPremium: json['TotalPremium'],
      aDDBPremium: json['ADDBPremium'],
      aDBPremium: json['ADBPremium'],
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BasicBremium': basicBremium,
      'TotalPremium': totalPremium,
      'ADDBPremium': aDDBPremium,
      'ADBPremium': aDBPremium,
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}

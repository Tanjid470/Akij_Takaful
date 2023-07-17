class TermsModel {
  String term;

  TermsModel({required this.term});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(term: json['Term']);
  }
}

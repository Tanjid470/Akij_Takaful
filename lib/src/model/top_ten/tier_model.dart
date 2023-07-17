// class TierModel {
//   String? id;
//   String? tayer;

//   TierModel({this.id, this.tayer});

//   TierModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tayer = json['Tayer'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['Tayer'] = tayer;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final zoneModel = zoneModelFromJson(jsonString);

import 'dart:convert';

TierModel tierModelFromJson(String str) => TierModel.fromJson(json.decode(str));

String tierModelToJson(TierModel data) => json.encode(data.toJson());

class TierModel {
  TierModel({
    this.tierData,
  });

  List<Tier>? tierData;

  factory TierModel.fromJson(Map<String, dynamic> json) => TierModel(
        tierData:
            List<Tier>.from(json["tierData"].map((x) => Tier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tierData": List<dynamic>.from(tierData!.map((x) => x.toJson())),
      };
}

class Tier {
  Tier({
    this.id,
    this.tayer,
  });

  int? id;
  String? tayer;

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
        id: json["id"],
        tayer: json["Tayer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tayer": tayer,
      };
}

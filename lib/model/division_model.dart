// To parse this JSON data, do
//
//     final divisionModel = divisionModelFromJson(jsonString);

import 'dart:convert';
List<DivisionModel> divisionModelFromJson(String str) {
  final jsonData = json.decode(str) as List<dynamic>; // Decode as List<dynamic>
  return List<DivisionModel>.from(
    jsonData.map((x) => DivisionModel.fromJson(x as Map<String, dynamic>))
  );
}

String divisionModelToJson(List<DivisionModel> data) => json.encode(
  List<dynamic>.from(data.map((x) => x.toJson()))
);
class DivisionModel {
  String divisionSlNo;
  String divisionName;
  String status;
  String addBy;
  DateTime addTime;
  dynamic updateBy;
  dynamic updateTime;

  DivisionModel({
    required this.divisionSlNo,
    required this.divisionName,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
  });

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
    divisionSlNo: json["Division_SlNo"] as String,
    divisionName: json["Division_Name"] as String,
    status: json["status"] as String,
    addBy: json["AddBy"] as String,
    addTime: DateTime.parse(json["AddTime"] as String),
    updateBy: json["UpdateBy"],
    updateTime: json["UpdateTime"],
  );

  Map<String, dynamic> toJson() => {
    "Division_SlNo": divisionSlNo,
    "Division_Name": divisionName,
    "status": status,
    "AddBy": addBy,
    "AddTime": addTime.toIso8601String(),
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
  };
}

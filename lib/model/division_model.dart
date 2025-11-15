import 'dart:convert';

List<DivisionModel> divisionModelFromJson(String str) {
  final jsonData = json.decode(str) as List<dynamic>;
  return List<DivisionModel>.from(
    jsonData.map((x) => DivisionModel.fromJson(x as Map<String, dynamic>)),
  );
}

String divisionModelToJson(List<DivisionModel> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class DivisionModel {
  dynamic id;
  String name;
  int createdBy;
  dynamic updatedBy;
  String ipAddress;
  int branchId;
  dynamic deletedAt;
  DateTime createdAt;
  dynamic updatedAt;

  DivisionModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.updatedBy,
    required this.ipAddress,
    required this.branchId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
        id: json["id"] as int,
        name: json["name"] as String,
        createdBy: json["created_by"] as int,
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"] as String,
        branchId: json["branch_id"] as int,
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ip_address": ipAddress,
        "branch_id": branchId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}















// // To parse this JSON data, do
// //
// //     final divisionModel = divisionModelFromJson(jsonString);

// import 'dart:convert';
// List<DivisionModel> divisionModelFromJson(String str) {
//   final jsonData = json.decode(str) as List<dynamic>; // Decode as List<dynamic>
//   return List<DivisionModel>.from(
//     jsonData.map((x) => DivisionModel.fromJson(x as Map<String, dynamic>))
//   );
// }

// String divisionModelToJson(List<DivisionModel> data) => json.encode(
//   List<dynamic>.from(data.map((x) => x.toJson()))
// );
// class DivisionModel {
//   String divisionSlNo;
//   String divisionName;
//   String status;
//   String addBy;
//   DateTime addTime;
//   dynamic updateBy;
//   dynamic updateTime;

//   DivisionModel({
//     required this.divisionSlNo,
//     required this.divisionName,
//     required this.status,
//     required this.addBy,
//     required this.addTime,
//     required this.updateBy,
//     required this.updateTime,
//   });

//   factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
//     divisionSlNo: json["Division_SlNo"] as String,
//     divisionName: json["Division_Name"] as String,
//     status: json["status"] as String,
//     addBy: json["AddBy"] as String,
//     addTime: DateTime.parse(json["AddTime"] as String),
//     updateBy: json["UpdateBy"],
//     updateTime: json["UpdateTime"],
//   );

//   Map<String, dynamic> toJson() => {
//     "Division_SlNo": divisionSlNo,
//     "Division_Name": divisionName,
//     "status": status,
//     "AddBy": addBy,
//     "AddTime": addTime.toIso8601String(),
//     "UpdateBy": updateBy,
//     "UpdateTime": updateTime,
//   };
// }

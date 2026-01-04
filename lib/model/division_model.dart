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
  dynamic createdBy;
  dynamic updatedBy;
  String ipAddress;
  dynamic branchId;
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
        id: json["id"],
        name: json["name"] as String,
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"] as String,
        branchId: json["branch_id"],
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

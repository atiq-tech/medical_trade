import 'dart:convert';

List<DistrictModel> districtModelFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData is List) {
    return List<DistrictModel>.from(
        jsonData.map((x) => DistrictModel.fromJson(x as Map<String, dynamic>)));
  } else {
    throw Exception('Expected a list of districts');
  }
}

String districtModelToJson(List<DistrictModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

enum Status { ACTIVE, INACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "inactive": Status.INACTIVE,
});

class DistrictModel {
  dynamic id;
  String areaName;
  dynamic createdBy;
  dynamic updatedBy;
  String ipAddress;
  dynamic branchId;
  dynamic deletedAt;
  DateTime createdAt;
  dynamic updatedAt;

  DistrictModel({
    required this.id,
    required this.areaName,
    required this.createdBy,
    required this.updatedBy,
    required this.ipAddress,
    required this.branchId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json["id"],
        areaName: json["area_name"] as String? ?? '',
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"] as String? ?? '',
        branchId: json["branch_id"] ,
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area_name": areaName,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ip_address": ipAddress,
        "branch_id": branchId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = map.map((k, v) => MapEntry(v, k));

  T? fromJson(String? key) => key != null ? map[key] : null;
  String? toJson(T value) => reverseMap[value];
}

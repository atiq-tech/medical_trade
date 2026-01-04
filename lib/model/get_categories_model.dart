import 'dart:convert';

// Decode JSON to Model List
List<GetCategoryModel> getCategoryModelFromJson(String str) =>
    List<GetCategoryModel>.from(json.decode(str).map((x) => GetCategoryModel.fromJson(x)));

// Encode Model List to JSON
String getCategoryModelToJson(List<GetCategoryModel> data) =>json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCategoryModel {
  String id;
  String name;
  String description;
  String createdBy;
  String updatedBy;
  String ipAddress;
  String branchId;
  String deletedAt;
  String createdAt;
  String updatedAt;

  GetCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.ipAddress,
    required this.branchId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ip_address": ipAddress,
        "branch_id": branchId,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

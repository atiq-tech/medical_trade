import 'dart:convert';

class NewCategoryModel {
    final dynamic id;
    final dynamic name;
    final dynamic image;
    final dynamic description;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic ipAddress;
    final dynamic branchId;
    final dynamic deletedAt;
    final dynamic createdAt;
    final dynamic updatedAt;

    NewCategoryModel({
        required this.id,
        required this.name,
        required this.image,
        required this.description,
        required this.createdBy,
        required this.updatedBy,
        required this.ipAddress,
        required this.branchId,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory NewCategoryModel.fromJson(String str) => NewCategoryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NewCategoryModel.fromMap(Map<String, dynamic> json) => NewCategoryModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
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


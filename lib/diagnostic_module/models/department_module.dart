import 'dart:convert';

class DepartmentModel {
    final dynamic id;
    final dynamic name;
    final dynamic useFor;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic branchId;

    DepartmentModel({
        required this.id,
        required this.name,
        required this.useFor,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.branchId,
    });

    factory DepartmentModel.fromJson(String str) => DepartmentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DepartmentModel.fromMap(Map<String, dynamic> json) => DepartmentModel(
        id: json["id"],
        name: json["name"],
        useFor: json["use_for"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "use_for": useFor,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "branch_id": branchId,
    };
}

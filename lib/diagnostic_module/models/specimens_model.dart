import 'dart:convert';

class SpecimensModel {
    final dynamic id;
    final dynamic specimenName;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic branchId;

    SpecimensModel({
        required this.id,
        required this.specimenName,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.branchId,
    });

    factory SpecimensModel.fromJson(String str) => SpecimensModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SpecimensModel.fromMap(Map<String, dynamic> json) => SpecimensModel(
        id: json["id"],
        specimenName: json["specimen_name"],
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
        "specimen_name": specimenName,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "branch_id": branchId,
    };
}

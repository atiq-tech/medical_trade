import 'dart:convert';

class AccountsModel {
    final dynamic id;
    final dynamic accountCode;
    final dynamic accountName;
    final dynamic remark;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic status;
    final dynamic branchId;

    AccountsModel({
        required this.id,
        required this.accountCode,
        required this.accountName,
        required this.remark,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.status,
        required this.branchId,
    });

    factory AccountsModel.fromJson(String str) => AccountsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AccountsModel.fromMap(Map<String, dynamic> json) => AccountsModel(
        id: json["id"],
        accountCode: json["account_code"],
        accountName: json["account_name"],
        remark: json["remark"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        status: json["status"],
        branchId: json["branch_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "account_code": accountCode,
        "account_name": accountName,
        "remark": remark,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "status": status,
        "branch_id": branchId,
    };
}

import 'dart:convert';

class BankAccountModel {
    final dynamic id;
    final dynamic accountName;
    final dynamic accountNumber;
    final dynamic accountType;
    final dynamic bankName;
    final dynamic branchName;
    final dynamic remark;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic status;
    final dynamic branchId;

    BankAccountModel({
        required this.id,
        required this.accountName,
        required this.accountNumber,
        required this.accountType,
        required this.bankName,
        required this.branchName,
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

    factory BankAccountModel.fromJson(String str) => BankAccountModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BankAccountModel.fromMap(Map<String, dynamic> json) => BankAccountModel(
        id: json["id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        accountType: json["account_type"],
        bankName: json["bank_name"],
        branchName: json["branch_name"],
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
        "account_name": accountName,
        "account_number": accountNumber,
        "account_type": accountType,
        "bank_name": bankName,
        "branch_name": branchName,
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

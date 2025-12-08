import 'dart:convert';

class BankTransactionModel {
    final dynamic id;
    final dynamic transactionNumber;
    final dynamic bankAccountId;
    final dynamic transactionDate;
    final dynamic transactionType;
    final dynamic amount;
    final dynamic remark;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic status;
    final dynamic branchId;
    final Bank? bank;

    BankTransactionModel({
        required this.id,
        required this.transactionNumber,
        required this.bankAccountId,
        required this.transactionDate,
        required this.transactionType,
        required this.amount,
        required this.remark,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.status,
        required this.branchId,
        required this.bank,
    });

    factory BankTransactionModel.fromJson(String str) => BankTransactionModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BankTransactionModel.fromMap(Map<String, dynamic> json) => BankTransactionModel(
        id: json["id"],
        transactionNumber: json["transaction_number"],
        bankAccountId: json["bank_account_id"],
        transactionDate: json["transaction_date"],
        transactionType: json["transaction_type"],
        amount: json["amount"],
        remark: json["remark"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        status: json["status"],
        branchId: json["branch_id"],
        bank: json["bank"] == null || json["bank"] == "null" ? null : Bank.fromMap(json["bank"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "transaction_number": transactionNumber,
        "bank_account_id": bankAccountId,
        "transaction_date": transactionDate,
        "transaction_type": transactionType,
        "amount": amount,
        "remark": remark,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "status": status,
        "branch_id": branchId,
        "bank": bank!.toJson(),
    };
}

class Bank {
    final dynamic id;
    final dynamic accountName;
    final dynamic accountNumber;
    final dynamic bankName;

    Bank({
        required this.id,
        required this.accountName,
        required this.accountNumber,
        required this.bankName,
    });

    factory Bank.fromJson(String str) => Bank.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Bank.fromMap(Map<String, dynamic> json) => Bank(
        id: json["id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
    };
}

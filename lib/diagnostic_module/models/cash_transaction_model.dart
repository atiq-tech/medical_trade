import 'dart:convert';

class CashTransactionModel {
    final dynamic id;
    final dynamic transactionNumber;
    final dynamic transactionDate;
    final dynamic accountId;
    final dynamic bankAccountId;
    final dynamic transactionType;
    final dynamic paymentType;
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
    final Account? account;

    CashTransactionModel({
        required this.id,
        required this.transactionNumber,
        required this.transactionDate,
        required this.accountId,
        required this.bankAccountId,
        required this.transactionType,
        required this.paymentType,
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
        required this.account,
    });

    factory CashTransactionModel.fromJson(String str) => CashTransactionModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CashTransactionModel.fromMap(Map<String, dynamic> json) => CashTransactionModel(
        id: json["id"],
        transactionNumber: json["transaction_number"],
        transactionDate: json["transaction_date"],
        accountId: json["account_id"],
        bankAccountId: json["bank_account_id"],
        transactionType: json["transaction_type"],
        paymentType: json["payment_type"],
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
        account: json["account"] == null || json["account"] == "null" ? null : Account.fromMap(json["account"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "transaction_number": transactionNumber,
        "transaction_date": transactionDate,
        "account_id": accountId,
        "bank_account_id": bankAccountId,
        "transaction_type": transactionType,
        "payment_type": paymentType,
        "amount": amount,
        "remark": remark,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "status": status,
        "branch_id": branchId,
        "bank": bank!.toJson(),
        "account": account!.toJson(),
    };
}

class Account {
    final dynamic id;
    final dynamic accountCode;
    final dynamic accountName;

    Account({
        required this.id,
        required this.accountCode,
        required this.accountName,
    });

    factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        accountCode: json["account_code"],
        accountName: json["account_name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "account_code": accountCode,
        "account_name": accountName,
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

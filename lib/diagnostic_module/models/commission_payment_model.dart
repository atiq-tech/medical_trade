import 'dart:convert';

class CommissionPaymentModel {
    final dynamic id;
    final dynamic transactionNumber;
    final dynamic referenceId;
    final dynamic referenceType;
    final dynamic paymentDate;
    final dynamic transactionType;
    final dynamic paymentType;
    final dynamic accountId;
    final dynamic amount;
    final dynamic due;
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
    final Agent? agent;

    CommissionPaymentModel({
        required this.id,
        required this.transactionNumber,
        required this.referenceId,
        required this.referenceType,
        required this.paymentDate,
        required this.transactionType,
        required this.paymentType,
        required this.accountId,
        required this.amount,
        required this.due,
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
        required this.agent,
    });

    factory CommissionPaymentModel.fromJson(String str) => CommissionPaymentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CommissionPaymentModel.fromMap(Map<String, dynamic> json) => CommissionPaymentModel(
        id: json["id"],
        transactionNumber: json["transaction_number"],
        referenceId: json["reference_id"],
        referenceType: json["reference_type"],
        paymentDate: json["payment_date"],
        transactionType: json["transaction_type"],
        paymentType: json["payment_type"],
        accountId: json["account_id"],
        amount: json["amount"],
        due: json["due"],
        remark: json["remark"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        status: json["status"],
        branchId: json["branch_id"],
        bank: json["bank"] == null|| json["bank"] == "null" ? null : Bank.fromMap(json["bank"]),
        agent: json["agent"] == null|| json["agent"] == "null" ? null :  Agent.fromMap(json["agent"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "transaction_number": transactionNumber,
        "reference_id": referenceId,
        "reference_type": referenceType,
        "payment_date": paymentDate,
        "transaction_type": transactionType,
        "payment_type": paymentType,
        "account_id": accountId,
        "amount": amount,
        "due": due,
        "remark": remark,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "status": status,
        "branch_id": branchId,
        "bank": bank!.toMap(),
        "agent": agent!.toMap(),
    };
}

class Agent {
    final dynamic id;
    final dynamic agentCode;
    final dynamic name;

    Agent({
        required this.id,
        required this.agentCode,
        required this.name,
    });

    factory Agent.fromJson(String str) => Agent.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Agent.fromMap(Map<String, dynamic> json) => Agent(
        id: json["id"],
        agentCode: json["agent_code"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "agent_code": agentCode,
        "name": name,
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

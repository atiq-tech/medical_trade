import 'dart:convert';

class PatientPaymentModel {
    final dynamic id;
    final dynamic transactionNumber;
    final dynamic patientId;
    final dynamic admissionId;
    final dynamic paymentDate;
    final dynamic transactionType;
    final dynamic paymentType;
    final dynamic accountId;
    final dynamic discount;
    final dynamic amount;
    final dynamic previousDue;
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

    PatientPaymentModel({
        required this.id,
        required this.transactionNumber,
        required this.patientId,
        required this.admissionId,
        required this.paymentDate,
        required this.transactionType,
        required this.paymentType,
        required this.accountId,
        required this.discount,
        required this.amount,
        required this.previousDue,
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

    factory PatientPaymentModel.fromJson(String str) => PatientPaymentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PatientPaymentModel.fromMap(Map<String, dynamic> json) => PatientPaymentModel(
        id: json["id"],
        transactionNumber: json["transaction_number"],
        patientId: json["patient_id"],
        admissionId: json["admission_id"],
        paymentDate: json["payment_date"],
        transactionType: json["transaction_type"],
        paymentType: json["payment_type"],
        accountId: json["account_id"],
        discount: json["discount"],
        amount: json["amount"],
        previousDue: json["previous_due"],
        remark: json["remark"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        status: json["status"],
        branchId: json["branch_id"],
        bank: json["bank"] == null || json["bank"] == "null" ? null : Bank.fromJson(json["bank"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "transaction_number": transactionNumber,
        "patient_id": patientId,
        "admission_id": admissionId,
        "payment_date": paymentDate,
        "transaction_type": transactionType,
        "payment_type": paymentType,
        "account_id": accountId,
        "discount": discount,
        "amount": amount,
        "previous_due": previousDue,
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

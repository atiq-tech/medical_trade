import 'dart:convert';

class TestEntryModel {
    final dynamic id;
    final dynamic testCode;
    final dynamic roomNumber;
    final dynamic name;
    final dynamic specimenId;
    final dynamic price;
    final dynamic commissionPercent;
    final dynamic commissionAmount;
    final dynamic day;
    final dynamic hour;
    final dynamic minute;
    final dynamic template;
    final dynamic remark;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic branchId;

    TestEntryModel({
        required this.id,
        required this.testCode,
        required this.roomNumber,
        required this.name,
        required this.specimenId,
        required this.price,
        required this.commissionPercent,
        required this.commissionAmount,
        required this.day,
        required this.hour,
        required this.minute,
        required this.template,
        required this.remark,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.branchId,
    });

    factory TestEntryModel.fromJson(String str) => TestEntryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TestEntryModel.fromMap(Map<String, dynamic> json) => TestEntryModel(
        id: json["id"],
        testCode: json["test_code"],
        roomNumber: json["room_number"],
        name: json["name"],
        specimenId: json["specimen_id"],
        price: json["price"],
        commissionPercent: json["commission_percent"],
        commissionAmount: json["commission_amount"],
        day: json["day"],
        hour: json["hour"],
        minute: json["minute"],
        template: json["template"],
        remark: json["remark"],
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
        "test_code": testCode,
        "room_number": roomNumber,
        "name": name,
        "specimen_id": specimenId,
        "price": price,
        "commission_percent": commissionPercent,
        "commission_amount": commissionAmount,
        "day": day,
        "hour": hour,
        "minute": minute,
        "template": template,
        "remark": remark,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "branch_id": branchId,
    };
}

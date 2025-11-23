import 'dart:convert';

class AgentsModel {
    final dynamic id;
    final dynamic agentCode;
    final dynamic name;
    final dynamic mobile;
    final dynamic address;
    final dynamic remark;
    final dynamic image;
    final dynamic commissionPercent;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic status;
    final dynamic branchId;

    AgentsModel({
        required this.id,
        required this.agentCode,
        required this.name,
        required this.mobile,
        required this.address,
        required this.remark,
        required this.image,
        required this.commissionPercent,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.status,
        required this.branchId,
    });

    factory AgentsModel.fromJson(String str) => AgentsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AgentsModel.fromMap(Map<String, dynamic> json) => AgentsModel(
        id: json["id"],
        agentCode: json["agent_code"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        remark: json["remark"],
        image: json["image"],
        commissionPercent: json["commission_percent"],
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
        "agent_code": agentCode,
        "name": name,
        "mobile": mobile,
        "address": address,
        "remark": remark,
        "image": image,
        "commission_percent": commissionPercent,
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

import 'dart:convert';

class AvailableSlotsModel {
    final dynamic id;
    final dynamic doctorId;
    final dynamic slotName;
    final dynamic startTime;
    final dynamic endTime;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic branchId;
    final dynamic displayText;
    final dynamic doctorText;

    AvailableSlotsModel({
        required this.id,
        required this.doctorId,
        required this.slotName,
        required this.startTime,
        required this.endTime,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.branchId,
        required this.displayText,
        required this.doctorText,
    });

    factory AvailableSlotsModel.fromJson(String str) => AvailableSlotsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AvailableSlotsModel.fromMap(Map<String, dynamic> json) => AvailableSlotsModel(
        id: json["id"],
        doctorId: json["doctor_id"],
        slotName: json["slot_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
        displayText: json["display_text"],
        doctorText: json["doctor_text"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "doctor_id": doctorId,
        "slot_name": slotName,
        "start_time": startTime,
        "end_time": endTime,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "branch_id": branchId,
        "display_text": displayText,
        "doctor_text": doctorText,
    };
}

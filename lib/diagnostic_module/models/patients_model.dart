import 'dart:convert';

class PatientsModel {
    final dynamic id;
    final dynamic patientCode;
    final dynamic name;
    final dynamic nid;
    final dynamic mobile;
    final dynamic patientType;
    final dynamic gender;
    final dynamic type;
    final dynamic dateOfBirth;
    final dynamic address;
    final dynamic remark;
    final dynamic image;
    final dynamic currentBedId;
    final dynamic isAdmitted;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic status;
    final dynamic branchId;

    PatientsModel({
        required this.id,
        required this.patientCode,
        required this.name,
        required this.nid,
        required this.mobile,
        required this.patientType,
        required this.gender,
        required this.type,
        required this.dateOfBirth,
        required this.address,
        required this.remark,
        required this.image,
        required this.currentBedId,
        required this.isAdmitted,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.status,
        required this.branchId,
    });

    factory PatientsModel.fromJson(String str) => PatientsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PatientsModel.fromMap(Map<String, dynamic> json) => PatientsModel(
        id: json["id"],
        patientCode: json["patient_code"],
        name: json["name"],
        nid: json["nid"],
        mobile: json["mobile"],
        patientType: json["patient_type"],
        gender: json["gender"],
        type: json["type"],
        dateOfBirth: json["date_of_birth"],
        address: json["address"],
        remark: json["remark"],
        image: json["image"],
        currentBedId: json["current_bed_id"],
        isAdmitted: json["is_admitted"],
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
        "patient_code": patientCode,
        "name": name,
        "nid": nid,
        "mobile": mobile,
        "patient_type": patientType,
        "gender": gender,
        "type": type,
        "date_of_birth": dateOfBirth,
        "address": address,
        "remark": remark,
        "image": image,
        "current_bed_id": currentBedId,
        "is_admitted": isAdmitted,
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

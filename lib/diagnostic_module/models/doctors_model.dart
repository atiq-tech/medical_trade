import 'dart:convert';

class DoctorsModel {
    final dynamic id;
    final dynamic doctorCode;
    final dynamic departmentId;
    final dynamic name;
    final dynamic nameBangla;
    final dynamic mobile;
    final dynamic educationLevel;
    final dynamic educationLevelBangla;
    final dynamic address;
    final dynamic remark;
    final dynamic image;
    final dynamic fees;
    final dynamic commissionAmount;
    final dynamic commissionPercent;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic status;
    final dynamic branchId;
    final Department department;

    DoctorsModel({
        required this.id,
        required this.doctorCode,
        required this.departmentId,
        required this.name,
        required this.nameBangla,
        required this.mobile,
        required this.educationLevel,
        required this.educationLevelBangla,
        required this.address,
        required this.remark,
        required this.image,
        required this.fees,
        required this.commissionAmount,
        required this.commissionPercent,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.status,
        required this.branchId,
        required this.department,
    });

    factory DoctorsModel.fromJson(String str) => DoctorsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DoctorsModel.fromMap(Map<String, dynamic> json) => DoctorsModel(
        id: json["id"],
        doctorCode: json["doctor_code"],
        departmentId: json["department_id"],
        name: json["name"],
        nameBangla: json["name_bangla"],
        mobile: json["mobile"],
        educationLevel: json["education_level"],
        educationLevelBangla: json["education_level_bangla"],
        address: json["address"],
        remark: json["remark"],
        image: json["image"],
        fees: json["fees"],
        commissionAmount: json["commission_amount"],
        commissionPercent: json["commission_percent"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        status: json["status"],
        branchId: json["branch_id"],
        department: Department.fromMap(json["department"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "doctor_code": doctorCode,
        "department_id": departmentId,
        "name": name,
        "name_bangla": nameBangla,
        "mobile": mobile,
        "education_level": educationLevel,
        "education_level_bangla": educationLevelBangla,
        "address": address,
        "remark": remark,
        "image": image,
        "fees": fees,
        "commission_amount": commissionAmount,
        "commission_percent": commissionPercent,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "status": status,
        "branch_id": branchId,
        "department": department.toMap(),
    };
}

class Department {
    final dynamic id;
    final dynamic name;

    Department({
        required this.id,
        required this.name,
    });

    factory Department.fromJson(String str) => Department.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Department.fromMap(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
















// import 'dart:convert';

// class DoctorsModel {
//     final dynamic id;
//     final dynamic doctorCode;
//     final dynamic departmentId;
//     final dynamic name;
//     final dynamic nameBangla;
//     final dynamic mobile;
//     final dynamic educationLevel;
//     final dynamic educationLevelBangla;
//     final dynamic address;
//     final dynamic remark;
//     final dynamic image;
//     final dynamic fees;
//     final dynamic commissionAmount;
//     final dynamic commissionPercent;
//     final dynamic createdBy;
//     final dynamic updatedBy;
//     final dynamic createdAt;
//     final dynamic updatedAt;
//     final dynamic deletedAt;
//     final dynamic ipAddress;
//     final dynamic status;
//     final dynamic branchId;

//     DoctorsModel({
//         required this.id,
//         required this.doctorCode,
//         required this.departmentId,
//         required this.name,
//         required this.nameBangla,
//         required this.mobile,
//         required this.educationLevel,
//         required this.educationLevelBangla,
//         required this.address,
//         required this.remark,
//         required this.image,
//         required this.fees,
//         required this.commissionAmount,
//         required this.commissionPercent,
//         required this.createdBy,
//         required this.updatedBy,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.deletedAt,
//         required this.ipAddress,
//         required this.status,
//         required this.branchId,
//     });

//     factory DoctorsModel.fromJson(String str) => DoctorsModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory DoctorsModel.fromMap(Map<String, dynamic> json) => DoctorsModel(
//         id: json["id"],
//         doctorCode: json["doctor_code"],
//         departmentId: json["department_id"],
//         name: json["name"],
//         nameBangla: json["name_bangla"],
//         mobile: json["mobile"],
//         educationLevel: json["education_level"],
//         educationLevelBangla: json["education_level_bangla"],
//         address: json["address"],
//         remark: json["remark"],
//         image: json["image"],
//         fees: json["fees"],
//         commissionAmount: json["commission_amount"],
//         commissionPercent: json["commission_percent"],
//         createdBy: json["created_by"],
//         updatedBy: json["updated_by"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         deletedAt: json["deleted_at"],
//         ipAddress: json["ip_address"],
//         status: json["status"],
//         branchId: json["branch_id"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "doctor_code": doctorCode,
//         "department_id": departmentId,
//         "name": name,
//         "name_bangla": nameBangla,
//         "mobile": mobile,
//         "education_level": educationLevel,
//         "education_level_bangla": educationLevelBangla,
//         "address": address,
//         "remark": remark,
//         "image": image,
//         "fees": fees,
//         "commission_amount": commissionAmount,
//         "commission_percent": commissionPercent,
//         "created_by": createdBy,
//         "updated_by": updatedBy,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "deleted_at": deletedAt,
//         "ip_address": ipAddress,
//         "status": status,
//         "branch_id": branchId,
//     };
// }

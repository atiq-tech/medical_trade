import 'dart:convert';

class AppointmentsModel {
    final dynamic id;
    final dynamic tokenNumber;
    final dynamic appointmentDate;
    final dynamic appointmentTime;
    final dynamic serialNumber;
    final dynamic departmentId;
    final dynamic doctorId;
    final dynamic patientId;
    final dynamic referenceId;
    final dynamic fees;
    final dynamic commissionPercent;
    final dynamic commissionAmount;
    final dynamic discountAmount;
    final dynamic discountPercent;
    final dynamic subtotal;
    final dynamic advance;
    final dynamic due;
    final dynamic commissionBy;
    final dynamic patientWeight;
    final dynamic patientHeight;
    final dynamic bloodPressure;
    final dynamic primaryProblem;
    final dynamic remark;
    final dynamic isShift;
    final dynamic status;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final dynamic ipAddress;
    final dynamic branchId;
    final dynamic slotId;
    final Agent department;
    final Agent doctor;
    final Agent patient;
    final Agent agent;
    final Slot slot;

    AppointmentsModel({
        required this.id,
        required this.tokenNumber,
        required this.appointmentDate,
        required this.appointmentTime,
        required this.serialNumber,
        required this.departmentId,
        required this.doctorId,
        required this.patientId,
        required this.referenceId,
        required this.fees,
        required this.commissionPercent,
        required this.commissionAmount,
        required this.discountAmount,
        required this.discountPercent,
        required this.subtotal,
        required this.advance,
        required this.due,
        required this.commissionBy,
        required this.patientWeight,
        required this.patientHeight,
        required this.bloodPressure,
        required this.primaryProblem,
        required this.remark,
        required this.isShift,
        required this.status,
        required this.createdBy,
        required this.updatedBy,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.ipAddress,
        required this.branchId,
        required this.slotId,
        required this.department,
        required this.doctor,
        required this.patient,
        required this.agent,
        required this.slot,
    });

    factory AppointmentsModel.fromJson(String str) => AppointmentsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AppointmentsModel.fromMap(Map<String, dynamic> json) => AppointmentsModel(
        id: json["id"],
        tokenNumber: json["token_number"],
        appointmentDate: json["appointment_date"],
        appointmentTime: json["appointment_time"],
        serialNumber: json["serial_number"],
        departmentId: json["department_id"],
        doctorId: json["doctor_id"],
        patientId: json["patient_id"],
        referenceId: json["reference_id"],
        fees: json["fees"],
        commissionPercent: json["commission_percent"],
        commissionAmount: json["commission_amount"],
        discountAmount: json["discount_amount"],
        discountPercent: json["discount_percent"],
        subtotal: json["subtotal"],
        advance: json["advance"],
        due: json["due"],
        commissionBy: json["commission_by"],
        patientWeight: json["patient_weight"],
        patientHeight: json["patient_height"],
        bloodPressure: json["blood_pressure"],
        primaryProblem: json["primary_problem"],
        remark: json["remark"],
        isShift: json["is_shift"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
        slotId: json["slot_id"],
        department: Agent.fromMap(json["department"]),
        doctor: Agent.fromMap(json["doctor"]),
        patient: Agent.fromMap(json["patient"]),
        agent: Agent.fromMap(json["agent"]),
        slot: Slot.fromMap(json["slot"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "token_number": tokenNumber,
        "appointment_date": appointmentDate,
        "appointment_time": appointmentTime,
        "serial_number": serialNumber,
        "department_id": departmentId,
        "doctor_id": doctorId,
        "patient_id": patientId,
        "reference_id": referenceId,
        "fees": fees,
        "commission_percent": commissionPercent,
        "commission_amount": commissionAmount,
        "discount_amount": discountAmount,
        "discount_percent": discountPercent,
        "subtotal": subtotal,
        "advance": advance,
        "due": due,
        "commission_by": commissionBy,
        "patient_weight": patientWeight,
        "patient_height": patientHeight,
        "blood_pressure": bloodPressure,
        "primary_problem": primaryProblem,
        "remark": remark,
        "is_shift": isShift,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "ip_address": ipAddress,
        "branch_id": branchId,
        "slot_id": slotId,
        "department": department.toJson(),
        "doctor": doctor.toJson(),
        "patient": patient.toJson(),
        "agent": agent.toJson(),
        "slot": slot.toJson(),
    };
}

class Agent {
    final dynamic id;
    final dynamic name;

    Agent({
        required this.id,
        required this.name,
    });

    factory Agent.fromJson(String str) => Agent.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Agent.fromMap(Map<String, dynamic> json) => Agent(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}

class Slot {
    final dynamic id;
    final dynamic slotName;
    final dynamic startTime;
    final dynamic endTime;

    Slot({
        required this.id,
        required this.slotName,
        required this.startTime,
        required this.endTime,
    });

    factory Slot.fromJson(String str) => Slot.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Slot.fromMap(Map<String, dynamic> json) => Slot(
        id: json["id"],
        slotName: json["slot_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "slot_name": slotName,
        "start_time": startTime,
        "end_time": endTime,
    };
}

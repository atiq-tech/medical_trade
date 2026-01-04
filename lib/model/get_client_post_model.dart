import 'dart:convert';

List<GetClientpostModel> getClientpostModelFromJson(String str) => List<GetClientpostModel>.from(json.decode(str).map((x) => GetClientpostModel.fromJson(x)));

String getClientpostModelToJson(List<GetClientpostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetClientpostModel {
    String clientSlNo;
    String clientCode;
    String machineName;
    String machinePrice;
    String machineModel;
    String machineCondition;
    String origin;
    String mobile;
    String description;
    String divisionId;
    String districtId;
    String image;
    String status;
    String addBy;
    DateTime addTime;
    String updateBy;
    String updateTime;
    String clientBranchid;
    String divisionName;
    List<Division> divisions;
    List<District> districts;

    GetClientpostModel({
        required this.clientSlNo,
        required this.clientCode,
        required this.machineName,
        required this.machinePrice,
        required this.machineModel,
        required this.machineCondition,
        required this.origin,
        required this.mobile,
        required this.description,
        required this.divisionId,
        required this.districtId,
        required this.image,
        required this.status,
        required this.addBy,
        required this.addTime,
        required this.updateBy,
        required this.updateTime,
        required this.clientBranchid,
        required this.divisionName,
        required this.divisions,
        required this.districts,
    });

    factory GetClientpostModel.fromJson(Map<String, dynamic> json) => GetClientpostModel(
        clientSlNo: json["Client_SlNo"],
        clientCode: json["Client_Code"],
        machineName: json["Machine_Name"],
        machinePrice: json["Machine_Price"],
        machineModel: json["Machine_Model"],
        machineCondition: json["Machine_condition"],
        origin: json["origin"],
        mobile: json["mobile"],
        description: json["description"],
        divisionId: json["division_id"],
        districtId: json["district_id"],
        image: json["image"],
        status: json["status"],
        addBy: json["AddBy"],
        addTime: DateTime.parse(json["AddTime"]),
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
        clientBranchid: json["Client_branchid"],
        divisionName: json["division_name"],
        divisions: List<Division>.from(json["divisions"].map((x) => Division.fromJson(x))),
        districts: List<District>.from(json["districts"].map((x) => District.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Client_SlNo": clientSlNo,
        "Client_Code": clientCode,
        "Machine_Name": machineName,
        "Machine_Price": machinePrice,
        "Machine_Model": machineModel,
        "Machine_condition": machineCondition,
        "origin": origin,
        "mobile": mobile,
        "description": description,
        "division_id": divisionId,
        "district_id": districtId,
        "image": image,
        "status": status,
        "AddBy": addBy,
        "AddTime": addTime.toIso8601String(),
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
        "Client_branchid": clientBranchid,
        "division_name": divisionName,
        "divisions": List<dynamic>.from(divisions.map((x) => x.toJson())),
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
    };
}

class District {
    String districtSlNo;
    String districtName;
    String status;
    dynamic addBy;
    dynamic addTime;
    dynamic updateBy;
    dynamic updateTime;

    District({
        required this.districtSlNo,
        required this.districtName,
        required this.status,
        required this.addBy,
        required this.addTime,
        required this.updateBy,
        required this.updateTime,
    });

    factory District.fromJson(Map<String, dynamic> json) => District(
        districtSlNo: json["District_SlNo"],
        districtName: json["District_Name"],
        status: json["status"],
        addBy: json["AddBy"],
        addTime: json["AddTime"],
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
    );

    Map<String, dynamic> toJson() => {
        "District_SlNo": districtSlNo,
        "District_Name": districtName,
        "status": status,
        "AddBy": addBy,
        "AddTime": addTime,
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
    };
}

class Division {
    String divisionSlNo;
    String divisionName;
    String status;
    String addBy;
    DateTime addTime;
    dynamic updateBy;
    dynamic updateTime;

    Division({
        required this.divisionSlNo,
        required this.divisionName,
        required this.status,
        required this.addBy,
        required this.addTime,
        required this.updateBy,
        required this.updateTime,
    });

    factory Division.fromJson(Map<String, dynamic> json) => Division(
        divisionSlNo: json["Division_SlNo"],
        divisionName: json["Division_Name"],
        status: json["status"],
        addBy: json["AddBy"],
        addTime: DateTime.parse(json["AddTime"]),
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
    );

    Map<String, dynamic> toJson() => {
        "Division_SlNo": divisionSlNo,
        "Division_Name": divisionName,
        "status": status,
        "AddBy": addBy,
        "AddTime": addTime.toIso8601String(),
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
    };
}

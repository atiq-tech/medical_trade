class GetSalesOldMachineModel {
  String? clientSlNo;
  String? clientCode;
  String? machineName;
  String? machinePrice;
  String? machineModel;
  String? machineCondition;
  String? origin;
  String? mobile;
  String? description;
  String? divisionId;
  String? districtId;
  String? upazila;
  Null image;
  String? validityDate;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? clientBranchid;
  List<Images>? images;

  GetSalesOldMachineModel(
      {this.clientSlNo,
      this.clientCode,
      this.machineName,
      this.machinePrice,
      this.machineModel,
      this.machineCondition,
      this.origin,
      this.mobile,
      this.description,
      this.divisionId,
      this.districtId,
      this.upazila,
      this.image,
      this.validityDate,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.clientBranchid,
      this.images});

  GetSalesOldMachineModel.fromJson(Map<String, dynamic> json) {
    clientSlNo = json['Client_SlNo'];
    clientCode = json['Client_Code'];
    machineName = json['Machine_Name'];
    machinePrice = json['Machine_Price'];
    machineModel = json['Machine_Model'];
    machineCondition = json['Machine_condition'];
    origin = json['origin'];
    mobile = json['mobile'];
    description = json['description'];
    divisionId = json['division_id'];
    districtId = json['district_id'];
    upazila = json['upazila'];
    image = json['image'];
    validityDate = json['validity_date'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    clientBranchid = json['Client_branchid'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Client_SlNo'] = this.clientSlNo;
    data['Client_Code'] = this.clientCode;
    data['Machine_Name'] = this.machineName;
    data['Machine_Price'] = this.machinePrice;
    data['Machine_Model'] = this.machineModel;
    data['Machine_condition'] = this.machineCondition;
    data['origin'] = this.origin;
    data['mobile'] = this.mobile;
    data['description'] = this.description;
    data['division_id'] = this.divisionId;
    data['district_id'] = this.districtId;
    data['upazila'] = this.upazila;
    data['image'] = this.image;
    data['validity_date'] = this.validityDate;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Client_branchid'] = this.clientBranchid;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? clientpostImage;

  Images({this.clientpostImage});

  Images.fromJson(Map<String, dynamic> json) {
    clientpostImage = json['Clientpost_Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Clientpost_Image'] = this.clientpostImage;
    return data;
  }
}

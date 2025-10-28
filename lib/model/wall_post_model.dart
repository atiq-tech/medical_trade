class WallPostModel {
  String? wallSlNo;
  String? wallCode;
  String? title;
  String? price;
  String? model;
  String? condition;
  String? origin;
  String? mobile;
  String? description;
  String? divisionId;
  String? districtId;
  String? upazila;
  String? image;
  String? validityDate;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? wallBranchid;
  List<Wallgallery>? wallgallery;
  List<Divisions>? divisions;
  List<Districts>? districts;

  WallPostModel(
      {this.wallSlNo,
      this.wallCode,
      this.title,
      this.price,
      this.model,
      this.condition,
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
      this.wallBranchid,
      this.wallgallery,
      this.divisions,
      this.districts});

  WallPostModel.fromJson(Map<String, dynamic> json) {
    wallSlNo = json['Wall_SlNo'];
    wallCode = json['Wall_Code'];
    title = json['title'];
    price = json['Price'];
    model = json['Model'];
    condition = json['condition'];
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
    wallBranchid = json['Wall_branchid'];
    if (json['wallgallery'] != null) {
      wallgallery = <Wallgallery>[];
      json['wallgallery'].forEach((v) {
        wallgallery!.add(new Wallgallery.fromJson(v));
      });
    }
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(new Divisions.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Wall_SlNo'] = this.wallSlNo;
    data['Wall_Code'] = this.wallCode;
    data['title'] = this.title;
    data['Price'] = this.price;
    data['Model'] = this.model;
    data['condition'] = this.condition;
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
    data['Wall_branchid'] = this.wallBranchid;
    if (this.wallgallery != null) {
      data['wallgallery'] = this.wallgallery!.map((v) => v.toJson()).toList();
    }
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v.toJson()).toList();
    }
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallgallery {
  String? wallPostImage;

  Wallgallery({this.wallPostImage});

  Wallgallery.fromJson(Map<String, dynamic> json) {
    wallPostImage = json['WallPost_Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WallPost_Image'] = this.wallPostImage;
    return data;
  }
}

class Divisions {
  String? divisionSlNo;
  String? divisionName;
  String? status;
  String? addBy;
  String? addTime;
  Null? updateBy;
  Null? updateTime;

  Divisions(
      {this.divisionSlNo,
      this.divisionName,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime});

  Divisions.fromJson(Map<String, dynamic> json) {
    divisionSlNo = json['Division_SlNo'];
    divisionName = json['Division_Name'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Division_SlNo'] = this.divisionSlNo;
    data['Division_Name'] = this.divisionName;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    return data;
  }
}

class Districts {
  String? districtSlNo;
  String? districtName;
  String? status;
  Null? addBy;
  Null? addTime;
  Null? updateBy;
  Null? updateTime;

  Districts(
      {this.districtSlNo,
      this.districtName,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime});

  Districts.fromJson(Map<String, dynamic> json) {
    districtSlNo = json['District_SlNo'];
    districtName = json['District_Name'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['District_SlNo'] = this.districtSlNo;
    data['District_Name'] = this.districtName;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    return data;
  }
}

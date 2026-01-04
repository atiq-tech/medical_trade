class WallPostModel {
  int? id;
  String? wallPostId;
  String? title;
  String? price;
  String? model;
  String? condition;
  String? origin;
  List<int>? divisionId;
  List<int>? areaId;
  String? upazilla;
  String? mobile;
  String? validityDate;
  String? description;
  String? image;
  List<String>? images;
  int? createdBy;
  int? updatedBy;
  String? ipAddress;
  int? branchId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  WallPostModel({
    this.id,
    this.wallPostId,
    this.title,
    this.price,
    this.model,
    this.condition,
    this.origin,
    this.divisionId,
    this.areaId,
    this.upazilla,
    this.mobile,
    this.validityDate,
    this.description,
    this.image,
    this.images,
    this.createdBy,
    this.updatedBy,
    this.ipAddress,
    this.branchId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  WallPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wallPostId = json['wall_post_id'];
    title = json['title'];
    price = json['price'];
    model = json['model'];
    condition = json['condition'];
    origin = json['origin'];

    // List<int>
    divisionId = json['division_id'] != null
        ? List<int>.from(json['division_id'])
        : [];

    areaId = json['area_id'] != null
        ? List<int>.from(json['area_id'])
        : [];

    upazilla = json['upazilla'];
    mobile = json['mobile'];
    validityDate = json['validity_date'];
    description = json['description'];
    image = json['image'];

    // List<String>
    images = json['images'] != null
        ? List<String>.from(json['images'])
        : [];

    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ipAddress = json['ip_address'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['wall_post_id'] = wallPostId;
    data['title'] = title;
    data['price'] = price;
    data['model'] = model;
    data['condition'] = condition;
    data['origin'] = origin;
    data['division_id'] = divisionId;
    data['area_id'] = areaId;
    data['upazilla'] = upazilla;
    data['mobile'] = mobile;
    data['validity_date'] = validityDate;
    data['description'] = description;
    data['image'] = image;
    data['images'] = images;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['ip_address'] = ipAddress;
    data['branch_id'] = branchId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}

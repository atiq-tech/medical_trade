class ClientPostModel {
  final dynamic id;
  final dynamic customerPostId;
  final dynamic machineName;
  final dynamic price;
  final dynamic model;
  final dynamic condition;
  final dynamic origin;
  final dynamic division;
  final List<dynamic> areaId;
  final dynamic upazilla;
  final dynamic mobile;
  final dynamic validityDate;
  final dynamic description;
  final dynamic image;
  final List<dynamic> images;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic ipAddress;
  final dynamic branchId;
  final dynamic deletedAt;
  final dynamic createdAt;
  final dynamic updatedAt;

  ClientPostModel({
    required this.id,
    required this.customerPostId,
    required this.machineName,
    required this.price,
    required this.model,
    required this.condition,
    required this.origin,
    required this.division,
    required this.areaId,
    required this.upazilla,
    required this.mobile,
    required this.validityDate,
    required this.description,
    required this.image,
    required this.images,
    required this.createdBy,
    required this.updatedBy,
    required this.ipAddress,
    required this.branchId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClientPostModel.fromMap(Map<String, dynamic> json) => ClientPostModel(
        id: json["id"],
        customerPostId: json["customer_post_id"],
        machineName: json["machine_name"],
        price: json["price"],
        model: json["model"],
        condition: json["condition"],
        origin: json["origin"],
        division: json["division"],
        areaId: List<dynamic>.from(json["area_id"] ?? []),
        upazilla: json["upazilla"],
        mobile: json["mobile"],
        validityDate: json["validity_date"],
        description: json["description"],
        image: json["image"],
        images: List<dynamic>.from(json["images"] ?? []),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

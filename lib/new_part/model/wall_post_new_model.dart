import 'dart:convert';

class WallPostNewModel {
    final dynamic id;
    final dynamic wallPostId;
    final dynamic title;
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

    WallPostNewModel({
        required this.id,
        required this.wallPostId,
        required this.title,
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

    factory WallPostNewModel.fromJson(String str) => WallPostNewModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WallPostNewModel.fromMap(Map<String, dynamic> json) => WallPostNewModel(
        id: json["id"],
        wallPostId: json["wall_post_id"],
        title: json["title"],
        price: json["price"],
        model: json["model"],
        condition: json["condition"],
        origin: json["origin"],
        division: json["division"],
        areaId: List<dynamic>.from(json["area_id"].map((x) => x)),
        upazilla: json["upazilla"],
        mobile: json["mobile"],
        validityDate:json["validity_date"],
        description: json["description"],
        image: json["image"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "wall_post_id": wallPostId,
        "title": title,
        "price": price,
        "model": model,
        "condition": condition,
        "origin": origin,
        "division": division,
        "area_id": List<dynamic>.from(areaId.map((x) => x)),
        "upazilla": upazilla,
        "mobile": mobile,
        "validity_date": validityDate,
        "description": description,
        "image": image,
        "images": List<dynamic>.from(images.map((x) => x)),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ip_address": ipAddress,
        "branch_id": branchId,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}














//==my==code===
// import 'dart:convert';

// class WallPostNewModel {
//     final dynamic id;
//     final dynamic wallPostId;
//     final dynamic title;
//     final dynamic price;
//     final dynamic model;
//     final dynamic condition;
//     final dynamic origin;
//     final dynamic division;
//     final List<dynamic> areaId;
//     final dynamic upazilla;
//     final dynamic mobile;
//     final dynamic validityDate;
//     final dynamic description;
//     final dynamic image;
//     final dynamic createdBy;
//     final dynamic updatedBy;
//     final dynamic ipAddress;
//     final dynamic branchId;
//     final dynamic deletedAt;
//     final dynamic createdAt;
//     final dynamic updatedAt;

//     WallPostNewModel({
//         required this.id,
//         required this.wallPostId,
//         required this.title,
//         required this.price,
//         required this.model,
//         required this.condition,
//         required this.origin,
//         required this.division,
//         required this.areaId,
//         required this.upazilla,
//         required this.mobile,
//         required this.validityDate,
//         required this.description,
//         required this.image,
//         required this.createdBy,
//         required this.updatedBy,
//         required this.ipAddress,
//         required this.branchId,
//         required this.deletedAt,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory WallPostNewModel.fromJson(String str) => WallPostNewModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory WallPostNewModel.fromMap(Map<String, dynamic> json) => WallPostNewModel(
//         id: json["id"],
//         wallPostId: json["wall_post_id"],
//         title: json["title"],
//         price: json["price"],
//         model: json["model"],
//         condition: json["condition"],
//         origin: json["origin"],
//         division: json["division"],
//         areaId: List<dynamic>.from(json["area_id"].map((x) => x)),
//         upazilla: json["upazilla"],
//         mobile: json["mobile"],
//         validityDate: json["validity_date"],
//         description: json["description"],
//         image: json["image"],
//         createdBy: json["created_by"],
//         updatedBy: json["updated_by"],
//         ipAddress: json["ip_address"],
//         branchId: json["branch_id"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "wall_post_id": wallPostId,
//         "title": title,
//         "price": price,
//         "model": model,
//         "condition": condition,
//         "origin": origin,
//         "division": division,
//         "area_id": List<dynamic>.from(areaId.map((x) => x)),
//         "upazilla": upazilla,
//         "mobile": mobile,
//         "validity_date": validityDate,
//         "description": description,
//         "image": image,
//         "created_by": createdBy,
//         "updated_by": updatedBy,
//         "ip_address": ipAddress,
//         "branch_id": branchId,
//         "deleted_at": deletedAt,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

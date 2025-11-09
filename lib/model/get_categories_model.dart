import 'dart:convert';

// Decode JSON to Model List
List<GetCategoryModel> getCategoryModelFromJson(String str) =>
    List<GetCategoryModel>.from(json.decode(str).map((x) => GetCategoryModel.fromJson(x)));

// Encode Model List to JSON
String getCategoryModelToJson(List<GetCategoryModel> data) =>json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCategoryModel {
  String id;
  String name;
  String description;
  String createdBy;
  String updatedBy;
  String ipAddress;
  String branchId;
  String deletedAt;
  String createdAt;
  String updatedAt;

  GetCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.ipAddress,
    required this.branchId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ipAddress: json["ip_address"],
        branchId: json["branch_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ip_address": ipAddress,
        "branch_id": branchId,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}





















///===old===
// // To parse this JSON data, do
// //
// //     final getCategoryModel = getCategoryModelFromJson(jsonString);

// import 'dart:convert';

// List<GetCategoryModel> getCategoryModelFromJson(String str) => List<GetCategoryModel>.from(json.decode(str).map((x) => GetCategoryModel.fromJson(x)));

// String getCategoryModelToJson(List<GetCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class GetCategoryModel {
//     String productCategorySlNo;
//     String productCategoryName;
//     String productCategoryDescription;
//     String status;
//     String addBy;
//     String addTime;
//     String updateBy;
//     String updateTime;
//     String categoryBranchid;

//     GetCategoryModel({
//         required this.productCategorySlNo,
//         required this.productCategoryName,
//         required this.productCategoryDescription,
//         required this.status,
//         required this.addBy,
//         required this.addTime,
//         required this.updateBy,
//         required this.updateTime,
//         required this.categoryBranchid,
//     });

//     factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
//         productCategorySlNo: json["ProductCategory_SlNo"],
//         productCategoryName: json["ProductCategory_Name"],
//         productCategoryDescription: json["ProductCategory_Description"],
//         status: json["status"],
//         addBy: json["AddBy"],
//         addTime: json["AddTime"],
//         updateBy: json["UpdateBy"],
//         updateTime: json["UpdateTime"],
//         categoryBranchid: json["category_branchid"],
//     );

//     Map<String, dynamic> toJson() => {
//         "ProductCategory_SlNo": productCategorySlNo,
//         "ProductCategory_Name": productCategoryName,
//         "ProductCategory_Description": productCategoryDescription,
//         "status": status,
//         "AddBy": addBy,
//         "AddTime": addTime,
//         "UpdateBy": updateBy,
//         "UpdateTime": updateTime,
//         "category_branchid": categoryBranchid,
//     };
// }

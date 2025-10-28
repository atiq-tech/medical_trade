// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

List<GetCategoryModel> getCategoryModelFromJson(String str) => List<GetCategoryModel>.from(json.decode(str).map((x) => GetCategoryModel.fromJson(x)));

String getCategoryModelToJson(List<GetCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCategoryModel {
    String productCategorySlNo;
    String productCategoryName;
    String productCategoryDescription;
    String status;
    String addBy;
    String addTime;
    String updateBy;
    String updateTime;
    String categoryBranchid;

    GetCategoryModel({
        required this.productCategorySlNo,
        required this.productCategoryName,
        required this.productCategoryDescription,
        required this.status,
        required this.addBy,
        required this.addTime,
        required this.updateBy,
        required this.updateTime,
        required this.categoryBranchid,
    });

    factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
        productCategorySlNo: json["ProductCategory_SlNo"],
        productCategoryName: json["ProductCategory_Name"],
        productCategoryDescription: json["ProductCategory_Description"],
        status: json["status"],
        addBy: json["AddBy"],
        addTime: json["AddTime"],
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
        categoryBranchid: json["category_branchid"],
    );

    Map<String, dynamic> toJson() => {
        "ProductCategory_SlNo": productCategorySlNo,
        "ProductCategory_Name": productCategoryName,
        "ProductCategory_Description": productCategoryDescription,
        "status": status,
        "AddBy": addBy,
        "AddTime": addTime,
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
        "category_branchid": categoryBranchid,
    };
}

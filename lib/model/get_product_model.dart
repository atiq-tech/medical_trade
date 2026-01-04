import 'dart:convert';

List<GetProductModel> getProductModelFromJson(String str) =>
    List<GetProductModel>.from(json.decode(str).map((x) => GetProductModel.fromJson(x)));

String getProductModelToJson(List<GetProductModel> data) =>json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProductModel {
  String productSlNo;
  String productCode;
  String productName;
  String productCategoryId;
  Type type;
  String color;
  String brand;
  Size size;
  String vat;
  String productReOrederLevel;
  String productPurchaseRate;
  String productSellingPrice;
  String productMinimumSellingPrice;
  String productWholesaleRate;
  String oneCartunEqual;
  String isService;
  String unitId;
  Status status;
  By addBy;
  String addTime;
  By updateBy;
  String updateTime;
  String productBranchid;
  String image;
  String description;
  String productCategoryName;

  GetProductModel({
    required this.productSlNo,
    required this.productCode,
    required this.productName,
    required this.productCategoryId,
    required this.type,
    required this.color,
    required this.brand,
    required this.size,
    required this.vat,
    required this.productReOrederLevel,
    required this.productPurchaseRate,
    required this.productSellingPrice,
    required this.productMinimumSellingPrice,
    required this.productWholesaleRate,
    required this.oneCartunEqual,
    required this.isService,
    required this.unitId,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.productBranchid,
    required this.image,
    required this.description,
    required this.productCategoryName,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) =>
      GetProductModel(
        productSlNo: json["Product_SlNo"],
        productCode: json["Product_Code"],
        productName: json["Product_Name"],
        productCategoryId: json["ProductCategory_ID"],
        type: typeValues.map[json["type"]]!,
        color: json["color"],
        brand: json["brand"],
        size: sizeValues.map[json["size"]]!,
        vat: json["vat"],
        productReOrederLevel: json["Product_ReOrederLevel"],
        productPurchaseRate: json["Product_Purchase_Rate"],
        productSellingPrice: json["Product_SellingPrice"],
        productMinimumSellingPrice: json["Product_MinimumSellingPrice"],
        productWholesaleRate: json["Product_WholesaleRate"],
        oneCartunEqual: json["one_cartun_equal"],
        isService: json["is_service"],
        unitId: json["Unit_ID"],
        status: statusValues.map[json["status"]]!,
        addBy: byValues.map[json["AddBy"]]!,
        addTime: json["AddTime"],
        updateBy: byValues.map[json["UpdateBy"]]!,
        updateTime: json["UpdateTime"],
        productBranchid: json["Product_branchid"],
        image: json["image"],
        description: json["description"],
        productCategoryName: json["ProductCategory_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Product_SlNo": productSlNo,
        "Product_Code": productCode,
        "Product_Name": productName,
        "ProductCategory_ID": productCategoryId,
        "type": typeValues.reverse[type],
        "color": color,
        "brand": brand,
        "size": sizeValues.reverse[size],
        "vat": vat,
        "Product_ReOrederLevel": productReOrederLevel,
        "Product_Purchase_Rate": productPurchaseRate,
        "Product_SellingPrice": productSellingPrice,
        "Product_MinimumSellingPrice": productMinimumSellingPrice,
        "Product_WholesaleRate": productWholesaleRate,
        "one_cartun_equal": oneCartunEqual,
        "is_service": isService,
        "Unit_ID": unitId,
        "status": statusValues.reverse[status],
        "AddBy": byValues.reverse[addBy],
        "AddTime": addTime,
        "UpdateBy": byValues.reverse[updateBy],
        "UpdateTime": updateTime,
        "Product_branchid": productBranchid,
        "image": image,
        "description": description,
        "ProductCategory_Name": productCategoryName,
      };
}

enum By { ADMIN, EMPTY }

final byValues = EnumValues({"Admin": By.ADMIN, "": By.EMPTY});

enum Size { NA }

final sizeValues = EnumValues({"na": Size.NA});

enum Status { A }

final statusValues = EnumValues({"a": Status.A});

enum Type { NEW, OLD }

final typeValues = EnumValues({"new": Type.NEW, "old": Type.OLD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

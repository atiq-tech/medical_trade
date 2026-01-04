class ProductModel {
  String? productSlNo;
  String? productCode;
  String? productName;
  String? productCategoryID;
  String? type;
  String? color;
  String? brand;
  String? size;
  String? vat;
  String? productReOrederLevel;
  String? productPurchaseRate;
  String? productSellingPrice;
  String? productMinimumSellingPrice;
  String? productWholesaleRate;
  String? oneCartunEqual;
  String? isService;
  String? unitID;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? productBranchid;
  String? image;
  String? description;
  String? productCategoryName;
  List<ProductGallery>? productGallery;

  ProductModel(
      {this.productSlNo,
      this.productCode,
      this.productName,
      this.productCategoryID,
      this.type,
      this.color,
      this.brand,
      this.size,
      this.vat,
      this.productReOrederLevel,
      this.productPurchaseRate,
      this.productSellingPrice,
      this.productMinimumSellingPrice,
      this.productWholesaleRate,
      this.oneCartunEqual,
      this.isService,
      this.unitID,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.productBranchid,
      this.image,
      this.description,
      this.productCategoryName,
      this.productGallery});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productSlNo = json['Product_SlNo'];
    productCode = json['Product_Code'];
    productName = json['Product_Name'];
    productCategoryID = json['ProductCategory_ID'];
    type = json['type'];
    color = json['color'];
    brand = json['brand'];
    size = json['size'];
    vat = json['vat'];
    productReOrederLevel = json['Product_ReOrederLevel'];
    productPurchaseRate = json['Product_Purchase_Rate'];
    productSellingPrice = json['Product_SellingPrice'];
    productMinimumSellingPrice = json['Product_MinimumSellingPrice'];
    productWholesaleRate = json['Product_WholesaleRate'];
    oneCartunEqual = json['one_cartun_equal'];
    isService = json['is_service'];
    unitID = json['Unit_ID'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    productBranchid = json['Product_branchid'];
    image = json['image'];
    description = json['description'];
    productCategoryName = json['ProductCategory_Name'];
    if (json['productGallery'] != null) {
      productGallery = <ProductGallery>[];
      json['productGallery'].forEach((v) {
        productGallery!.add(new ProductGallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product_SlNo'] = this.productSlNo;
    data['Product_Code'] = this.productCode;
    data['Product_Name'] = this.productName;
    data['ProductCategory_ID'] = this.productCategoryID;
    data['type'] = this.type;
    data['color'] = this.color;
    data['brand'] = this.brand;
    data['size'] = this.size;
    data['vat'] = this.vat;
    data['Product_ReOrederLevel'] = this.productReOrederLevel;
    data['Product_Purchase_Rate'] = this.productPurchaseRate;
    data['Product_SellingPrice'] = this.productSellingPrice;
    data['Product_MinimumSellingPrice'] = this.productMinimumSellingPrice;
    data['Product_WholesaleRate'] = this.productWholesaleRate;
    data['one_cartun_equal'] = this.oneCartunEqual;
    data['is_service'] = this.isService;
    data['Unit_ID'] = this.unitID;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Product_branchid'] = this.productBranchid;
    data['image'] = this.image;
    data['description'] = this.description;
    data['ProductCategory_Name'] = this.productCategoryName;
    if (this.productGallery != null) {
      data['productGallery'] =
          this.productGallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductGallery {
  String? productImage;
  ProductGallery({this.productImage});
  ProductGallery.fromJson(Map<String, dynamic> json) {
    productImage = json['Product_Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product_Image'] = this.productImage;
    return data;
  }
}

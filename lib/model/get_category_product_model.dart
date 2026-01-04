class GetCategoryProductModel {
  String? id;
  String? productId;
  String? productCategoryId;
  String? productName;
  String? price;
  String? image;
  List<String>? images;
  String? type;
  String? description;
  String? createdBy;
  String? updatedBy;
  String? ipAddress;
  String? branchId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? categoryName; 

  GetCategoryProductModel({
    this.id,
    this.productId,
    this.productCategoryId,
    this.productName,
    this.price,
    this.image,
    this.images,
    this.type,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.ipAddress,
    this.branchId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.categoryName, 
  });

  factory GetCategoryProductModel.fromJson(Map<String, dynamic> json) {
    return GetCategoryProductModel(
      id: json['id']?.toString(),
      productId: json['product_id'],
      productCategoryId: json['product_category_id']?.toString(),
      productName: json['product_name'],
      price: json['price'],
      image: json['image'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : null,
      type: json['type'],
      description: json['description'],
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      ipAddress: json['ip_address'],
      branchId: json['branch_id']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      categoryName: json['category_name'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_category_id': productCategoryId,
      'product_name': productName,
      'price': price,
      'image': image,
      'images': images,
      'type': type,
      'description': description,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'ip_address': ipAddress,
      'branch_id': branchId,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'category_name': categoryName, 
    };
  }
}

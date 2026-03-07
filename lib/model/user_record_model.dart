import 'dart:convert';

class UserRecordModel {
  List<ClientPost>? clientPosts;
  List<EngineerSupport>? engineerSupports;
  List<MyRequirement>? myRequirements;
  List<OtherPost>? others;
  List<Order>? orders;

  UserRecordModel({
    this.clientPosts,
    this.engineerSupports,
    this.myRequirements,
    this.others,
    this.orders,
  });

  factory UserRecordModel.fromRawJson(String str) =>
      UserRecordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  UserRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['client_posts'] != null) {
      clientPosts = <ClientPost>[];
      json['client_posts'].forEach((v) {
        clientPosts!.add(ClientPost.fromJson(v));
      });
    }

    if (json['engineer_supports'] != null) {
      engineerSupports = <EngineerSupport>[];
      json['engineer_supports'].forEach((v) {
        engineerSupports!.add(EngineerSupport.fromJson(v));
      });
    }

    if (json['my_requirements'] != null) {
      myRequirements = <MyRequirement>[];
      json['my_requirements'].forEach((v) {
        myRequirements!.add(MyRequirement.fromJson(v));
      });
    }

    if (json['others'] != null) {
      others = <OtherPost>[];
      json['others'].forEach((v) {
        others!.add(OtherPost.fromJson(v));
      });
    }

    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (clientPosts != null) {
      data['client_posts'] =
          clientPosts!.map((v) => v.toJson()).toList();
    }

    if (engineerSupports != null) {
      data['engineer_supports'] =
          engineerSupports!.map((v) => v.toJson()).toList();
    }

    if (myRequirements != null) {
      data['my_requirements'] =
          myRequirements!.map((v) => v.toJson()).toList();
    }

    if (others != null) {
      data['others'] =
          others!.map((v) => v.toJson()).toList();
    }

    if (orders != null) {
      data['orders'] =
          orders!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ClientPost {
  int? id;
  String? customerPostId;
  String? machineName;
  String? price;
  String? model;
  String? condition;
  String? origin;
  List<int>? divisionId;
  List<int>? areaId;
  String? upazilla;
  String? mobile;
  DateTime? validityDate;
  String? description;
  String? image;
  List<String>? images;
  int? createdBy;
  dynamic updatedBy;
  String? ipAddress;
  int? branchId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  dynamic address;

  ClientPost();

  ClientPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerPostId = json['customer_post_id'];
    machineName = json['machine_name'];
    price = json['price'];
    model = json['model'];
    condition = json['condition'];
    origin = json['origin'];

    if (json['division_id'] != null) {
      divisionId = List<int>.from(json['division_id']);
    }

    if (json['area_id'] != null) {
      areaId = List<int>.from(json['area_id']);
    }

    upazilla = json['upazilla'];
    mobile = json['mobile'];

    validityDate = json['validity_date'] != null
        ? DateTime.tryParse(json['validity_date'])
        : null;

    description = json['description'];
    image = json['image'];

    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }

    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ipAddress = json['ip_address'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];

    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;

    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;

    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['customer_post_id'] = customerPostId;
    data['machine_name'] = machineName;
    data['price'] = price;
    data['model'] = model;
    data['condition'] = condition;
    data['origin'] = origin;
    data['division_id'] = divisionId;
    data['area_id'] = areaId;
    data['upazilla'] = upazilla;
    data['mobile'] = mobile;
    data['validity_date'] = validityDate?.toIso8601String();
    data['description'] = description;
    data['image'] = image;
    data['images'] = images;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['ip_address'] = ipAddress;
    data['branch_id'] = branchId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}

class EngineerSupport {
  int? id;
  String? machineName;
  String? model;
  String? origin;
  String? mobile;
  String? description;
  List<String>? images;
  String? status;
  int? createdBy;
  int? updatedBy;
  String? ipAddress;
  int? branchId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  EngineerSupport();

  EngineerSupport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineName = json['machine_name'];
    model = json['model'];
    origin = json['origin'];
    mobile = json['mobile'];
    description = json['description'];

    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }

    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ipAddress = json['ip_address'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];

    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;

    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['machine_name'] = machineName;
    data['model'] = model;
    data['origin'] = origin;
    data['mobile'] = mobile;
    data['description'] = description;
    data['images'] = images;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['ip_address'] = ipAddress;
    data['branch_id'] = branchId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}

class MyRequirement {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? description;
  dynamic image;
  int? createdBy;
  dynamic updatedBy;
  String? ipAddress;
  int? branchId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyRequirement();

  MyRequirement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    description = json['description'];
    image = json['image'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ipAddress = json['ip_address'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];

    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;

    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['address'] = address;
    data['description'] = description;
    data['image'] = image;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['ip_address'] = ipAddress;
    data['branch_id'] = branchId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}

class Order {
  int? id;
  String? orderId;
  int? productId;
  int? userId;
  dynamic condition;
  String? status;
  dynamic updatedBy;
  String? ipAddress;
  int? branchId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;   // ✅ NEW

  Order();

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    userId = json['user_id'];
    condition = json['condition'];
    status = json['status'];
    updatedBy = json['updated_by'];
    ipAddress = json['ip_address'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];

    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;

    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;

    // ✅ Product parse
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['condition'] = condition;
    data['status'] = status;
    data['updated_by'] = updatedBy;
    data['ip_address'] = ipAddress;
    data['branch_id'] = branchId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();

    // ✅ Product toJson
    if (product != null) {
      data['product'] = product!.toJson();
    }

    return data;
  }
}

class Product {
  int? id;
  String? productId;
  int? productCategoryId;
  String? productName;
  String? price;
  String? image;
  List<String>? images;
  String? type;
  String? description;
  int? createdBy;
  dynamic updatedBy;
  String? ipAddress;
  int? branchId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productCategoryId = json['product_category_id'];
    productName = json['product_name'];
    price = json['price'];
    image = json['image'];
    images = json['images'] != null
        ? List<String>.from(json['images'])
        : [];
    type = json['type'];
    description = json['description'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ipAddress = json['ip_address'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];

    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;

    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_category_id'] = productCategoryId;
    data['product_name'] = productName;
    data['price'] = price;
    data['image'] = image;
    data['images'] = images;
    data['type'] = type;
    data['description'] = description;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['ip_address'] = ipAddress;
    data['branch_id'] = branchId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}

class OtherPost {
  int? id;
  String? customerPostId;
  String? machineName;
  String? price;
  String? model;
  String? condition;
  String? origin;
  List<int>? divisionId;
  List<int>? areaId;
  String? upazilla;
  String? mobile;
  DateTime? validityDate;
  String? description;
  String? image;
  List<String>? images;
  int? createdBy;
  dynamic updatedBy;
  String? ipAddress;
  int? branchId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  dynamic address;

  OtherPost();

  OtherPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerPostId = json['customer_post_id'];
    machineName = json['machine_name'];
    price = json['price'];
    model = json['model'];
    condition = json['condition'];
    origin = json['origin'];

    if (json['division_id'] != null) {
      divisionId = List<int>.from(json['division_id']);
    }

    if (json['area_id'] != null) {
      areaId = List<int>.from(json['area_id']);
    }

    upazilla = json['upazilla'];
    mobile = json['mobile'];

    validityDate = json['validity_date'] != null
        ? DateTime.tryParse(json['validity_date'])
        : null;

    description = json['description'];
    image = json['image'];

    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }

    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ipAddress = json['ip_address'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];

    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;

    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;

    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['customer_post_id'] = customerPostId;
    data['machine_name'] = machineName;
    data['price'] = price;
    data['model'] = model;
    data['condition'] = condition;
    data['origin'] = origin;
    data['division_id'] = divisionId;
    data['area_id'] = areaId;
    data['upazilla'] = upazilla;
    data['mobile'] = mobile;
    data['validity_date'] = validityDate?.toIso8601String();
    data['description'] = description;
    data['image'] = image;
    data['images'] = images;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['ip_address'] = ipAddress;
    data['branch_id'] = branchId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}


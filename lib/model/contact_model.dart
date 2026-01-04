class ContactModel {
  int? id;
  String? name;
  String? technologist;
  String? phone;
  String? email;
  String? address;
  String? logo;
  String? headerImage;
  String? createdAt;
  String? updatedAt;

  ContactModel({
    this.id,
    this.name,
    this.technologist,
    this.phone,
    this.email,
    this.address,
    this.logo,
    this.headerImage,
    this.createdAt,
    this.updatedAt,
  });

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    technologist = json['technologist'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    logo = json['logo'];
    headerImage = json['header_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['technologist'] = technologist;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['logo'] = logo;
    data['header_image'] = headerImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

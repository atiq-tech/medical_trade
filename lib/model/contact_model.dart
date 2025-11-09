class ContactModel {
  bool? success;
  String? message;
  CompanyData? data;

  ContactModel({this.success, this.message, this.data});

  ContactModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CompanyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class CompanyData {
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

  CompanyData(
      {this.id,
      this.name,
      this.technologist,
      this.phone,
      this.email,
      this.address,
      this.logo,
      this.headerImage,
      this.createdAt,
      this.updatedAt});

  CompanyData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['technologist'] = technologist;
    map['phone'] = phone;
    map['email'] = email;
    map['address'] = address;
    map['logo'] = logo;
    map['header_image'] = headerImage;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}


















// class ContactModel {
//   String? companySlNo;
//   String? companyName;
//   String? contactNumberone;
//   String? contactNumbertwo;
//   String? hotlineOne;
//   String? hotlineTwo;
//   String? repotHeading;
//   String? companyLogoOrg;
//   String? companyLogoThum;
//   String? invoiceType;
//   String? currencyName;
//   Null currencySymbol;
//   Null subCurrencyName;
//   String? printType;
//   String? companyBrunchId;

//   ContactModel(
//       {this.companySlNo,
//       this.companyName,
//       this.contactNumberone,
//       this.contactNumbertwo,
//       this.hotlineOne,
//       this.hotlineTwo,
//       this.repotHeading,
//       this.companyLogoOrg,
//       this.companyLogoThum,
//       this.invoiceType,
//       this.currencyName,
//       this.currencySymbol,
//       this.subCurrencyName,
//       this.printType,
//       this.companyBrunchId});

//   ContactModel.fromJson(Map<String, dynamic> json) {
//     companySlNo = json['Company_SlNo'];
//     companyName = json['Company_Name'];
//     contactNumberone = json['contact_numberone'];
//     contactNumbertwo = json['contact_numbertwo'];
//     hotlineOne = json['hotline_one'];
//     hotlineTwo = json['hotline_two'];
//     repotHeading = json['Repot_Heading'];
//     companyLogoOrg = json['Company_Logo_org'];
//     companyLogoThum = json['Company_Logo_thum'];
//     invoiceType = json['Invoice_Type'];
//     currencyName = json['Currency_Name'];
//     currencySymbol = json['Currency_Symbol'];
//     subCurrencyName = json['SubCurrency_Name'];
//     printType = json['print_type'];
//     companyBrunchId = json['company_BrunchId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Company_SlNo'] = companySlNo;
//     data['Company_Name'] = companyName;
//     data['contact_numberone'] = contactNumberone;
//     data['contact_numbertwo'] = contactNumbertwo;
//     data['hotline_one'] = hotlineOne;
//     data['hotline_two'] = hotlineTwo;
//     data['Repot_Heading'] = repotHeading;
//     data['Company_Logo_org'] = companyLogoOrg;
//     data['Company_Logo_thum'] = companyLogoThum;
//     data['Invoice_Type'] = invoiceType;
//     data['Currency_Name'] = currencyName;
//     data['Currency_Symbol'] = currencySymbol;
//     data['SubCurrency_Name'] = subCurrencyName;
//     data['print_type'] = printType;
//     data['company_BrunchId'] = companyBrunchId;
//     return data;
//   }
// }

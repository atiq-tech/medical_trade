class ContactModel {
  String? companySlNo;
  String? companyName;
  String? contactNumberone;
  String? contactNumbertwo;
  String? hotlineOne;
  String? hotlineTwo;
  String? repotHeading;
  String? companyLogoOrg;
  String? companyLogoThum;
  String? invoiceType;
  String? currencyName;
  Null currencySymbol;
  Null subCurrencyName;
  String? printType;
  String? companyBrunchId;

  ContactModel(
      {this.companySlNo,
      this.companyName,
      this.contactNumberone,
      this.contactNumbertwo,
      this.hotlineOne,
      this.hotlineTwo,
      this.repotHeading,
      this.companyLogoOrg,
      this.companyLogoThum,
      this.invoiceType,
      this.currencyName,
      this.currencySymbol,
      this.subCurrencyName,
      this.printType,
      this.companyBrunchId});

  ContactModel.fromJson(Map<String, dynamic> json) {
    companySlNo = json['Company_SlNo'];
    companyName = json['Company_Name'];
    contactNumberone = json['contact_numberone'];
    contactNumbertwo = json['contact_numbertwo'];
    hotlineOne = json['hotline_one'];
    hotlineTwo = json['hotline_two'];
    repotHeading = json['Repot_Heading'];
    companyLogoOrg = json['Company_Logo_org'];
    companyLogoThum = json['Company_Logo_thum'];
    invoiceType = json['Invoice_Type'];
    currencyName = json['Currency_Name'];
    currencySymbol = json['Currency_Symbol'];
    subCurrencyName = json['SubCurrency_Name'];
    printType = json['print_type'];
    companyBrunchId = json['company_BrunchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Company_SlNo'] = companySlNo;
    data['Company_Name'] = companyName;
    data['contact_numberone'] = contactNumberone;
    data['contact_numbertwo'] = contactNumbertwo;
    data['hotline_one'] = hotlineOne;
    data['hotline_two'] = hotlineTwo;
    data['Repot_Heading'] = repotHeading;
    data['Company_Logo_org'] = companyLogoOrg;
    data['Company_Logo_thum'] = companyLogoThum;
    data['Invoice_Type'] = invoiceType;
    data['Currency_Name'] = currencyName;
    data['Currency_Symbol'] = currencySymbol;
    data['SubCurrency_Name'] = subCurrencyName;
    data['print_type'] = printType;
    data['company_BrunchId'] = companyBrunchId;
    return data;
  }
}

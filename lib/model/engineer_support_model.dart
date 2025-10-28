
class ProductModelEngineersuport {
  final String engineerSlNo;
  final String title;
  final String personName;
  final String designation;
  final String mobile;
  final String status;
  final String addBy;
  final String addTime;
  final String updateBy;
  final String updateTime;
  final String engineerBranchid;

  ProductModelEngineersuport({
    required this.engineerSlNo,
    required this.title,
    required this.personName,
    required this.designation,
    required this.mobile,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.engineerBranchid,
  });

  factory ProductModelEngineersuport.fromJson(Map<String, dynamic> json) {
    return ProductModelEngineersuport(
      engineerSlNo: json['Engineer_SlNo'] ?? '',
      title: json['Title'] ?? '',
      personName: json['Person_name'] ?? '',
      designation: json['Designation'] ?? '',
      mobile: json['mobile'] ?? '',
      status: json['status'] ?? '',
      addBy: json['AddBy'] ?? '',
      addTime: json['AddTime'] ?? '',
      updateBy: json['UpdateBy'] ?? '',
      updateTime: json['UpdateTime'] ?? '',
      engineerBranchid: json['Engineer_branchid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Engineer_SlNo': engineerSlNo,
      'Title': title,
      'Person_name': personName,
      'Designation': designation,
      'mobile': mobile,
      'status': status,
      'AddBy': addBy,
      'AddTime': addTime,
      'UpdateBy': updateBy,
      'UpdateTime': updateTime,
      'Engineer_branchid': engineerBranchid,
    };
  }
}

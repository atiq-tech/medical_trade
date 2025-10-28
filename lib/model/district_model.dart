import 'dart:convert';

List<DistrictModel> districtModelFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData is List) {
    return List<DistrictModel>.from(
        jsonData.map((x) => DistrictModel.fromJson(x as Map<String, dynamic>)));
  } else {
    throw Exception('Expected a list of districts');
  }
}

String districtModelToJson(List<DistrictModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

enum Status { A }

final statusValues = EnumValues({
  "a": Status.A,
});

class DistrictModel {
  String districtSlNo;
  String districtName;
  Status status;
  dynamic addBy;
  dynamic addTime;
  dynamic updateBy;
  dynamic updateTime;

  DistrictModel({
    required this.districtSlNo,
    required this.districtName,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        districtSlNo:
            json["District_SlNo"] as String? ?? '', // Provide a default value
        districtName:
            json["District_Name"] as String? ?? '', // Provide a default value
        status: statusValues.fromJson(json["status"]) ??
            Status.A, // Default to Status.A if null or invalid
        addBy: json["AddBy"],
        addTime: json["AddTime"],
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
      );

  Map<String, dynamic> toJson() => {
        "District_SlNo": districtSlNo,
        "District_Name": districtName,
        "status": statusValues.toJson(status), // Access reverseMap directly
        "AddBy": addBy,
        "AddTime": addTime,
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = map.map((k, v) => MapEntry(v, k));

  T? fromJson(String key) => map[key];
  String? toJson(T value) => reverseMap[value];
}

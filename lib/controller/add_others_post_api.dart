import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/utilities/custom_message.dart';

class AddOthersPostApi with ChangeNotifier {
  String? _errorMessage;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  Future<bool> othersPostData({
    required BuildContext context,
    required String machineName,
    required String price,
    required String model,
    required String condition,
    required String origin,
    required List<String> selectedDivisions,
    required List<String> selectedDistricts,
    required String upazila,
    required String mobile,
    required String description,
    required File? image,
    required VoidCallback onSuccess,
  }) async {
    setLoading(true);
    final storage = GetStorage();
    final token = storage.read('loginToken');
    final userId = storage.read('userId');

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.addOthersEndPoint),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields.addAll({
      "name": machineName,
      "price": price,
      "model": model,
      "condition": condition,
      "origin": origin,
      "mobile": mobile,
      "description": description,
      "upazilla": upazila,
      "validity_date": "",
      "status": "p",
      "AddBy": userId.toString(),
    });

    // ✅ Division IDs
    for (var id in selectedDivisions) {
      request.fields.putIfAbsent("division_id[]", () => id);
    }
    // ✅ District IDs
    for (var id in selectedDistricts) {
      request.fields.putIfAbsent("area_id[]", () => id);
    }

    // ✅ Single Image Add
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          filename: image.path.split('/').last,
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("POST RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);

        if (jsonResp["success"] == false) {
          CustomToast.show(
            context: context,
            text: "Machine name already exists",
            isSuccess: false,
          );
          return false;
        }
        CustomToast.show(
          context: context,
          text: "Data posted successfully",
          isSuccess: true,
        );
        onSuccess();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      setLoading(false);
    }
  }
}
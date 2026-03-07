import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/user_record_model.dart';

import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class UserRecordProvider extends ChangeNotifier {

  UserRecordModel? _userRecord;
  UserRecordModel? get userRecord => _userRecord;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserRecord({
    required String dateFrom,
    required String dateTo,
  }) async {

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final box = GetStorage();
    final token = box.read('loginToken');

    print("TOKEN: $token");

    final url = Uri.parse(AppUrl.userRecordEndPoint);

    final body = {
      "dateFrom": dateFrom,
      "dateTo": dateTo,
    };

    print("Request Body: ${jsonEncode(body)}");

    try {

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {

        final Map<String, dynamic> data =
            jsonDecode(response.body);

        _userRecord = UserRecordModel.fromJson(data);

      } else {

        _userRecord = null;
        _errorMessage = "Server Error: ${response.statusCode}";
      }

    } catch (e) {

      _userRecord = null;
      _errorMessage = "Error: $e";
      print("Error: $e");

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }
}
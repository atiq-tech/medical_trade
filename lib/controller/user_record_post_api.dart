import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/user_record_model.dart';

class UserRecordProvider extends ChangeNotifier {

  UserRecordModel? _userRecord;
  UserRecordModel? get userRecord => _userRecord;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<void> fetchUserRecord({
    required String dateFrom,
    required String dateTo,
  }) async {

    _isLoading = true;
    notifyListeners();

    final url = AppUrl.userRecordEndPoint; 

    final body = {
      "dateFrom": dateFrom,
      "dateTo": dateTo,
    };

    print("Request Body: ${jsonEncode(body)}");

    try {

      final response = await _apiService.postFormData(url, body);

      if (response != null && response.statusCode == 200) {

        final Map<String, dynamic> data =
            jsonDecode(response.body);

        _userRecord = UserRecordModel.fromJson(data);

        _errorMessage = null;

      } else {

        _userRecord = null;
        _errorMessage = "Failed to load data";

      }

    } catch (e) {

      _userRecord = null;
      _errorMessage = "Error: $e";

      ErrorHandling.handleError(
        e is Exception ? e : Exception(e.toString()),
      );

      print("Error: $e");

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }
}
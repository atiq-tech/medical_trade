import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/get_sales_old_machine_product_model.dart';

class GetSalesOldMachineProvider extends ChangeNotifier {
  List<GetSalesOldMachineModel> _categories = [];
  List<GetSalesOldMachineModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage; // Add an errorMessage variable
  String? get errorMessage => _errorMessage; // Add a getter for errorMessage

  final ApiService _apiService = ApiService();

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    final url = AppUrl.getClientPostEndPoint;

    final box = GetStorage();
    final division = box.read('userDivision'); // Only using division

    final divisionValue =
        (division == null || division == 'null' || division.isEmpty)
            ? null
            : division;

    final body = <String, String>{}; // Change to Map<String, String>

    if (divisionValue != null) {
      body['division_id'] = divisionValue;
    }

    print("Request Body: ${jsonEncode(body)}");

    try {
      final response = await _apiService.postFormData(url, body);

      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Map data to instances of GetSalesOldMachineModel
        _categories =
            data.map((item) => GetSalesOldMachineModel.fromJson(item)).toList();

        _errorMessage = null;
        // print("Fetched and filtered sales old machine products successfully.");
      } else {
        _categories = [];
        _errorMessage = 'Failed to load data';
        ErrorHandling.handleError(ApiException(
            'API responded with status code ${response?.statusCode}'));
      }
    } catch (e) {
      _categories = [];
      _errorMessage = 'Error: $e';
      ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

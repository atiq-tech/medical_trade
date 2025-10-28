import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/engineer_support_model.dart';

class GetEngineerSupportProductProvider extends ChangeNotifier {
  List<ProductModelEngineersuport> _categories = [];
  List<ProductModelEngineersuport> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService(); // Instantiate ApiService

  // Fetch data from the API
  Future<void> fetchDataProduct() async {
    _isLoading = true;
    notifyListeners();

    final url = AppUrl.getProductEngineeringEndPoint;

    try {
      final response = await _apiService.getRequest(url);
      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _categories = data
            .map((item) => ProductModelEngineersuport.fromJson(item))
            .toList();
      } else {
        // Handle API error
        ErrorHandling.handleError(ApiException(
            'API responded with status code ${response?.statusCode ?? 'No Response'}'));
      }
    } catch (e) {
      // Handle generic errors
      ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
    }

    _isLoading = false;
    notifyListeners();
  }
}

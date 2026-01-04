import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/get_category_product_model.dart';

class GetCategoryProductProvider extends ChangeNotifier {
  List<GetCategoryProductModel> _categories = [];
  List<GetCategoryProductModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchDataProduct(String categoryId) async {
    _isLoading = true;
    notifyListeners();

    final url = AppUrl.getProductsEndPoint;
    final body = {"category_id": categoryId};

    try {
      final response = await _apiService.postRequest(url, body);
      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _categories = data.map((item) => GetCategoryProductModel.fromJson(item)).toList();
        _errorMessage = null; 
      } else {
        _categories = [];
        _errorMessage = 'Failed to load products';
        ErrorHandling.handleError(ApiException('API responded with status code ${response?.statusCode}'));
      }
    } catch (e) {
      _categories = [];
      _errorMessage = 'Error: $e';
      ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage; 
}

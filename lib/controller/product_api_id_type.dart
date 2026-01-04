import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/model/product_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  List<ProductModel> _categories = [];
  List<ProductModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService(); 
  Future<List<ProductModel>> fetchProduct({
    required String categoryId,
    required String categoryType,
  }) async {
    final url = AppUrl.getProductsEndPoint;
    final body = {"category_id": categoryId, "type": categoryType};

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.postRequest(url, body); 
      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _categories = data.map((item) => ProductModel.fromJson(item)).toList();
        notifyListeners();
        return _categories; 
      } else {
        final errorMessage = 'Failed to fetch products: ${response?.reasonPhrase}';
        ErrorHandling.handleError(ApiException(errorMessage));
        return []; 
      }
    } catch (e) {
      if (e is SocketException) {
        ErrorHandling.handleError(e);
      } else {
        ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
      }
      return []; 
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

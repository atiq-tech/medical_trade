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

  final ApiService _apiService = ApiService(); // Instantiate ApiService

  // Method to fetch products by category based on productCategoryID
  Future<List<ProductModel>> fetchProduct({
    required String categoryId,
    required String categoryType,
  }) async {
    final url = AppUrl.getProductsEndPoint;
    final body = {"category_id": categoryId, "type": categoryType};

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.postRequest(
          url, body); // Use ApiService for POST request

      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _categories = data.map((item) => ProductModel.fromJson(item)).toList();
        notifyListeners();
        return _categories; // Return the list of products
      } else {
        final errorMessage =
            'Failed to fetch products: ${response?.reasonPhrase}';
        ErrorHandling.handleError(ApiException(errorMessage));
        return []; // Return an empty list on error
      }
    } catch (e) {
      if (e is SocketException) {
        ErrorHandling.handleError(e);
      } else {
        ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
      }
      return []; // Return an empty list on exception
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

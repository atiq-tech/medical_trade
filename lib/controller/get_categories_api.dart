import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/get_categories_model.dart';
import 'package:flutter/material.dart';

class GetCategoriesProvider extends ChangeNotifier {
  List<GetCategoryModel> _categories = [];
  List<GetCategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  // Fetch categories from API
  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    final url = AppUrl.getcategoriesEndPoint;
    try {
      final response = await _apiService.getRequest(url);
      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _categories = data.map((item) => GetCategoryModel.fromJson(item)).toList();

        // Print all categories after fetching
        printAllCategories();

      } else {
        ErrorHandling.handleError(ApiException(
          'API responded with status code ${response?.statusCode ?? 'No Response'}'));
      }
    } catch (e) {
      ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Print all category data
  void printAllCategories() {
    print("===== All Categories =====");
    for (var category in _categories) {
      print("ID: ${category.id}");
      print("Name: ${category.name}");
      print("Description: ${category.description}");
      print("Created By: ${category.createdBy}");
      print("Updated By: ${category.updatedBy}");
      print("IP Address: ${category.ipAddress}");
      print("Branch ID: ${category.branchId}");
      print("Deleted At: ${category.deletedAt}");
      print("Created At: ${category.createdAt}");
      print("Updated At: ${category.updatedAt}");
      print("-------------------------");
    }
  }

  // Filter categories by id list
  List<GetCategoryModel> getFilteredCategories(List<String> ids) {
    return _categories
        .where((category) => ids.contains(category.id.toString()))
        .toList();
  }
}


// class GetCategoriesProvider extends ChangeNotifier {
//   List<GetCategoryModel> _categories = [];
//   List<GetCategoryModel> get categories => _categories;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final ApiService _apiService = ApiService(); // Instantiate ApiService

//   // Fetch categories from API
//   Future<void> fetchData() async {
//     _isLoading = true;
//     notifyListeners();

//     final url = AppUrl.getcategoriesEndPoint;

//     try {
//       final response = await _apiService.getRequest(url);

//       if (response != null && response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         _categories =
//             data.map((item) => GetCategoryModel.fromJson(item)).toList();
//       } else {
//         ErrorHandling.handleError(ApiException(
//             'API responded with status code ${response?.statusCode ?? 'No Response'}'));
//       }
//     } catch (e) {
//       ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Filter categories by id list
//   List<GetCategoryModel> getFilteredCategories(List<String> ids) {
//     return _categories
//         .where((category) => ids.contains(category.id.toString()))
//         .toList();
//   }
// }








//old=====
// class GetCategoriesProvider extends ChangeNotifier {
//   List<GetCategoryModel> _categories = [];
//   List<GetCategoryModel> get categories => _categories;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final ApiService _apiService = ApiService(); // Instantiate ApiService

//   Future<void> fetchData() async {
//     _isLoading = true; // Start loading
//     notifyListeners();

//     final url = AppUrl.getcategoriesEndPoint;

//     try {
//       final response = await _apiService
//           .getRequest(url); // Use ApiService to make the GET request

//       if (response != null && response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         _categories =
//             data.map((item) => GetCategoryModel.fromJson(item)).toList();
//         // print("Fetched categories successfully.");
//       } else {
//         // Use ErrorHandling to handle the API error
//         ErrorHandling.handleError(ApiException(
//             'API responded with status code ${response?.statusCode ?? 'No Response'}'));
//       }
//     } catch (e) {
//       // Use ErrorHandling to handle the exception
//       ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
//     } finally {
//       _isLoading = false; // Stop loading
//       notifyListeners();
//     }
//   }

//   List<GetCategoryModel> getFilteredCategories(List<String> ids) {
//     return _categories
//         .where((category) => ids.contains(category.productCategorySlNo))
//         .toList();
//   }
// }

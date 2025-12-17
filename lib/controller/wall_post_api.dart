import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/wall_post_model.dart';

class WallPostApiProvider extends ChangeNotifier {
  List<WallPostModel> _wallpostdata = [];
  List<WallPostModel> get wallpostdata => _wallpostdata;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchWallData() async {
    final String url = AppUrl.myWallEndPint;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getRequest(url);
      print(response);

      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data);

        _wallpostdata =
            data.map((item) => WallPostModel.fromJson(item)).toList();

        notifyListeners();
      } else {
        // final errorMessage = 'Failed to fetch wall posts: ${response?.reasonPhrase}';
        // ErrorHandling.handleError(ApiException(errorMessage));
      }
    } catch (e) {
      // if (e is SocketException) {
      //   ErrorHandling.handleError(e);
      // } else {
      //   ErrorHandling.handleError(
      //       e is Exception ? e : Exception(e.toString()));
      // }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}






//old===
// class WallPostApiProvider extends ChangeNotifier {
//   List<WallPostModel> _wallpostdata = [];
//   List<WallPostModel> get wallpostdata => _wallpostdata;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final ApiService _apiService = ApiService(); // Instantiate ApiService
//   final box = GetStorage(); // GetStorage instance to retrieve stored data

//   // Method to fetch wall posts
//   Future<void> fetchWallData() async {
//     // Retrieve stored division and district
//     final String? divisionId = box.read('userDivision');
//     final String? districtId = box.read('userDistrict');

//     // Check if division and district IDs are available
//     if (divisionId == null || districtId == null) {
//       final errorMessage = 'Division or district ID not found.';
//       ErrorHandling.handleError(ApiException(errorMessage));
//       return; // Exit if data is not found
//     }

//     final url = AppUrl.myWallEndPint;
//     final body = {"division_id": divisionId, "district_id": districtId};

//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _apiService.postRequest(url, body);
//       print(response);

//       if (response != null && response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         print(data);
//         _wallpostdata =
//             data.map((item) => WallPostModel.fromJson(item)).toList();
//         notifyListeners();
//       } else {
//         final errorMessage =
//             'Failed to fetch products: ${response?.reasonPhrase}';
//         ErrorHandling.handleError(ApiException(errorMessage));
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         ErrorHandling.handleError(e);
//       } else {
//         ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
//       }
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/division_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DivisionProvider extends ChangeNotifier {
  List<DivisionModel> _divisions = [];
  String? _errorMessage;
  bool _isLoading = false;
  final List<String> _selectedDivisions = [];

  List<DivisionModel> get divisions => _divisions;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<String> get selectedDivisions => _selectedDivisions;

  Future<void> fetchDivisions() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      _divisions = [];
      _errorMessage = 'No internet connection';
      _setLoading(false);
      notifyListeners();
      return;
    }

    _setLoading(true);
    final url = AppUrl.getDivisionsEndPoint;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _divisions = divisionModelFromJson(response.body);
        _errorMessage = null;
      } else {
        _divisions = [];
        _errorMessage = 'Failed to load divisions';
        ErrorHandling.handleError(ApiException(
            'API responded with status code ${response.statusCode}'));
      }
    } catch (e) {
      _divisions = [];
      _errorMessage = 'Error: $e';
      ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  List<DivisionModel> searchDivisions(String query) {
    return _divisions.where((division) {
      final nameLower = division.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}











// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_trade/config/api_error_service.dart';
// import 'package:medical_trade/config/app_url.dart';
// import 'package:medical_trade/model/division_model.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class DivisionProvider extends ChangeNotifier {
//   List<DivisionModel> _divisions = [];
//   String? _errorMessage;
//   bool _isLoading = false;
//   final List<String> _selectedDivisions = [];

//   List<DivisionModel> get divisions => _divisions;
//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading;
//   List<String> get selectedDivisions => _selectedDivisions;

//   Future<void> fetchDivisions() async {
//     // Check internet connection
//     var connectivityResult = await Connectivity().checkConnectivity();
//     // ignore: unrelated_type_equality_checks
//     if (connectivityResult == ConnectivityResult.none) {
//       _divisions = [];
//       _errorMessage = 'No internet connection';
//       _setLoading(false);
//       notifyListeners();
//       return;
//     }

//     _setLoading(true);
//     final url = AppUrl.getDivisionsEndPoint;
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         _divisions = divisionModelFromJson(response.body);
//         _errorMessage = null;
//       } else {
//         _divisions = [];
//         _errorMessage = 'Failed to load divisions';
//         ErrorHandling.handleError(ApiException(
//             'API responded with status code ${response.statusCode}'));
//       }
//     } catch (e) {
//       _divisions = [];
//       _errorMessage = 'Error: $e';
//       ErrorHandling.handleError(e is Exception ? e : Exception(e.toString()));
//     } finally {
//       _setLoading(false);
//     }
//     notifyListeners();
//   }

//   List<DivisionModel> searchDivisions(String query) {
//     return _divisions.where((division) {
//       final nameLower = division.divisionName.toLowerCase();
//       final queryLower = query.toLowerCase();
//       return nameLower.contains(queryLower);
//     }).toList();
//   }

//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }
// }

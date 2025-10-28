import 'package:flutter/material.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/district_model.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class DistrictProvider extends ChangeNotifier {
  List<DistrictModel> _districts = [];
  String? _errorMessage;
  bool _isLoading = false;
  final List<String> _selectedDistricts = [];

  List<DistrictModel> get districts => _districts;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<String> get selectedDistricts => _selectedDistricts;

  Future<void> fetchDistricts() async {
    // Check internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      _districts = [];
      _errorMessage = 'No internet connection';
      _setLoading(false);
      notifyListeners();
      return;
    }

    _setLoading(true);
    final url = AppUrl.getDistrictsEndPoint;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _districts = districtModelFromJson(response.body);
        _errorMessage = null;
      } else {
        _districts = [];
        _errorMessage = 'Failed to load districts';
      }
    } catch (e) {
      _districts = [];
      _errorMessage = 'Error: $e';
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  List<DistrictModel> searchDistricts(String query) {
    return _districts.where((district) {
      final nameLower = district.districtName.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

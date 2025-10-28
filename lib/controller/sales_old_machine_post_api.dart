import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/api_service.dart';
import 'package:medical_trade/config/app_url.dart';

class ClientPostProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<dynamic> _divisions = [];
  List<dynamic> _districts = [];
  String? _customerCode;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<dynamic> get divisions => _divisions;
  List<dynamic> get districts => _districts;

  final ApiService _apiService = ApiService();

  Future<void> fetchDivisions() async {
    final url = AppUrl.getDivisionsEndPoint;
    try {
      final response = await _apiService.getRequest(url);
      if (response != null && response.statusCode == 200) {
        _divisions = jsonDecode(response.body);
        _errorMessage = null;
      } else {
        _divisions = [];
        _errorMessage = 'Failed to load divisions';
        await ErrorHandling.handleError(
          Exception('Failed to load divisions'),
        );
      }
    } catch (e) {
      _divisions = [];
      await ErrorHandling.handleError(e as Exception);
    }
    notifyListeners();
  }

  Future<void> fetchDistricts(String divisionId) async {
    final url = '${AppUrl.getDistrictsEndPoint}?Division_SlNo=$divisionId';
    try {
      final response = await _apiService.getRequest(url);
      if (response != null && response.statusCode == 200) {
        _districts = jsonDecode(response.body);
        _errorMessage = null;
      } else {
        _districts = [];
        _errorMessage = 'Failed to load districts';
        await ErrorHandling.handleError(
          Exception('Failed to load districts'),
        );
      }
    } catch (e) {
      _districts = [];
      await ErrorHandling.handleError(e as Exception);
    }
    notifyListeners();
  }

  Future<void> fetchCustomerCode() async {
    final url = AppUrl.generateClientPostCodeEndPoint;
    try {
      final response = await _apiService.getRequest(url);
      if (response != null && response.statusCode == 200) {
        final responseBody = response.body;
        _customerCode = responseBody;
        _errorMessage = null;
      } else {
        _customerCode = null;
        _errorMessage = 'Failed to fetch customer code';
        await ErrorHandling.handleError(
          Exception('Failed to fetch customer code'),
        );
      }
    } catch (e) {
      _customerCode = null;
      await ErrorHandling.handleError(e as Exception);
    }
    notifyListeners();
  }

  Future<bool> registerClientPost({
    required String machineName,
    required String price,
    required String model,
    required String condition,
    required String origin,
    required String mobile,
    required String division,
    required String district,
    required String description,
    required File image,
  }) async {
    if (_customerCode == null) {
      await fetchCustomerCode();
      if (_customerCode == null) {
        return false;
      }
    }

    final url = AppUrl.addClientpostEndPoint;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['client_code'] = _customerCode!
        ..fields['machine_name'] = machineName
        ..fields['price'] = price
        ..fields['model'] = model
        ..fields['condition'] = condition
        ..fields['origin'] = origin
        ..fields['mobile'] = mobile
        ..fields['division'] = division
        ..fields['district'] = district
        ..fields['description'] = description;

      String contentType;
      final fileExtension = image.path.split('.').last.toLowerCase();
      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
          contentType = 'image/jpeg';
          break;
        case 'png':
          contentType = 'image/png';
          break;
        default:
          contentType = 'application/octet-stream';
      }

      var imageFile = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType.parse(contentType),
      );
      request.files.add(imageFile);

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);
        if (responseData['status'] == true) {
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage =
              responseData['message'] ?? 'Client registration failed';
          await ErrorHandling.handleError(
            Exception(_errorMessage),
          );
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        _errorMessage =
            'Client registration failed. Status code: ${response.statusCode}';
        await ErrorHandling.handleError(
          Exception(_errorMessage),
        );
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      await ErrorHandling.handleError(e as Exception);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}

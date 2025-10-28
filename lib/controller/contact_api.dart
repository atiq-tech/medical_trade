import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/contact_model.dart';

class ContactProvider with ChangeNotifier {
  ContactModel? _contactModel;
  bool _isLoading = false;
  String? _errorMessage;

  ContactModel? get contactModel => _contactModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchContact() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(AppUrl.contactEndPint));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _contactModel = ContactModel.fromJson(jsonData);
      } else {
        _errorMessage = 'Failed to load contact data: ${response.reasonPhrase}';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

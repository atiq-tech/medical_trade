import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';

class ClientWallProductBuyProvider with ChangeNotifier {
  String? _clientCode;
  String? _errorMessage;
  bool _isLoading = false;

  String? get clientCode => _clientCode;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchClientCodeAndSendOrder({
    required String wallpostId,
  }) async {
    final url = AppUrl.generateWallOrderCodeEndPint;
    final GetStorage storage = GetStorage();
    final customerId = storage.read('id')?.toString();

    print("Customer ID: $customerId");

    setLoading(true);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _clientCode = response.body.replaceAll('"', '');
        _errorMessage = null;
        await sendOrderCode(
          wallpostId: wallpostId,
          orderCode: _clientCode,
          customerId: customerId,
        );
      } else {
        _clientCode = null;
        _errorMessage = 'Failed to fetch Order code';
      }
    } catch (e) {
      _clientCode = null;
      _errorMessage = 'Error: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendOrderCode({
    required String wallpostId,
    required String? orderCode,
    required String? customerId,
  }) async {
    final body = {
      'wallpost_id': wallpostId,
      'order_code': orderCode ?? '',
      'customer_id': customerId ?? '',
    };

    try {
      final response = await http.post(
        Uri.parse(AppUrl.clientWallOrderEndPint),
        body: body,
      );

      if (response.statusCode == 200) {
        print("Order sent successfully: ${response.body}");
      } else {
        print("Failed to send order: ${response.body}");
      }
    } catch (e) {
      print("Error sending order: $e");
    }
  }
}

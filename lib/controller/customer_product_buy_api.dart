import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';

class CustomerProductBuyApi with ChangeNotifier {
  String? _clientCode;
  String? _errorMessage;
  bool _isLoading = false; // Loading state variable

  String? get clientCode => _clientCode;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading; // Getter for loading state

  Future<void> fetchCustomerCodeAndSendOrder({
    required String wallpostId,
  }) async {
    final url = AppUrl.generateCustomerOrderCodeEndPint;

    final GetStorage storage = GetStorage();
    final customerId = storage.read('id')?.toString();

    print("Customer ID: $customerId");

    _isLoading = true; // Set loading to true
    notifyListeners(); // Notify listeners about loading state change

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _clientCode = response.body.replaceAll('"', '');
        _errorMessage = null;

        // Call sendOrderCode with the fetched customerId
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
      _isLoading =
          false; // Set loading to false regardless of success or failure
      notifyListeners(); // Notify listeners about loading state change
    }
  }

  Future<void> sendOrderCode({
    required String wallpostId,
    required String? orderCode,
    required String? customerId,
  }) async {
    // Prepare data for sending
    final body = {
      'product_id': wallpostId,
      'order_code': orderCode ?? '',
      'customer_id': customerId ?? '',
    };

    try {
      // Sending data to the second API
      final response = await http.post(
        Uri.parse(AppUrl.customerOrderEndPint),
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

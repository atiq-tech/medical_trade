// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/config/app_url.dart';
// import 'package:medical_trade/utilities/custom_message.dart';

// class CustomerProductBuyApi with ChangeNotifier {
//   String? _clientCode;
//   String? _errorMessage;
//   bool _isLoading = false;

//   String? get clientCode => _clientCode;
//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading;

//   Future<void> fetchCustomerCodeAndSendOrder({
//     required BuildContext context,
//     required String wallpostId,
//   }) async {
//     final url = AppUrl.generateCustomerOrderCodeEndPint;
//     final GetStorage storage = GetStorage();
//     final customerId = storage.read('userId')?.toString();
//     final token = storage.read('loginToken')?.toString();

//     print("Customer ID: $customerId");
//     print("Token: $token");

//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//         _clientCode = decoded["data"]?.toString();

//         print("Fetched Order Code: $_clientCode");
//         _errorMessage = null;

//         await sendOrderCode(
//           context: context,
//           wallpostId: wallpostId,
//           orderCode: _clientCode,
//           customerId: customerId,
//         );
//       } else {
//         _clientCode = null;
//         _errorMessage = 'Failed to fetch Order code';
//         CustomToast.show(
//           context: context,
//           text: _errorMessage!,
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       _clientCode = null;
//       _errorMessage = 'Error: $e';
//       CustomToast.show(
//         context: context,
//         text: _errorMessage!,
//         isSuccess: false,
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> sendOrderCode({
//     required BuildContext context,
//     required String wallpostId,
//     required String? orderCode,
//     required String? customerId,
//   }) async {
//     final GetStorage storage = GetStorage();
//     final token = storage.read('loginToken')?.toString();

//     print("========== SENDING ORDER ==========");
//     print("WallPost ID     : $wallpostId");
//     print("Order Code      : $orderCode");
//     print("Customer ID     : $customerId");
//     print("Token           : $token");
//     print("===================================");

//     final body = {
//       'product_id': wallpostId,
//       'order_id': orderCode ?? '',
//       'user_id': customerId ?? '',
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(AppUrl.customerOrderEndPint),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//         body: body,
//       );

//       if (response.statusCode == 200) {
//         print("Order sent successfully: ${response.body}");
//         CustomToast.show(
//           context: context,
//           text: "Order sent successfully",
//           isSuccess: true,
//         );
//       } else {
//         print("Failed to send order: ${response.body}");
//         CustomToast.show(
//           context: context,
//           text: "Failed to send order",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       print("Error sending order: $e");
//       CustomToast.show(
//         context: context,
//         text: "Error sending order",
//         isSuccess: false,
//       );
//     }
//   }
// }






















//===============main===========
import 'dart:convert';

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
  final customerId = storage.read('userId')?.toString();
  final token = storage.read('loginToken')?.toString();

  print("Customer ID: $customerId");
  print("Token: $token");

  _isLoading = true;
  notifyListeners();

  try {
    final response = await http.get(Uri.parse(url),
     headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // এখানে data → OR0002 পাওয়া যাবে
      _clientCode = decoded["data"]?.toString();

      print("Fetched Order Code: $_clientCode");

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
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> sendOrderCode({
    required String wallpostId,
    required String? orderCode,
    required String? customerId,
  }) async {
    final GetStorage storage = GetStorage();
    final token = storage.read('loginToken')?.toString();
  print("========== SENDING ORDER ==========");
  print("WallPost ID     : $wallpostId");
  print("Order Code      : $orderCode");
  print("Customer ID     : $customerId");
  print("====================================");

    // Prepare data for sending
    final body = {
      'product_id': wallpostId,
      'order_id': orderCode ?? '',
      'user_id': customerId ?? '',
    };

    try {
      // Sending data to the second API
      final response = await http.post(
        Uri.parse(AppUrl.customerOrderEndPint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
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









///====old============
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/config/app_url.dart';

// class CustomerProductBuyApi with ChangeNotifier {
//   String? _clientCode;
//   String? _errorMessage;
//   bool _isLoading = false; // Loading state variable

//   String? get clientCode => _clientCode;
//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading; // Getter for loading state

//   Future<void> fetchCustomerCodeAndSendOrder({
//     required String wallpostId,
//   }) async {
//     final url = AppUrl.generateCustomerOrderCodeEndPint;

//     final GetStorage storage = GetStorage();
//     final customerId = storage.read('userId')?.toString();

//     print("Customer ID: $customerId");

//     _isLoading = true; // Set loading to true
//     notifyListeners(); // Notify listeners about loading state change

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         _clientCode = response.body.replaceAll('"', '');
//         _errorMessage = null;

//         // Call sendOrderCode with the fetched customerId
//         await sendOrderCode(
//           wallpostId: wallpostId,
//           orderCode: _clientCode,
//           customerId: customerId,
//         );
//       } else {
//         _clientCode = null;
//         _errorMessage = 'Failed to fetch Order code';
//       }
//     } catch (e) {
//       _clientCode = null;
//       _errorMessage = 'Error: $e';
//     } finally {
//       _isLoading =
//           false; // Set loading to false regardless of success or failure
//       notifyListeners(); // Notify listeners about loading state change
//     }
//   }

//   Future<void> sendOrderCode({
//     required String wallpostId,
//     required String? orderCode,
//     required String? customerId,
//   }) async {
//     // Prepare data for sending
//     final body = {
//       'product_id': wallpostId,
//       'order_code': orderCode ?? '',
//       'customer_id': customerId ?? '',
//     };

//     try {
//       // Sending data to the second API
//       final response = await http.post(
//         Uri.parse(AppUrl.customerOrderEndPint),
//         body: body,
//       );

//       if (response.statusCode == 200) {
//         print("Order sent successfully: ${response.body}");
//       } else {
//         print("Failed to send order: ${response.body}");
//       }
//     } catch (e) {
//       print("Error sending order: $e");
//     }
//   }
// }

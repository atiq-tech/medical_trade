import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medical_trade/config/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool isLoggedIn() {
    final box = GetStorage();
    return box.read('loginToken') != null;
  }

  void logout() {
    final box = GetStorage();
    box.erase();
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> login(String userName, String password) async {
    _setLoading(true);

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _errorMessage = 'No internet connection';
      _setLoading(false);
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse(AppUrl.loginEndPint),
        body: {
          "username": userName,
          "password": password,
        },
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == "success") {
          final box = GetStorage();
          final prefs = await SharedPreferences.getInstance();

          final token = responseData['token'];
          final userData = responseData['user'];

          final id = userData['id']?.toString() ?? '';
          final name = userData['name'] ?? '';
          final username = userData['username'] ?? '';
          final image = userData['image'] ?? '';
          final role = userData['role'] ?? '';
          final branchId = userData['branch_id']?.toString() ?? '';

          /// ✅ PERMISSIONS
          List permissionList = userData['permissions'] ?? [];

          prefs.setString("saleYourOldMachine","${permissionList.contains("client_post")}");
          prefs.setString("wallPost","${permissionList.contains("wall_post")}");
          prefs.setString("engineerSupport","${permissionList.contains("engineer_support")}");
          prefs.setString("patientEntry","${permissionList.contains("patient_entry")}");
          prefs.setString("doctorEntry","${permissionList.contains("doctor_entry")}");
          prefs.setString("testEntry","${permissionList.contains("test_entry")}");
          prefs.setString("appointmentEntry","${permissionList.contains("outdoor_patient")}");
          prefs.setString("bankTrEntry","${permissionList.contains("bank_transaction_entry")}");
          prefs.setString("cashTrEntry","${permissionList.contains("cash_transaction_entry")}");
          prefs.setString("patientPayment", "${permissionList.contains("patient_payment_medicine")}");
          prefs.setString("commissionPayment", "${permissionList.contains("commission_payment")}");
          prefs.setString("patientList","${permissionList.contains("patient_list",)}");
    

          /// ✅ SAVE USER INFO
          box.write('loginToken', token);
          box.write('userId', id);
          box.write('name', name);
          box.write('username', username);
          box.write('image', image);
          box.write('role', role);
          box.write('branchId', branchId);

          print("Login Success ✅");
          print("User: $name");
          print("Token: $token");

          _errorMessage = null;
          _setLoading(false);
          return true;
        } else {
          _errorMessage = responseData['message'] ?? 'Login failed';
        }
      } else {
        _errorMessage = 'Server Error: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }

    return false;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}










//-----------13----------
// import 'dart:convert';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_trade/config/app_url.dart';

// class LoginAuthProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   bool isLoggedIn() {
//     final box = GetStorage();
//     return box.read('loginToken') != null;
//   }

//   void logout() {
//     final box = GetStorage();
//     box.erase();
//     _errorMessage = null;
//     notifyListeners();
//   }

//   Future<bool> login(String userName, String password) async {
//     _setLoading(true);

//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       _errorMessage = 'No internet connection';
//       _setLoading(false);
//       return false;
//     }

//     final url = AppUrl.loginEndPint;

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {
//           "username": userName,
//           "password": password,
//         },
//       );

//       print("Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);

//         if (responseData['status'] == "success") {
//           final box = GetStorage();

//           /// ✅ FIXED HERE
//           final token = responseData['token'];
//           final userData = responseData['user'];

//           /// Safely extract values
//           final id = userData['id']?.toString() ?? '';
//           final name = userData['name'] ?? '';
//           final username = userData['username'] ?? '';
//           final image = userData['image'] ?? '';
//           final role = userData['role'] ?? '';
//           final branchId = userData['branch_id']?.toString() ?? '';

//           /// Save to storage
//           box.write('loginToken', token);
//           box.write('userId', id);
//           box.write('name', name);
//           box.write('username', username);
//           box.write('image', image);
//           box.write('role', role);
//           box.write('branchId', branchId);

//           print("Login Success ✅");
//           print("Token: $token");
//           print("User ID: $id");
//           print("Name: $name");

//           _errorMessage = null;
//           _setLoading(false);
//           return true;
//         } else {
//           _errorMessage = responseData['message'] ?? 'Login failed';
//         }
//       } else {
//         _errorMessage = 'Server Error: ${response.statusCode}';
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _setLoading(false);
//     }

//     return false;
//   }

//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }
// }









// ===========main code =============
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/config/api_error_service.dart';
// import 'package:medical_trade/config/app_url.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class LoginAuthProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   bool isLoggedIn() {
//     final box = GetStorage();
//     return box.read('loginToken') != null;
//   }

//   void logout() {
//     final box = GetStorage();
//     box.erase();
//     _errorMessage = null;
//     notifyListeners();
//   }

//   Future<bool> login(String userName, String password) async {
//     _setLoading(true);

//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       _errorMessage = 'No internet connection';
//       ErrorHandling.handleError(
//         ApiException(_errorMessage!),
//         customMessage: _errorMessage!,
//       );
//       _setLoading(false);
//       notifyListeners();
//       return false;
//     }

//     final url = AppUrl.loginEndPint;

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {
//           "username": userName,
//           "password": password,
//         },
//       );
//       print("Response userName: ${userName}");
//       print("Response password: ${password}");

//       print("Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);

//         if (responseData['status'] == "success") {
//            //"status": "success",
//           print("Login successful: ${response.body}");

//           final box = GetStorage();
//           final token = responseData['token'];
//           final customerData = responseData['customer']; // 👈 fixed here

//           // Some fields might be null, so safely extract them
//           final id = customerData['id']?.toString() ?? '';
//           final name = customerData['customer_name'] ?? '';
//           final username = customerData['username'] ?? '';
//           final image = customerData['image'] ?? '';
//           final division = customerData['division_id']?.toString() ?? '';
//           final address = customerData['address'] ?? '';
//           final organization = customerData['organization_name'] ?? '';
//           final title = customerData['title'] ?? '';
//           final mobile = customerData['mobile'] ?? '';

//           // Save data to GetStorage
//           box.write('loginToken', token);
//           box.write('userId', id);
//           box.write('userName', name);
//           box.write('username', username);
//           box.write('userImage', image);
//           box.write('division', division);
//           box.write('address', address);
//           box.write('organization', organization);
//           box.write('title', title);
//           box.write('mobile', mobile);

//           print("Token stored: $token");
//           print("User Name stored: $name");
//           print("Username stored: $username");
//           print("Division stored: $division");
//           print("User Id stored: $id");

//           _errorMessage = null;
//           _setLoading(false);
//           notifyListeners();
//           return true;
//         } else {
//           _errorMessage =
//               'Login failed: ${responseData['message'] ?? 'Unknown error'}';
//           ErrorHandling.handleError(
//             ApiException(_errorMessage!),
//             customMessage: _errorMessage!,
//           );
//         }
//       } else {
//         _errorMessage = 'Login failed: ${response.reasonPhrase}';
//         ErrorHandling.handleError(
//           ApiException(_errorMessage!),
//           customMessage: _errorMessage!,
//         );
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         _errorMessage = 'Network error: ${e.message}';
//         ErrorHandling.handleError(e);
//       } else {
//         _errorMessage = 'Error: ${e.toString()}';
//         ErrorHandling.handleError(
//           e is Exception ? e : Exception(e.toString()),
//         );
//       }
//     } finally {
//       _setLoading(false);
//       notifyListeners();
//     }
//     return false;
//   }

//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }
// }











////=========
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/config/api_error_service.dart';
// import 'package:medical_trade/config/app_url.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class LoginAuthProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   // Check if the user is logged in
//   bool isLoggedIn() {
//     final box = GetStorage();
//     return box.read('loginToken') != null; // Check if token exists
//   }

//   // Logout function to clear user data
//   void logout() {
//     final box = GetStorage();
//     box.erase(); // Clears all stored data
//     _errorMessage = null; // Reset any error messages
//     notifyListeners();
//   }

//   Future<bool> login(String userName, String password) async {
//     _setLoading(true);

//     // Check internet connection before making the API call
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       _errorMessage = 'No internet connection';
//       ErrorHandling.handleError(
//         ApiException(_errorMessage!),
//         customMessage: _errorMessage!,
//       );
//       _setLoading(false);
//       notifyListeners();
//       return false;
//     }

//     final url = AppUrl.loginEndPint;

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {
//           "username": userName,
//           "password": password,
//         },
//       );

//       print("Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         if (responseData['status'] == "success") {
//           print("Login successful: ${response.body}");

//           final box = GetStorage();
//           final token = responseData['token'];
//           final userData = responseData['data'];
//           final imageName = userData['image_name'];
//           final name = userData['name'];
//           final division = userData['division_id'];
//           final district = userData['district_id'];
//           final id = userData['id'];

//           box.write('loginToken', token);
//           box.write('userName', name);
//           box.write('userImageName', imageName);
//           box.write('userDivision', division ?? '');
//           box.write('userDistrict', district ?? '');
//           box.write('id', id ?? '');

//           print("Token stored: $token");
//           print("User Name stored: $name");
//           print("Image Name stored: $imageName");
//           print("Division stored: $division");
//           print("District stored: $district");
//           print("Id: $id");

//           _errorMessage = null;
//           return true;
//         } else {
//           _errorMessage =
//               'Login failed: ${responseData['message'] ?? 'Unknown error'}';
//           ErrorHandling.handleError(ApiException(_errorMessage!),
//               customMessage: _errorMessage!);
//         }
//       } else {
//         _errorMessage = 'Login failed: ${response.reasonPhrase}';
//         ErrorHandling.handleError(ApiException(_errorMessage!),
//             customMessage: _errorMessage!);
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         _errorMessage = 'Network error: ${e.message}';
//         ErrorHandling.handleError(e);
//       } else {
//         _errorMessage = 'Error: ${e.toString()}';
//         ErrorHandling.handleError(e is Exception
//             ? e
//             : Exception(
//                 e.toString(),
//               ));
//       }
//     } finally {
//       _setLoading(false);
//       notifyListeners();
//     }
//     return false;
//   }

//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }
// }

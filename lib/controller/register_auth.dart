import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/utilities/custom_message.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RegisterAuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  String? _customerCode;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCustomerCode() async {
  final url = AppUrl.getCustomerCodeEndPoint;
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['success'] == true && responseData['data'] != null) {
        _customerCode = responseData['data']; // শুধু code অংশটা নিচ্ছে
        _errorMessage = null;
        print("Customer Code fetched: $_customerCode");
      } else {
        _customerCode = null;
        _errorMessage =
            'Invalid response: ${responseData['message'] ?? 'Unknown error'}';
        print("Error: $_errorMessage");
      }
    } else {
      _customerCode = null;
      _errorMessage =
          'Failed to fetch customer code (Status: ${response.statusCode})';
      print("Error: $_errorMessage");
    }
  } catch (e) {
    _customerCode = null;
    _errorMessage = 'Failed to fetch customer code';
    ErrorHandling.handleError(
      e is Exception ? e : Exception(e.toString()),
      customMessage: _errorMessage!,
    );
  }
  notifyListeners();
}

  Future<bool> register({
    required BuildContext context,
    required String organizationName,
    required String customerName,
    required String title,
    required String username,
    required String mobile,
    required String address,
    required String divisionId,
    required String districtId,
    required String upazila,
    required String password,
    required String confirmPassword,
    File? image,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      CustomToast.show(
        context: context,
        text: 'No internet connection',
        isSuccess: false,
      );
      return false;
    }

    if (_customerCode == null) {
      await fetchCustomerCode();
      if (_customerCode == null) {
        CustomToast.show(
          context: context,
          text: 'Failed to fetch customer code',
          isSuccess: false,
        );
        return false;
      }
    }
    final url = AppUrl.registerEndPint;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Accept'] = 'application/json'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['customer_id'] = _customerCode!
        ..fields['organization_name'] = organizationName
        ..fields['customer_name'] = customerName
        ..fields['title'] = title
        ..fields['username'] = username
        ..fields['mobile'] = mobile
        ..fields['address'] = address
        ..fields['division_id'] = divisionId
        ..fields['area_id'] = districtId
        ..fields['upazilla'] = upazila
        ..fields['password'] = password
        ..fields['password_confirmation'] = confirmPassword;
        

      // Only add the image file if it's not null
      if (image != null) {
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
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("STATUS CODE = ${response.statusCode}");
      print("RESPONSE BODY = $responseBody");


      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);
        if (responseData['status'] == "success") {
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          String errorMessage = 'Registration failed';
          if (responseData.containsKey('errors')) {
            final errors = responseData['errors'] as Map<String, dynamic>;
            errorMessage = errors.values.join(', ');
          } else if (responseData.containsKey('message')) {
            errorMessage = responseData['message'];
          }
          _errorMessage = errorMessage;
          CustomToast.show(
            // ignore: use_build_context_synchronously
            context: context,
            text: _errorMessage.toString(),
            isSuccess: false,
          );
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        _errorMessage =
            'Failed to register. Status code: ${response.statusCode}';
        CustomToast.show(
          // ignore: use_build_context_synchronously
          context: context,
          text: _errorMessage.toString(),
          isSuccess: false,
        );
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      ErrorHandling.handleError(e as Exception,
          customMessage: 'Registration failed');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}


















// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:medical_trade/config/api_error_service.dart';
// import 'package:medical_trade/config/app_url.dart';
// import 'package:medical_trade/utilities/custom_message.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class RegisterAuthProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;

//   String? _customerCode;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   Future<void> fetchCustomerCode() async {
//   final url = AppUrl.getCustomerCodeEndPoint;
//   try {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);

//       if (responseData['success'] == true && responseData['data'] != null) {
//         _customerCode = responseData['data']; // শুধু code অংশটা নিচ্ছে
//         _errorMessage = null;
//         print("Customer Code fetched: $_customerCode");
//       } else {
//         _customerCode = null;
//         _errorMessage =
//             'Invalid response: ${responseData['message'] ?? 'Unknown error'}';
//         print("Error: $_errorMessage");
//       }
//     } else {
//       _customerCode = null;
//       _errorMessage =
//           'Failed to fetch customer code (Status: ${response.statusCode})';
//       print("Error: $_errorMessage");
//     }
//   } catch (e) {
//     _customerCode = null;
//     _errorMessage = 'Failed to fetch customer code';
//     ErrorHandling.handleError(
//       e is Exception ? e : Exception(e.toString()),
//       customMessage: _errorMessage!,
//     );
//   }

//   notifyListeners();
// }

// ///===old====
//   // Future<void> fetchCustomerCode() async {
//   //   final url = AppUrl.getCustomerCodeEndPoint;
//   //   try {
//   //     final response = await http.get(Uri.parse(url));
//   //     if (response.statusCode == 200) {
//   //       _customerCode = response.body;
//   //       _errorMessage = null; // Reset error message on success
//   //     } else {
//   //       _customerCode = null;
//   //       _errorMessage = 'Failed to fetch customer code';
//   //     }
//   //   } catch (e) {
//   //     _customerCode = null;
//   //     ErrorHandling.handleError(e as Exception,
//   //         customMessage: 'Failed to fetch customer code');
//   //   }
//   //   notifyListeners();
//   // }

//   Future<bool> register({
//     required BuildContext context,
//     required String organizationName,
//     required String customerName,
//     required String title,
//     required String username,
//     required String mobile,
//     required String address,
//     required String divisionId,
//     required String districtId,
//     required String upazila,
//     required String password,
//     File? image, // Accepting a nullable image
//   }) async {
//     // Check internet connection
//     var connectivityResult = await Connectivity().checkConnectivity();
//     // ignore: unrelated_type_equality_checks
//     if (connectivityResult == ConnectivityResult.none) {
//       CustomToast.show(
//         // ignore: use_build_context_synchronously
//         context: context,
//         text: 'No internet connection',
//         isSuccess: false,
//       );
//       return false;
//     }

//     if (_customerCode == null) {
//       // Fetch customer code if not already fetched
//       await fetchCustomerCode();
//       if (_customerCode == null) {
//         CustomToast.show(
//           // ignore: use_build_context_synchronously
//           context: context,
//           text: 'Failed to fetch customer code',
//           isSuccess: false,
//         );
//         return false;
//       }
//     }

//     final url = AppUrl.registerEndPint;

//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(url))
//         ..fields['customer_code'] = _customerCode!
//         ..fields['organization_name'] = organizationName
//         ..fields['customer_name'] = customerName
//         ..fields['title'] = title
//         ..fields['username'] = username
//         ..fields['mobile'] = mobile
//         ..fields['address'] = address
//         ..fields['division_id'] = divisionId
//         ..fields['district_id'] = districtId
//         ..fields['upazila'] = upazila
//         ..fields['password'] = password;

//       // Only add the image file if it's not null
//       if (image != null) {
//         String contentType;
//         final fileExtension = image.path.split('.').last.toLowerCase();
//         switch (fileExtension) {
//           case 'jpg':
//           case 'jpeg':
//             contentType = 'image/jpeg';
//             break;
//           case 'png':
//             contentType = 'image/png';
//             break;
//           default:
//             contentType = 'application/octet-stream';
//         }

//         var imageFile = await http.MultipartFile.fromPath(
//           'image',
//           image.path,
//           contentType: MediaType.parse(contentType),
//         );
//         request.files.add(imageFile);
//       }

//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(responseBody);
//         if (responseData['status'] == true) {
//           _isLoading = false;
//           notifyListeners();
//           return true;
//         } else {
//           String errorMessage = 'Registration failed';
//           if (responseData.containsKey('errors')) {
//             final errors = responseData['errors'] as Map<String, dynamic>;
//             errorMessage = errors.values.join(', ');
//           } else if (responseData.containsKey('message')) {
//             errorMessage = responseData['message'];
//           }
//           _errorMessage = errorMessage;
//           CustomToast.show(
//             // ignore: use_build_context_synchronously
//             context: context,
//             text: _errorMessage.toString(),
//             isSuccess: false,
//           );
//           _isLoading = false;
//           notifyListeners();
//           return false;
//         }
//       } else {
//         _errorMessage =
//             'Failed to register. Status code: ${response.statusCode}';
//         CustomToast.show(
//           // ignore: use_build_context_synchronously
//           context: context,
//           text: _errorMessage.toString(),
//           isSuccess: false,
//         );
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = 'Error: $e';
//       ErrorHandling.handleError(e as Exception,
//           customMessage: 'Registration failed');
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/utilities/custom_message.dart';

class AddRequirementProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> addRequirement({
    required BuildContext context,
    required String name,
    required String mobile,
    required String address,
    required String description,
    required VoidCallback onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _isLoading = false;
      notifyListeners();
      CustomToast.show(
        context: context,
        text: "No internet connection",
        isSuccess: false,
      );
      return;
    }

    final url = AppUrl.addRequirementEndPoint;
    final box = GetStorage();

    final userId = box.read('userId');
    final token = box.read('loginToken');

    print("User ID = $userId");
    print("Token = $token");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
// {
//   "name": "Test Requirement",
//   "mobile": "01710123654",
//   "address": "Dhaka",
//   "description": "Demo Description 13"
// }
    request.fields.addAll({
      'name': name,
      'mobile': mobile,
      'address': address,
      'description': description,
    });
    print("Request URL: $url");
    print("Request Headers: ${request.headers}");
    print("Request Fields: ${request.fields}");
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");
      print("Raw Response: ${response.body}");

      if (response.statusCode != 200) {
        CustomToast.show(
          context: context,
          text: "Error: ${response.statusCode}",
          isSuccess: false,
        );
        return;
      }

      final responseJson = jsonDecode(response.body);
      final status = responseJson['success'];
      final message = responseJson['message'];

      if (status == true) {
        CustomToast.show(
          context: context,
          text: message,
          isSuccess: true,
        );
        onSuccess();
      } else {
        CustomToast.show(
          context: context,
          text: message,
          isSuccess: false,
        );
      }
    } catch (e) {
      // print("Error occurred: $e");
      // await ErrorHandling.handleError(e as Exception);
      // CustomToast.show(
      //   context: context,
      //   text: "Failed to save data. Please try again.",
      //   isSuccess: false,
      // );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
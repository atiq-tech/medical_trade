import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medical_trade/config/api_error_service.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/utilities/custom_message.dart';

class EngineeringSupportProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> saveSupportData({
    required BuildContext context,
    required String machineName,
    required String model,
    required String mobile,
    required String machineDetails,
    required String origin,
    required List<File> images,
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

    final url = AppUrl.addEngineerSuportEndPoint;
    final box = GetStorage();
    final id = box.read('id');
    // Creating the Multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['machine_name'] = machineName
      ..fields['model'] = model
      ..fields['origin'] = origin
      ..fields['mobile'] = mobile
      ..fields['description'] = machineDetails
      ..fields['status'] = 'a'
      ..fields['AddBy'] = id.toString()
      ..fields['AddTime'] = DateTime.now().toString()
      ..fields['UpdateBy'] = ''
      ..fields['UpdateTime'] = ''
      ..fields['Engineer_branchid'] = '0';

    // Adding images as multipart files
    for (var image in images) {
      request.files.add(await http.MultipartFile.fromPath(
        'images[]',
        image.path,
        filename: image.path.split('/').last,
      ));
    }

    print("Request URL: $url");
    print("Request Body: ${request.fields}");
    print("Request Images: ${images.map((e) => e.path).toList()}");

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        print("Error: ${response.statusCode} - ${response.body}");

        CustomToast.show(
          context: context,
          text: "Error: ${response.statusCode}",
          isSuccess: false,
        );
        return;
      }

      print("Raw response body: ${response.body}");

      final responseJson = jsonDecode(response.body);
      print("Parsed JSON response: $responseJson");

      final status = responseJson['success'];
      final message = responseJson['message'];

      // Check if the status is 'success'
      if (status == true) {
        CustomToast.show(
          context: context,
          text: message, // Show success message
          isSuccess: true,
        );

        onSuccess();
      } else {
        CustomToast.show(
          context: context,
          text: message,
          isSuccess: false,
        );
        onSuccess();
      }
    } catch (e) {
      print("Error occurred: $e");
      await ErrorHandling.handleError(e as Exception);
      CustomToast.show(
        context: context,
        text: "Failed to save data. Please try again.",
        isSuccess: false,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

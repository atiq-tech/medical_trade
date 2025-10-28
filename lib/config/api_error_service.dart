import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:io';

import 'package:medical_trade/utilities/custom_error_message.dart';

class ErrorHandling {
  static Future<void> handleError(
    Exception exception, {
    String? customMessage,
  }) async {
    String message;

    // Check internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      message = 'No internet connection';
    } else if (exception is TimeoutException) {
      message = 'Network timeout occurred.';
    } else if (exception is SocketException) {
      message = exception.message;
    } else if (exception is ApiException) {
      message = exception.message;
    } else if (customMessage != null) {
      message = customMessage;
    } else {
      message = 'An unknown error occurred.';
    }

    CustomErrorToast.show(
      text: message,
    );
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

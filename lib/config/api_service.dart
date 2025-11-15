import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {
  final GetStorage _storage = GetStorage();

  String? _getToken() {
    return _storage.read('loginToken');
  }

  Future<http.Response?> getRequest(String url) async {
    String? token = _getToken();
    if (token == null) {
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        // print("GET Request Failed: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      // print("GET Request Error: $e");
      return null;
    }
  }

  Future<http.Response?> postRequest(
      String url, Map<String, dynamic> body) async {
    String? token = _getToken();
    if (token == null) {
      // print("Error: Token not found");
      return null;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        // print("POST Request Failed: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      // print("POST Request Error: $e");
      return null;
    }
  }

  Future<http.Response?> postFormData(
    String url, Map<String, String> fields) async {
    String? token = _getToken();
    if (token == null) {
      return null; // Handle the token not found case
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token';

      // Add fields to the request
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      final streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      // Handle error
      return null;
    }
  }

  Future<http.StreamedResponse?> multipartRequest({
    required String url,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
  }) async {
    String? token = _getToken();
    if (token == null) {
      // print("Error: Token not found");
      return null;
    }

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(fields)
        ..files.addAll(files)
        ..headers['Authorization'] = 'Bearer $token';
      // print("Token ${token}");

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        return streamedResponse;
      } else {
        // final responseBody = await streamedResponse.stream.bytesToString();
        //  print(
        //     "Multipart Request Failed: ${streamedResponse.statusCode} - $responseBody");
        return null;
      }
    } catch (e) {
      //   print("Multipart Request Error: $e");
      return null;
    }
  }
}

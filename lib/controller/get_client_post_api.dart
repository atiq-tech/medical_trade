import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/utilities/custom_message.dart';

class GetClientPostProvider with ChangeNotifier {
  String? _errorMessage;
  String? _clientCode;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// =========================
  /// FETCH CLIENT POST CODE
  /// =========================
  Future<void> fetchClientCode() async {
    setLoading(true);

    final storage = GetStorage();
    final token = storage.read('loginToken');

    try {
      final response = await http.get(
        Uri.parse(AppUrl.generateClientPostCodeEndPoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        _clientCode = decoded["data"]; // CP0002
        _errorMessage = null;
      } else {
        _clientCode = null;
        _errorMessage = 'Failed to fetch client code';
      }
    } catch (e) {
      _clientCode = null;
      _errorMessage = 'Error: $e';
    } finally {
      setLoading(false);
    }
  }

  /// =========================
  /// POST CLIENT DATA
  /// =========================
  Future<bool> clientPostData({
    required BuildContext context,
    required String machineName,
    required String price,
    required String model,
    required String condition,
    required String origin,
    required List<String> selectedDivisions,
    required List<String> selectedDistricts,
    required String upazila,
    required String mobile,
    required String description,
    required List<File> images,
    required VoidCallback onSuccess,
  }) async {
    if (_clientCode == null) {
      await fetchClientCode();
    }

    if (_clientCode == null) {
      CustomToast.show(
        context: context,
        text: 'Failed to fetch client code',
        isSuccess: false,
      );
      return false;
    }

    setLoading(true);

    final storage = GetStorage();
    final token = storage.read('loginToken');
    final userId = storage.read('userId');

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.addClientpostEndPoint),
    );

    /// ✅ Headers with TOKEN
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    /// ✅ BASIC TEXT FIELDS
    request.fields.addAll({
      "customer_post_id": _clientCode!,
      "machine_name": machineName,
      "price": price,
      "model": model,
      "condition": condition,
      "origin": origin,
      "mobile": mobile,
      "description": description,
      "upazilla": upazila,
      "validity_date": "",
      "status": "p",
      "AddBy": userId.toString(), // ✅ FIXED
      "Client_branchid": "0",
    });

    /// ✅ MULTIPLE division_id[]
    for (var id in selectedDivisions) {
      request.fields.putIfAbsent("division_id[]", () => id);
    }

    /// ✅ MULTIPLE area_id[]
    for (var id in selectedDistricts) {
      request.fields.putIfAbsent("area_id[]", () => id);
    }

    /// ✅ IMAGES
    for (var image in images) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'images[]',
          image.path,
          filename: image.path.split('/').last,
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("POST RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);

        if (jsonResp["success"] == false) {
          CustomToast.show(
            context: context,
            text: "Machine name already exists",
            isSuccess: false,
          );
          return false;
        }

        CustomToast.show(
          context: context,
          text: "Data posted successfully",
          isSuccess: true,
        );

        onSuccess();
        _clientCode = null;
        return true;
      } else {
        // CustomToast.show(
        //   context: context,
        //   text: "Failed to post data",
        //   isSuccess: false,
        // );
        return false;
      }
    } catch (e) {
      // CustomToast.show(
      //   context: context,
      //   text: 'Error: $e',
      //   isSuccess: false,
      // );
      return false;
    } finally {
      setLoading(false);
    }
  }
}












//==========main====
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_trade/config/app_url.dart';
// import 'package:medical_trade/utilities/custom_message.dart';

// class GetClientPostProvider with ChangeNotifier {
//   String? _errorMessage;
//   String? _clientCode;
//   bool _isLoading = false; // Updated to be mutable
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   // Toggle loading state
//   void setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//     Future<void> fetchClientCode() async {
//     setLoading(true);
//     final url = AppUrl.generateClientPostCodeEndPoint;

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);

//         _clientCode = decoded["data"];  // এখানে পাবেন CP0002
//         _errorMessage = null;
//       } else {
//         _clientCode = null;
//         _errorMessage = 'Failed to fetch client code';
//       }
//     } catch (e) {
//       _clientCode = null;
//       _errorMessage = 'Error: $e';
//     } finally {
//       setLoading(false);
//     }
//   }


//   // Future<List<Map<String, dynamic>>> prepareImagesForUpload(
//   //     List<File> images) async {
//   //   List<Map<String, dynamic>> imagesList = [];
//   //   for (var image in images) {
//   //     try {
//   //       final imageName = image.uri.pathSegments.last;
//   //       imagesList.add({"Clientpost_Image": imageName});
//   //       print('Image prepared for upload: $imageName');
//   //     } catch (e) {
//   //       print('Error preparing image for upload: $e');
//   //     }
//   //   }
//   //   return imagesList;
//   // }

//   Future<bool> clientPostData({
//   required BuildContext context,
//   required String machineName,
//   required String price,
//   required String model,
//   required String condition,
//   required String origin,
//   required List<String> selectedDivisions,
//   required List<String> selectedDistricts,
//   required String upazila,
//   required String validityDate,
//   required String mobile,
//   required String description,
//   required List<File> images,
//   required VoidCallback onSuccess,
// }) async {

//   if (_clientCode == null) {
//     await fetchClientCode();
//   }

//   if (_clientCode == null) {
//     CustomToast.show(
//       context: context,
//       text: 'Failed to fetch client code',
//       isSuccess: false,
//     );
//     return false;
//   }

//   setLoading(true);

//   final url = Uri.parse(AppUrl.addClientpostEndPoint);
//   final request = http.MultipartRequest('POST', url);

//   /* BASIC TEXT FIELDS */
//   request.fields.addAll({
//     "customer_post_id": _clientCode!,
//     "machine_name": machineName,
//     "price": price,
//     "model": model,
//     "condition": condition,
//     "origin": origin,
//     "mobile": mobile,
//     "description": description,
//     "upazilla": upazila,
//     "validity_date": validityDate,
//     "status": "p",
//     "AddBy": "1",
//     "Client_branchid": "0",
//   });

//   /* MULTIPLE division_id[] */
//   for (var id in selectedDivisions) {
//     request.fields.putIfAbsent("division_id[]", () => id);
//   }

//   /* MULTIPLE area_id[] */
//   for (var id in selectedDistricts) {
//     request.fields.putIfAbsent("area_id[]", () => id);
//   }

//    // Adding images as multipart files
//     for (var image in images) {
//       request.files.add(await http.MultipartFile.fromPath(
//         'images[]',
//         image.path,
//         filename: image.path.split('/').last,
//       ));
//     }

//   try {
//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     print("POST RESPONSE => ${response.body}");

//     if (response.statusCode == 200) {
//       final jsonResp = jsonDecode(response.body);

//       if (jsonResp["success"] == false) {
//         CustomToast.show(
//           context: context,
//           text: "Machine name already exists",
//           isSuccess: false,
//         );
//         return false;
//       }

//       CustomToast.show(
//         context: context,
//         text: "Data posted successfully",
//         isSuccess: true,
//       );

//       onSuccess();
//       _clientCode = null;
//       return true;
//     } else {
//       CustomToast.show(
//         context: context,
//         text: "Failed to post data",
//         isSuccess: false,
//       );
//       return false;
//     }
//   } catch (e) {
//     CustomToast.show(
//       context: context,
//       text: 'Error: $e',
//       isSuccess: false,
//     );
//     return false;
//   } finally {
//     setLoading(false);
//   }
// }

// }













// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_trade/config/app_url.dart';
// import 'package:medical_trade/utilities/custom_message.dart';

// class GetClientPostProvider with ChangeNotifier {
//   String? _errorMessage;
//   String? _clientCode;
//   bool _isLoading = false; // Updated to be mutable
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   // Toggle loading state
//   void setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   Future<void> fetchClientCode() async {
//     setLoading(true);
//     final url = AppUrl.generateClientPostCodeEndPoint;
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         _clientCode = response.body.replaceAll('"', '');
//         _errorMessage = null;
//       } else {
//         _clientCode = null;
//         _errorMessage = 'Failed to fetch client code';
//       }
//     } catch (e) {
//       _clientCode = null;
//       _errorMessage = 'Error: $e';
//     } finally {
//       setLoading(false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> prepareImagesForUpload(
//       List<File> images) async {
//     List<Map<String, dynamic>> imagesList = [];
//     for (var image in images) {
//       try {
//         final imageName = image.uri.pathSegments.last;
//         imagesList.add({"Clientpost_Image": imageName});
//         print('Image prepared for upload: $imageName');
//       } catch (e) {
//         print('Error preparing image for upload: $e');
//       }
//     }
//     return imagesList;
//   }

//   Future<bool> clientPostData({
//     required BuildContext context,
//     required String machineName,
//     required String price,
//     required String model,
//     required String condition,
//     required String origin,
//     required List<String> selectedDivisions,
//     required List<String> selectedDistricts,
//     required String upazila,
//     required String mobile,
//     required String description,
//     required List<File> images,
//     required VoidCallback onSuccess,
//   }) async {
//     if (_clientCode == null) {
//       await fetchClientCode();
//     }

//     if (_clientCode == null) {
//       CustomToast.show(
//         context: context,
//         text: 'Failed to fetch client code',
//         isSuccess: false,
//       );
//       return false;
//     }

//     setLoading(true);
//     print(selectedDivisions);
//     print(selectedDistricts);

//     final url = Uri.parse(AppUrl.addClientpostEndPoint);
//     final request = http.MultipartRequest('POST', url);

//     // Adding text fields to the form-data
//     request.fields.addAll({
//       "Client_Code": _clientCode!,
//       "Machine_Name": machineName,
//       "Machine_Price": price,
//       "Machine_Model": model,
//       "Machine_condition": condition,
//       "origin": origin,
//       "mobile": mobile,
//       "description": description,
//       "division_id": selectedDivisions.first,
//       "district_id": selectedDistricts.first,
//       "upazila": upazila,
//       "status": "p",
//       "AddBy": "1",
//       "AddTime": "",
//       "UpdateBy": "",
//       "UpdateTime": "",
//       "Client_branchid": "0",
//     });

//     // Adding images as multipart files
//     for (var image in images) {
//       try {
//         request.files.add(await http.MultipartFile.fromPath(
//           'images[]',
//           image.path,
//           filename: image.uri.pathSegments.last,
//         ));
//       } catch (e) {
//         print('Error adding image to request: $e');
//       }
//     }

//     try {
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         final responseJson = jsonDecode(response.body);

//         if (responseJson['success'] == false) {
//           CustomToast.show(
//             context: context,
//             text: 'Machine name already exists',
//             isSuccess: false,
//           );
//           return false;
//         }

//         CustomToast.show(
//           context: context,
//           text: 'Data posted successfully',
//           isSuccess: true,
//         );

//         onSuccess();
//         _clientCode = null;
//         return true;
//       } else {
//         CustomToast.show(
//           context: context,
//           text: 'Failed to post data',
//           isSuccess: false,
//         );
//         return false;
//       }
//     } catch (e) {
//       CustomToast.show(
//         context: context,
//         text: 'Error: $e',
//         isSuccess: false,
//       );
//       return false;
//     } finally {
//       setLoading(false);
//     }
//   }
// }

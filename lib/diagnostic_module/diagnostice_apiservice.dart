import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/models/patients_model.dart';

class DiagnosticeApiservice {
  // Read token from GetStorage
  static String getToken() {
    final box = GetStorage();
    return box.read('loginToken') ?? "";
  }
  //==================Product List =======================
  static fetchAllPatients() async {
    String link = AppUrl.getPatientEndPoint;
    final token = getToken();
    try {
      Response response = await Dio().get(link,
         data: {
              //"categoryId": "$categoryId"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var item = response.data;
      print("All Patient Data======$item");
      return List.from(item).map((e) => PatientsModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

}
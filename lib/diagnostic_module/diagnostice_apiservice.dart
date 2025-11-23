import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/models/agents_model.dart';
import 'package:medical_trade/diagnostic_module/models/bank_account_model.dart';
import 'package:medical_trade/diagnostic_module/models/doctors_model.dart';
import 'package:medical_trade/diagnostic_module/models/patients_model.dart';
import 'package:medical_trade/diagnostic_module/models/specimens_model.dart';
import 'package:medical_trade/diagnostic_module/models/test_entry_model.dart';

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

  //==================Specimens List =======================
  static fetchSpecimens() async {
    String link = AppUrl.getSpecimensEndPoint;
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
      print("All Specimens Data======$item");
      return List.from(item).map((e) => SpecimensModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  //==================Specimens List =======================
  static fetchTestEntry() async {
    String link = AppUrl.getTestEntryEndPoint;
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
      print("All TestEntry Data======$item");
      return List.from(item).map((e) => TestEntryModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  //==================get-doctor List =======================
  static fetchAllDoctors() async {
    String link = AppUrl.getDoctorEndPoint;
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
      print("All get-doctor Data======$item");
      return List.from(item).map((e) => DoctorsModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  //==================get-bank-accounts List =======================
  static fetchBankAccount() async {
    String link = AppUrl.getBankAccountEndPoint;
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
      print("All get-bank Data======$item");
      return List.from(item).map((e) => BankAccountModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }


  //==================get-Agents List =======================
  static fetchAllAgents() async {
    String link = AppUrl.getAgentsEndPoint;
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
      print("All get-Agents Data======$item");
      return List.from(item).map((e) => AgentsModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  
}
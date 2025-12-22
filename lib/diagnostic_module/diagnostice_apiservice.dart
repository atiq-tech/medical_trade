import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/models/accounts_model.dart';
import 'package:medical_trade/diagnostic_module/models/agents_model.dart';
import 'package:medical_trade/diagnostic_module/models/available_slots_model.dart';
import 'package:medical_trade/diagnostic_module/models/bank_account_model.dart';
import 'package:medical_trade/diagnostic_module/models/bank_transaction_model.dart';
import 'package:medical_trade/diagnostic_module/models/cash_transaction_model.dart';
import 'package:medical_trade/diagnostic_module/models/commission_payment_model.dart';
import 'package:medical_trade/diagnostic_module/models/department_module.dart';
import 'package:medical_trade/diagnostic_module/models/doctors_model.dart';
import 'package:medical_trade/diagnostic_module/models/patient_payment_model.dart';
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
  
    //==================get-Accounts List =======================
  static fetchAllAccounts() async {
    String link = AppUrl.getAccountsEndPoint;
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
      print("All get-Accounts Data======$item");
      return List.from(item).map((e) => AccountsModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  
   //==================get-Agents List =======================
  static fetchDepartment(String? useFor) async {
    String link = AppUrl.getDepartmentEndPoint;
    final token = getToken();
    try {
      Response response = await Dio().post(link,
         data: {
              "use_for": "$useFor"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var item = response.data;
      print("All get-Departments Data======$item");
      return List.from(item).map((e) => DepartmentModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  //==================get-CommissionPayment List =======================
  static fetchCommissionPayment(String? dateFrom,String? dateTo) async {
    String link = AppUrl.getCommissionPayEndPoint;
    final token = getToken();
    try {
      Response response = await Dio().post(link,
         data: {
            "start_date":"$dateFrom",
            "end_date":"$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var item = response.data;
      print("get-commission-payment Data======$item");
      return List.from(item).map((e) => CommissionPaymentModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  //==================get-Patient Payment List =======================
  static fetchPatientPayment(String? dateFrom,String? dateTo) async {
    String link = AppUrl.getPatientPayEndPoint;
    final token = getToken();
    try {
      Response response = await Dio().post(link,
         data: {
            "start_date":"$dateFrom",
            "end_date":"$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var item = response.data;
      print("get-Patient Payment Data======$item");
      return List.from(item).map((e) => PatientPaymentModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

 //==================get-cash-transactions List =======================
  static fetchCashTransaction(
    String? accountId,
    String? dateFrom,
    String? dateTo,
    String? transactionType,
    String? paymentType,
    String? bankAccountId
    ) async {
    String link = AppUrl.getCashTransactionEndPoint;
    final token = getToken();
    try {
      Response response = await Dio().post(link,
         data: {
            "accountId": "$accountId",
            "start_date":"$dateFrom",
            "end_date":"$dateTo",
            "transactionType": "$transactionType",
            "payment_type": "$paymentType",
            "bank_account_id": "$bankAccountId"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var item = response.data;
      print("get-cash-transactions Data======$item");
      return List.from(item).map((e) => CashTransactionModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  
  //==================get-bank-transactions List =======================
  static fetchBankTransaction(String? dateFrom,String? dateTo,String? transactionType,String? bankAccountId) async {
    String link = AppUrl.getBankTransactionEndPoint;
    final token = getToken();
    try {
      Response response = await Dio().post(link,
         data: {
            "start_date":"$dateFrom",
            "end_date":"$dateTo",
            "transactionType": "$transactionType",
            "bank_account_id": "$bankAccountId"
          },
    
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var item = response.data;
      print("get-BankT-transactions Data======$item");
      return List.from(item).map((e) => BankTransactionModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

 //==================get-Available-Slots List =======================
  static fetchAvailableSlots(String? doctorId,String? appointmentDate) async {
    String link = AppUrl.getAvailableSlotsEndPoint;
    final token = getToken();
    try {
      Response response = await Dio().post(link,
         data: {
              "doctor_id": doctorId,
              "appointment_date": appointmentDate
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var item = response.data;
      print("All AvailableSlots Data======$item");
      return List.from(item).map((e) => AvailableSlotsModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  
}
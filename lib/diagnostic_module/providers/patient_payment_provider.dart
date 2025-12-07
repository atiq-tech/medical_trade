import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/patient_payment_model.dart';

class PatientPaymentProvider extends ChangeNotifier{
  List<PatientPaymentModel> patientPaymentList = [];
  static bool isPatientPaymentLoading = false;
  getPatientPayment(String? dateFrom,String? dateTo) async {
    patientPaymentList = await DiagnosticeApiservice.fetchPatientPayment(dateFrom,dateTo);
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isPatientPaymentLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isPatientPaymentLoading = true;
    notifyListeners();
  }
}
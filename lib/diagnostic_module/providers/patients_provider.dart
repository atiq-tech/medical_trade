import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/patients_model.dart';

class PatientsProvider extends ChangeNotifier{
  List<PatientsModel> allPatientList = [];
  static bool isAllPatientsLoading = false;
  getlPatients() async {
    allPatientList = await DiagnosticeApiservice.fetchAllPatients();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isAllPatientsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isAllPatientsLoading = true;
    notifyListeners();
  }
}
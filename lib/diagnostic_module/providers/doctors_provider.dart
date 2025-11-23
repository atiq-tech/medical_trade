import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/doctors_model.dart';

class DoctorsProvider extends ChangeNotifier{
  List<DoctorsModel> allDoctorsList = [];
  static bool isDoctorsLoading = false;
  getDoctors() async {
    allDoctorsList = await DiagnosticeApiservice.fetchAllDoctors();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isDoctorsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isDoctorsLoading = true;
    notifyListeners();
  }
}
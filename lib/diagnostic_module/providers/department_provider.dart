import 'package:flutter/material.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/department_module.dart';

class DepartmentProvider extends ChangeNotifier{
  List<DepartmentModel> allDepartmentList = [];
  static bool isDepartmentLoading = false;
  getDepartment(String? useFor) async {
    allDepartmentList = await DiagnosticeApiservice.fetchDepartment(useFor);
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isDepartmentLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isDepartmentLoading = true;
    notifyListeners();
  }
}
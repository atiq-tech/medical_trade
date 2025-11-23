import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/specimens_model.dart';

class SpecimensProvider extends ChangeNotifier{
  List<SpecimensModel> allSpecimensList = [];
  static bool isSpecimensLoading = false;
  getSpecimens() async {
    allSpecimensList = await DiagnosticeApiservice.fetchSpecimens();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isSpecimensLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isSpecimensLoading = true;
    notifyListeners();
  }
}
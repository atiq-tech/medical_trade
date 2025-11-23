import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/test_entry_model.dart';

class TestEntryProvider extends ChangeNotifier{
  List<TestEntryModel> allTestEntryList = [];
  static bool isTestEntryLoading = false;
  getTestEntry() async {
    allTestEntryList = await DiagnosticeApiservice.fetchTestEntry();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isTestEntryLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isTestEntryLoading = true;
    notifyListeners();
  }
}
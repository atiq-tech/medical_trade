import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/bank_account_model.dart';

class BankAccountProvider extends ChangeNotifier{
  List<BankAccountModel> allBankAccountList = [];
  static bool isBankAccountLoading = false;
  getBankAccount() async {
    allBankAccountList = await DiagnosticeApiservice.fetchBankAccount();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isBankAccountLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isBankAccountLoading = true;
    notifyListeners();
  }
}
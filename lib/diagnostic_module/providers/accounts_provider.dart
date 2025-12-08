import 'package:flutter/material.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/accounts_model.dart';

class AccountsProvider extends ChangeNotifier{
  List<AccountsModel> accountsList = [];
  static bool isAccountsLoading = false;
  getAccounts() async {
    accountsList = await DiagnosticeApiservice.fetchAllAccounts();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isAccountsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isAccountsLoading = true;
    notifyListeners();
  }
}
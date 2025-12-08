import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/cash_transaction_model.dart';

class CashTransactionProvider extends ChangeNotifier{
  List<CashTransactionModel> cashTransactionList = [];
  static bool isCashTransactionLoading = false;
  getCashTransaction(String? dateFrom,String? dateTo) async {
    cashTransactionList = await DiagnosticeApiservice.fetchCashTransaction(dateFrom,dateTo);
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isCashTransactionLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isCashTransactionLoading = true;
    notifyListeners();
  }
}
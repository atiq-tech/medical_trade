import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/cash_transaction_model.dart';

class CashTransactionProvider extends ChangeNotifier{
  List<CashTransactionModel> cashTransactionList = [];
  static bool isCashTransactionLoading = false;
  getCashTransaction(String? accountId,String? dateFrom,String? dateTo,String? transactionType,String? paymentType,String? bankAccountId) async {
    cashTransactionList = await DiagnosticeApiservice.fetchCashTransaction(accountId,dateFrom,dateTo,transactionType,paymentType,bankAccountId);
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
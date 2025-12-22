import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/bank_transaction_model.dart';

class BankTransactionProvider extends ChangeNotifier{
  List<BankTransactionModel> bankTransactionList = [];
  static bool isBankTransactionLoading = false;
  getBankTransaction(String? dateFrom,String? dateTo,String? transactionType,String? bankAccountId) async {
    bankTransactionList = await DiagnosticeApiservice.fetchBankTransaction(dateFrom,dateTo,transactionType,bankAccountId);
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isBankTransactionLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isBankTransactionLoading = true;
    notifyListeners();
  }
}
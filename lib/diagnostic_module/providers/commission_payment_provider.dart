import 'package:flutter/cupertino.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/commission_payment_model.dart';

class CommissionPaymentProvider extends ChangeNotifier{
  List<CommissionPaymentModel> commissionPaymentList = [];
  static bool isCommissionPaymentLoading = false;
  getCommissionPayment(String? dateFrom,String? dateTo) async {
    commissionPaymentList = await DiagnosticeApiservice.fetchCommissionPayment(dateFrom,dateTo);
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isCommissionPaymentLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isCommissionPaymentLoading = true;
    notifyListeners();
  }
}
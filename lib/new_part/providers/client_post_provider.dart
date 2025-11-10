import 'package:flutter/cupertino.dart';
import 'package:medical_trade/new_part/api_service.dart';
import 'package:medical_trade/new_part/model/client_post_model.dart';

class NewClientPostProvider extends ChangeNotifier {
  List<ClientPostModel> allClientPostList = [];
  static bool isAllClientPostLoading = false;

  Future<void> getClientPost() async {
    on(); // ✅ loading ON

    final data = await ApiServiceNew.fetchClientPostApi();

    if (data != null) {
      allClientPostList = data;
    }

    off();
    notifyListeners();
  }

  on() {
    print("Loading ON");
    isAllClientPostLoading = true;
    notifyListeners();
  }

  off() {
    print("Loading OFF");
    isAllClientPostLoading = false;
    notifyListeners();
  }
}


// class NewClientPostProvider extends ChangeNotifier{
//   List<ClientPostModel> allClientPostList = [];
//   static bool isAllClientPostLoading = false;
//   getClientPost() async {
//     allClientPostList = await ApiServiceNew.fetchClientPostApi();
//   off();
//   notifyListeners();
//   }
//   off(){
//     Future.delayed(const Duration(seconds: 1),() {
//       print('offff');
//       isAllClientPostLoading = false;
//       notifyListeners();
//     },);
//   }
//   on(){
//     print('onnn');
//     isAllClientPostLoading = true;
//     notifyListeners();
//   }
// }
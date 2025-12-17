import 'package:flutter/material.dart';
import 'package:medical_trade/model/get_category_product_model.dart';
import 'package:medical_trade/new_part/api_service.dart';

class AllProductsProvider extends ChangeNotifier{
  List<GetCategoryProductModel> allProductslist = [];
  static bool isAllProductLoading = false;
  getProducts(String? productCategoryId) async {
    allProductslist = (await ApiServiceNew.fetchGetProductsApi(productCategoryId))!;
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isAllProductLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isAllProductLoading = true;
    notifyListeners();
  }
}
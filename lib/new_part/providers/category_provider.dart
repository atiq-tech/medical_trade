import 'package:flutter/cupertino.dart';
import 'package:medical_trade/new_part/api_service.dart';
import 'package:medical_trade/new_part/model/new_category_model.dart';

class CategoryProvider extends ChangeNotifier{
  List<NewCategoryModel> allCategoriesList = [];
  static bool isAllCategoriesLoading = false;
  getCategories() async {
    allCategoriesList = await ApiServiceNew.fetchCategoryApi();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isAllCategoriesLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isAllCategoriesLoading = true;
    notifyListeners();
  }
}
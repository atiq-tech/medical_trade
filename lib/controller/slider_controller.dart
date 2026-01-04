import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  int _carouselIndex = 0;
  int get carouselIndex => _carouselIndex;
  void setCarouselIndex(int index) {
    _carouselIndex = index;
    notifyListeners();
  }
}

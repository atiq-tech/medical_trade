import 'package:flutter/material.dart';
import 'package:medical_trade/new_part/api_service.dart';
import 'package:medical_trade/new_part/model/wall_post_new_model.dart';

class WallPostNewProvider extends ChangeNotifier {
  List<WallPostNewModel> allWallPostNewList = [];
  static bool isWallPostNewLoading = false;

  Future<void> getWallPostNew() async {
    on(); // ✅ loading ON

    final data = await ApiServiceNew.fetchWallPostNewApi();

    if (data != null) {
      allWallPostNewList = data;
    }

    off();
    notifyListeners();
  }

  on() {
    print("Loading ON");
    isWallPostNewLoading = true;
    notifyListeners();
  }

  off() {
    print("Loading OFF");
    isWallPostNewLoading = false;
    notifyListeners();
  }
}
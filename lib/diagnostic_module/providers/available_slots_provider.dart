import 'package:flutter/material.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/available_slots_model.dart';

class AvailableSlotsProvider extends ChangeNotifier{
  List<AvailableSlotsModel> availableSlotsList = [];
  static bool isAvailableSlotsLoading = false;
  getAvailableSlots(String? doctorId,String? appointmentDate) async {
    availableSlotsList = await DiagnosticeApiservice.fetchAvailableSlots(doctorId,appointmentDate);
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isAvailableSlotsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isAvailableSlotsLoading = true;
    notifyListeners();
  }
}
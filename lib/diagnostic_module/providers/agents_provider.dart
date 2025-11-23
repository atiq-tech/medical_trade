import 'package:flutter/material.dart';
import 'package:medical_trade/diagnostic_module/diagnostice_apiservice.dart';
import 'package:medical_trade/diagnostic_module/models/agents_model.dart';

class AgentsProvider extends ChangeNotifier{
  List<AgentsModel> allAgentsList = [];
  static bool isAgentsLoading = false;
  getAgents() async {
    allAgentsList = await DiagnosticeApiservice.fetchAllAgents();
  off();
  notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isAgentsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isAgentsLoading = true;
    notifyListeners();
  }
}
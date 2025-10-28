import 'package:flutter/material.dart';
class AppColors {
  //static const Color cardColor = Color(0xff74D4D3);
  static const Color cardColor = Color.fromARGB(255, 150, 214, 223);
  static const Color appColor = Color.fromARGB(255, 1, 119, 134);
  static const Color buttonColor = Color.fromARGB(255, 4, 165, 71);
  static const Color cardColor1 = Color.fromARGB(255, 106, 208, 255);
  static const Color primaryColor = Color(0xff01509F);
  static const Color orderCardColor = Color.fromARGB(255, 120, 205, 255);
  static const Color orderCardTitle = Color.fromARGB(255, 35, 87, 184);

  static const Color isEmployees = Color(0xff01509F);
  static const Color isAreas = Color.fromARGB(255, 77, 76, 76);
  static const Color isOrderCard = Color.fromARGB(255, 158, 201, 218);
  static const Color isOrder = Color.fromARGB(255, 63, 106, 122);
  static const Color isCustomers = Color.fromARGB(255, 44, 17, 95);
  static const Color isMechanics = Color.fromARGB(255, 0, 104, 52);
  
  static Color getEmployee(Set<MaterialState> states) {
    return Color.fromARGB(255, 182, 218, 255);
  }
  static Color getColors(Set<MaterialState> states) {
    return Colors.white;
  }
  static Color getArea(Set<MaterialState> states) {
    return Color.fromARGB(255, 207, 207, 207);
  }
  static Color getCustomer(Set<MaterialState> states) {
    return Color.fromARGB(255, 213, 191, 253);
  }
  static Color getMechanic(Set<MaterialState> states) {
    return Color.fromARGB(255, 198, 255, 227);
  }
  static Color getAll(Set<MaterialState> states) {
    return Color.fromARGB(255, 197, 252, 252);
  }
}

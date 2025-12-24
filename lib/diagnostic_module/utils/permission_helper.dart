import 'package:shared_preferences/shared_preferences.dart';

class PermissionHelper {
  static Future<String> _get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "false";
  }
  static Future<String> saleYourOldMachine() => _get("saleYourOldMachine");
  static Future<String> wallPost() => _get("wallPost");
  static Future<String> engineerSupport() => _get("engineerSupport");
  static Future<String> patientEntry() => _get("patientEntry");
  static Future<String> doctorEntry() => _get("doctorEntry");
  static Future<String> testEntry() => _get("testEntry");
  static Future<String> appointmentEntry() => _get("appointmentEntry");
  static Future<String> cashTrEntry() => _get("cashTrEntry");
  static Future<String> bankTrEntry() => _get("bankTrEntry");
  static Future<String> commissionPayment() => _get("commissionPayment");
  static Future<String> patientList() => _get("patientList");
  static Future<String> patientPayment() => _get("patientPayment");
  static Future<String> cashTrReport() => _get("cashTrReport");
  static Future<String> bankTrReport() => _get("bankTrReport");
   
}

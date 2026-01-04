import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/diagnostic_module/screens/appointment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/bank_transaction_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/bank_transaction_report_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/cash_transaction_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/cash_transaction_report_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/commission_payment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/doctor_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/doctor_list_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_list_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_payment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/test_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/utils/permission_helper.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/color_manager.dart';

class DiagnosticModuleScreen extends StatefulWidget {
  const DiagnosticModuleScreen({super.key});

  @override
  State<DiagnosticModuleScreen> createState() => _DiagnosticModuleScreenState();
}

class _DiagnosticModuleScreenState extends State<DiagnosticModuleScreen> {
  String? role;
  @override
  void initState() {
    final box = GetStorage();
    role = box.read('role');
    super.initState();
    print("Role================$role");
  }
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Patient Entry',
        'icon': DiagnosticModule.patient,
        'color': Colors.teal,
      },
      {
        'title': 'Doctor Entry',
        'icon': DiagnosticModule.doctor,
        'color': Colors.blue,
      },
      {
        'title': 'Test Entry',
        'icon': DiagnosticModule.testEntry,
        'color': Colors.orange,
      },
      {
        'title': 'Doctor List',
        'icon': DiagnosticModule.doctorList,
        'color': Colors.blue,
      },
      {
        'title': 'Patient List',
        'icon': DiagnosticModule.patientList,
        'color': Colors.teal,
      },
      {
        'title': 'Appointment Entry',
        'icon': DiagnosticModule.appointment,
        'color': Colors.blue,
      },
      {
        'title': 'Cash Transaction',
        'icon': DiagnosticModule.cashTransaction,
        'color': Color.fromARGB(255, 98, 44, 148),
      },
      {
        'title': 'Bank Transaction',
        'icon': DiagnosticModule.bankTransaction,
        'color': Colors.green,
      },
      {
        'title': 'Commission Payment',
        'icon': DiagnosticModule.supplierPay,
        'color': Colors.brown
      },
       {
        'title': 'Patient Payment',
        'icon': DiagnosticModule.patientPay,
        'color': const Color.fromARGB(255, 1, 160, 192),
      },
       {
        'title': 'Cash Transaction Report',
        'icon': DiagnosticModule.cashTrReport,
        'color': Color.fromARGB(255, 98, 44, 148),
      },
       {
        'title': 'Bank Transaction Report',
        'icon': DiagnosticModule.bankTrReport,
        'color': const Color.fromARGB(255, 1, 160, 192),
      },
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: ColorManager.appbarColor,
        title: Text(
          'Diagnostic Module',
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(6.r),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 6,
            childAspectRatio: 1.01,
          ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              if (index == 0) {
                final access = await PermissionHelper.patientEntry();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PatientEntryScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 1) {
                final access = await PermissionHelper.doctorEntry();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => DoctorEntryScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 2) {
                final access = await PermissionHelper.testEntry();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => TestEntryScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 3) {
                final access = await PermissionHelper.doctorEntry();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => DoctorListScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 4) {
                final access = await PermissionHelper.patientList();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PatientListScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 5) {
                final access = await PermissionHelper.appointmentEntry();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => AppointmentEntryScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 6) {
                final access = await PermissionHelper.cashTrEntry();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => CashTransactionEntryScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 7) {
                final access = await PermissionHelper.bankTrEntry();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => BankTransactionEntryScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 8) {
                final access = await PermissionHelper.commissionPayment();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => CommissionPaymentEntryScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else if (index == 9) {
                final access = await PermissionHelper.patientPayment();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => PatientPaymentEntryScreen()));
                } else {
                  showWarningDialog(context);
                }
              }
              else if (index == 10) {
                final access = await PermissionHelper.cashTrReport();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => CashTransactionReportScreen()));
                } else {
                  showWarningDialog(context);
                }

              } else {
                final access = await PermissionHelper.bankTrReport();
                if (access == "true" || role == "Admin" || role == "Super Admin") {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => BankTransactionReportScreen()));
                } else {
                  showWarningDialog(context);
                }
              }
            },
            child: Card(
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: (items[index]['color'] as Color).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.white,width: 4.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 4.r,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(4.r),
                        child: Image.asset(
                          items[index]['icon'] as String, 
                          width: 18.w,
                          height: 18.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          items[index]['title'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          );
        },
      ),
      ),
    );
  }
}
showWarningDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('⚠️ Warning'),
        content: Text(
          "It is not authorized for you to access this page!",
          style: TextStyle(fontSize: 13.5.sp),
        ),
        actions: <Widget>[
          Container(
            height: 30.h,
            width: 60.w,
            decoration:BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0.w),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(child: Text('OK', style: TextStyle(color: Colors.black,fontSize: 10.sp))),
            ),
          ),
        ],
      );
    },
  );
}

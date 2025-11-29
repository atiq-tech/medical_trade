import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/screens/appointment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/bank_transaction_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/cash_transaction_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/commission_payment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/doctor_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/doctor_list_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_list_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_payment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/test_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/test_receipt_screen.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/color_manager.dart';

class DiagnosticModuleScreen extends StatelessWidget {
  const DiagnosticModuleScreen({super.key});

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
        'title': 'Test Receipt',
        'icon': DiagnosticModule.testReceipt,
        'color': Colors.indigo,
      },
      // {
      //   'title': 'Test Receipt List',
      //   'icon': DiagnosticModule.testReceiptList,
      //   'color': Colors.green
      // },
      {
        'title': 'Appointment Entry',
        'icon': DiagnosticModule.appointment,
        'color': const Color.fromARGB(255, 162, 173, 2),
      },
      // {
      //   'title': 'Appointment List',
      //   'icon': DiagnosticModule.appointmentList,
      //   'color': const Color.fromARGB(255, 46, 118, 133),
      // },
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
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Navigating to')),);
               item['title']=="Patient Entry" ? Navigator.push(context,MaterialPageRoute(builder: (_) => PatientEntryScreen()))
               :item['title']=="Patient List" ? Navigator.push(context,MaterialPageRoute(builder: (_) => PatientListScreen()))
               :item['title']=="Test Entry" ? Navigator.push(context,MaterialPageRoute(builder: (_) => TestEntryScreen()))
               :item['title']=="Appointment Entry" ?Navigator.push(context,MaterialPageRoute(builder: (_) => AppointmentEntryScreen())) 
              // :item['title']=="Appointment List" ?Navigator.push(context,MaterialPageRoute(builder: (_) => AppointmentListScreen()))
               :item['title']=="Test Receipt" ?Navigator.push(context,MaterialPageRoute(builder: (_) => TestReceiptScreen()))
               //:item['title']=="Test Receipt List" ?Navigator.push(context,MaterialPageRoute(builder: (_) => TestReceiptListScreen()))
               :item['title']=="Cash Transaction" ?Navigator.push(context,MaterialPageRoute(builder: (_) => CashTransactionEntryScreen()))
               :item['title']=="Bank Transaction" ?Navigator.push(context,MaterialPageRoute(builder: (_) => BankTransactionEntryScreen()))
               :item['title']=="Commission Payment" ?Navigator.push(context,MaterialPageRoute(builder: (_) => CommissionPaymentEntryScreen()))
               :item['title']=="Doctor Entry" ?Navigator.push(context,MaterialPageRoute(builder: (_) => DoctorEntryScreen()))
               :item['title']=="Doctor List" ?Navigator.push(context,MaterialPageRoute(builder: (_) => DoctorListScreen()))
               : Navigator.push(context,MaterialPageRoute(builder: (_) => PatientPaymentEntryScreen()));
              },
              child: Card(
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withOpacity(0.3),
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
                          item['icon'] as String, 
                          width: 18.w,
                          height: 18.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          item['title'] as String,
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

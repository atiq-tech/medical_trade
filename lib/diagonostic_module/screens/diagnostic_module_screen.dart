import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagonostic_module/screens/appointment_entry_screen.dart';
import 'package:medical_trade/diagonostic_module/screens/doctor_entry_screen.dart';
import 'package:medical_trade/diagonostic_module/screens/patient_entry_screen.dart';
import 'package:medical_trade/diagonostic_module/screens/test_entry_screen.dart';
import 'package:medical_trade/diagonostic_module/screens/test_receipt_screen.dart';
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
        'color': Colors.indigo,
      },
      {
        'title': 'Test Receipt',
        'icon': DiagnosticModule.testReceipt,
        'color': Color.fromARGB(255, 144, 182, 144),
      },
      {
        'title': 'Patient List',
        'icon': DiagnosticModule.patientList,
        'color': Colors.green,
      },
      {
        'title': 'Appointment Entry',
        'icon': DiagnosticModule.appointment,
        'color': const Color.fromARGB(255, 1, 160, 192),
      },
      {
        'title': 'Appointment List',
        'icon': DiagnosticModule.appointmentList,
        'color': const Color.fromARGB(255, 46, 118, 133),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: ColorManager.appbarColor,
        title: const Text(
          'Diagnostic Module',
          style: TextStyle(fontWeight: FontWeight.w500),
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
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigating to')),
                );
                // Navigator.pushNamed(context, '/yourRoute');
               item['title']=="Patient Entry" ? Navigator.push(context,MaterialPageRoute(builder: (_) => PatientEntryScreen()))
               :item['title']=="Test Entry" ? Navigator.push(context,MaterialPageRoute(builder: (_) => TestEntryScreen()))
               :item['title']=="Appointment Entry" ?Navigator.push(context,MaterialPageRoute(builder: (_) => AppointmentEntryScreen())) 
               :item['title']=="Test Receipt" ?Navigator.push(context,MaterialPageRoute(builder: (_) => TestReceiptScreen()))
               : Navigator.push(context,MaterialPageRoute(builder: (_) => DoctorEntryScreen()));
              },
              child: Card(
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.white,
                      width: 4.5.w,
                    ),
                    
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
                        padding: EdgeInsets.all(5.r),
                        child: Image.asset(
                          item['icon'] as String, 
                          width: 25.w,
                          height: 25.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                
                      SizedBox(height: 2.h),
                      Text(
                        item['title'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
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

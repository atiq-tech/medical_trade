import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/utilities/color_manager.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  List<Map<String, String>> doctorList = [
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
    {
      'id': '1',
      'name': 'Dr. Mahmud Hasan',
      'email': 'mahmud@hospital.com',
      'specialist': 'Cardiologist',
      'phone': '01711-123456',
      'address': 'Dhaka',
    },
    {
      'id': '2',
      'name': 'Dr. Rima Akter',
      'email': 'rima@hospital.com',
      'specialist': 'Dermatologist',
      'phone': '01822-654321',
      'address': 'Khulna',
    },
    {
      'id': '3',
      'name': 'Dr. Tuhin Rahman',
      'email': 'tuhin@hospital.com',
      'specialist': 'Neurologist',
      'phone': '01933-999888',
      'address': 'Barishal',
    },
  ];

  Color getColor(Set<MaterialState> states) => const Color.fromARGB(255, 240, 240, 240);
  Color getColors(Set<MaterialState> states) => Colors.white;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar:AppBar(
      backgroundColor: ColorManager.appbarColor,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Doctor List",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
      centerTitle: true,
    ),
      body: Container(
        height: doctorList.isEmpty ? 40.h : 40.h + (doctorList.length * 25.0.h),
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 22.h,
              dataRowHeight: 22.h,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 70, 54, 141)),
              border: TableBorder.all(
                  color: const Color.fromARGB(255, 110, 143, 145), width: 1),
              columns: const [
                DataColumn(label: Center(child: Text('ID', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Name', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Email', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Specialist', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Phone', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Address', style: TextStyle(color: Colors.white)))),
              ],
              rows: List.generate(
                doctorList.length,
                (index) => DataRow(
                  color: index % 2 == 0
                      ? MaterialStateProperty.resolveWith(getColor)
                      : MaterialStateProperty.resolveWith(getColors),
                  cells: [
                    DataCell(Center(child: Text(doctorList[index]['id']!))),
                    DataCell(Center(child: Text(doctorList[index]['name']!, style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(doctorList[index]['email']!, style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(doctorList[index]['specialist']!, style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(doctorList[index]['phone']!, style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(doctorList[index]['address']!, style: TextStyle(fontSize: 11.sp)))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

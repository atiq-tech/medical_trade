import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Map<String, String>> patientList = [
    {
      'id': '101',
      'name': 'Abdul Karim',
      'email': 'karim@gmail.com',
      'address': 'Dhaka, Bangladesh',
      'phone': '01722-111222',
    },
    {
      'id': '102',
      'name': 'Nusrat Jahan',
      'email': 'nusrat@gmail.com',
      'address': 'Chittagong, Bangladesh',
      'phone': '01833-222333',
    },
    {
      'id': '103',
      'name': 'Sabbir Hossain',
      'email': 'sabbir@gmail.com',
      'address': 'Sylhet, Bangladesh',
      'phone': '01944-333444',
    },
  ];

  Color getColor(Set<MaterialState> states) => const Color.fromARGB(255, 240, 240, 240);
  Color getColors(Set<MaterialState> states) => Colors.white;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Container(
          height: patientList.isEmpty ? 40.h : 40.h + (patientList.length * 25.0.h),
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
                  DataColumn(label: Center(child: Text('Address', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Phone', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Action', style: TextStyle(color: Colors.white)))),
                ],
                rows: List.generate(
                  patientList.length,
                  (index) => DataRow(
                    color: index % 2 == 0
                        ? MaterialStateProperty.resolveWith(getColor)
                        : MaterialStateProperty.resolveWith(getColors),
                    cells: [
                      DataCell(Center(child: Text(patientList[index]['id']!))),
                      DataCell(Center(child: Text(patientList[index]['name']!, style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(patientList[index]['email']!, style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(patientList[index]['address']!, style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(patientList[index]['phone']!, style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              patientList.removeAt(index);
                            });
                          },
                          child: Icon(Icons.delete, size: 16.r, color: Colors.deepPurple),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

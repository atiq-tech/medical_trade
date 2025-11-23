import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/providers/doctors_provider.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:provider/provider.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  Color getColor(Set<MaterialState> states) => const Color.fromARGB(255, 240, 240, 240);
  Color getColors(Set<MaterialState> states) => Colors.white;

  @override
  void initState() {
    super.initState();
      Provider.of<DoctorsProvider>(context, listen: false).getDoctors();
  }


  @override
  Widget build(BuildContext context) {
    final allDoctorsData = Provider.of<DoctorsProvider>(context).allDoctorsList;
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
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 22.h,
              dataRowMaxHeight:double.infinity,
              //dataRowHeight: 22.h,
              headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 2, 145, 9)),
              border: TableBorder.all(color: const Color.fromARGB(255, 110, 143, 145), width: 1),
              columns: const [
                DataColumn(label: Center(child: Text('ID ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Name ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Name Bangla ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Department ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Mobile ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Address ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Fees ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Education Level ↕', style: TextStyle(color: Colors.white)))),
                DataColumn(label: Center(child: Text('Remark ↕', style: TextStyle(color: Colors.white)))),
              ],
              rows: List.generate(
                allDoctorsData.length,
                (index) => DataRow(
                  color: index % 2 == 0? MaterialStateProperty.resolveWith(getColor): MaterialStateProperty.resolveWith(getColors),
                  cells: [
                    DataCell(Center(child: Text(allDoctorsData[index].doctorCode.toString()))),
                    DataCell(Center(child: Text(allDoctorsData[index].name.toString(), style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(allDoctorsData[index].nameBangla.toString(), style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(allDoctorsData[index].departmentId.toString(), style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(allDoctorsData[index].mobile.toString(), style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(allDoctorsData[index].address.toString(), style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(allDoctorsData[index].fees.toString(), style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(allDoctorsData[index].educationLevel.toString(), style: TextStyle(fontSize: 11.sp)))),
                    DataCell(Center(child: Text(allDoctorsData[index].remark??"", style: TextStyle(fontSize: 11.sp)))),
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

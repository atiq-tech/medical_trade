import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/providers/patients_provider.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:provider/provider.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  Color getColor(Set<MaterialState> states) => const Color.fromARGB(255, 240, 240, 240);
  Color getColors(Set<MaterialState> states) => Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PatientsProvider>(context, listen: false).getPatients();
  }

  @override
  Widget build(BuildContext context) {
    final allPatientsData = Provider.of<PatientsProvider>(context).allPatientList;
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.appbarColor,
        title: Text(
          'Patient List',
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.w),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 22.h,
                //dataRowMaxHeight:double.infinity,
                dataRowHeight: 22.h,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 70, 54, 141)),
                border: TableBorder.all(
                    color: const Color.fromARGB(255, 110, 143, 145), width: 1),
                columns: const [
                  DataColumn(label: Center(child: Text('ID ↕', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Name ↕', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Mobile ↕', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Gender ↕', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Date of Birth ↕', style: TextStyle(color: Colors.white)))),
                  //DataColumn(label: Center(child: Text('Age ↕', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Address ↕', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('NID ↕', style: TextStyle(color: Colors.white)))),
                  DataColumn(label: Center(child: Text('Remark ↕', style: TextStyle(color: Colors.white)))),
                  				
                ],
                rows: List.generate(
                  allPatientsData.length,
                  (index) => DataRow(
                    color: index % 2 == 0
                        ? MaterialStateProperty.resolveWith(getColor)
                        : MaterialStateProperty.resolveWith(getColors),
                    cells: [
                      DataCell(Center(child: Text(allPatientsData[index].id.toString()))),
                      DataCell(Center(child: Text(allPatientsData[index].name??"", style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].mobile??"", style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].gender??"", style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].dateOfBirth??"", style: TextStyle(fontSize: 11.sp)))),
                      // DataCell(Center(child: Text(allPatientsData[index].))),
                      DataCell(Center(child: Text(allPatientsData[index].address??"", style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].nid??"", style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].remark??"", style: TextStyle(fontSize: 11.sp)))),
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

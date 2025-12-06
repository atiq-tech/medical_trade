import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/providers/patients_provider.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  Color getColor(Set<MaterialState> states) =>
      const Color.fromARGB(255, 240, 240, 240);
  Color getColors(Set<MaterialState> states) => Colors.white;

  @override
  void initState() {
    super.initState();
    Provider.of<PatientsProvider>(context, listen: false).getPatients();
  }

  /// ------------------------------
  /// AGE CALCULATION FUNCTION
  /// ------------------------------
  String calculateAge(String dobString) {
    try {
      DateTime dob = DateFormat("yyyy-MM-dd").parse(dobString);
      DateTime now = DateTime.now();

      int years = now.year - dob.year;
      int months = now.month - dob.month;
      int days = now.day - dob.day;

      if (days < 0) {
        months -= 1;
        final lastMonth = DateTime(now.year, now.month, 0);
        days += lastMonth.day;
      }

      if (months < 0) {
        years -= 1;
        months += 12;
      }

      return "$years years $months months $days days";
    } catch (e) {
      return "";
    }
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
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
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
                dataRowHeight: 22.h,
                headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 70, 54, 141)),
                border: TableBorder.all(color: const Color.fromARGB(255, 110, 143, 145), width: 1),
                columns: const [
                  DataColumn(label: Expanded(child: Center(child: Text('ID', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child: Text('Name', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child: Text('Mobile', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child: Text('Gender', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child:Text('Date of Birth', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child: Text('Age', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child: Text('Address', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child: Text('NID', style: TextStyle(color: Colors.white))))),
                  DataColumn(label: Expanded(child: Center(child: Text('Remark', style: TextStyle(color: Colors.white))))),
                ],
                rows: List.generate(
                  allPatientsData.length,
                  (index) => DataRow(
                    color: index % 2 == 0
                        ? MaterialStateProperty.resolveWith(getColor)
                        : MaterialStateProperty.resolveWith(getColors),
                    cells: [
                      DataCell(Center(child: Text(allPatientsData[index].patientCode.toString(),style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].name ?? "",style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].mobile ?? "",style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].gender ?? "",style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].dateOfBirth ?? "",style: TextStyle(fontSize: 11.sp)))),
                      DataCell(
                        Center(
                          child: Text(
                            calculateAge(allPatientsData[index].dateOfBirth ?? ""),
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ),
                      ),
                      DataCell(Center(child: Text(allPatientsData[index].address ?? "",style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].nid ?? "",style: TextStyle(fontSize: 11.sp)))),
                      DataCell(Center(child: Text(allPatientsData[index].remark ?? "",style: TextStyle(fontSize: 11.sp)))),
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


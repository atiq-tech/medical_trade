library;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/providers/patients_provider.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/animation_snackbar.dart';
import 'package:medical_trade/diagnostic_module/utils/common_textfield.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:provider/provider.dart';
class PatientEntryScreen extends StatefulWidget {
  const PatientEntryScreen({super.key,});
  @override
  State<PatientEntryScreen> createState() => _PatientEntryScreenState();
}

class _PatientEntryScreenState extends State<PatientEntryScreen> {
  Color getColor(Set<WidgetState> states) {
    return Colors.blue.shade200;
  }

  Color getColors(Set<WidgetState> states) {
    return Colors.white;
  }
  final _patientIDController = TextEditingController();
  final _patientNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _nidNoController = TextEditingController();
  final _remarkController = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();

  final birthdayController = TextEditingController();
  String? dob = "";
  void calculateAgeFromBirthday(DateTime birthday) {
    DateTime now = DateTime.now();

    int years = now.year - birthday.year;
    int months = now.month - birthday.month;
    int days = now.day - birthday.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    yearController.text = years.toString();
    monthController.text = months.toString();
    dayController.text = days.toString();
  }

  void calculateBirthdayFromAge() {
    if (yearController.text.isEmpty ||monthController.text.isEmpty || dayController.text.isEmpty) return;
    int y = int.tryParse(yearController.text) ?? 0;
    int m = int.tryParse(monthController.text) ?? 0;
    int d = int.tryParse(dayController.text) ?? 0;
    DateTime now = DateTime.now();
    DateTime birthday = DateTime(now.year - y, now.month - m, now.day - d);
    String mm = birthday.month.toString().padLeft(2, '0');
    String dd = birthday.day.toString().padLeft(2, '0');
    String yyyy = birthday.year.toString();
    birthdayController.text = "$mm-$dd-$yyyy";
    dob= "$yyyy-$mm-$dd";
  }

  Future<void> pickBirthday() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      String mm = picked.month.toString().padLeft(2, '0');
      String dd = picked.day.toString().padLeft(2, '0');
      String yyyy = picked.year.toString();
      birthdayController.text = "$mm-$dd-$yyyy";
      dob = "$yyyy-$mm-$dd";
      calculateAgeFromBirthday(picked);
    }
  }

  String? gender = "";
  String? employeeSlNo;
  String? employeeId = "";
  String? userEmployeeId = "";
  String userName = "";
  String userType = "";

  static String getToken() {
    final box = GetStorage();
    return box.read('loginToken') ?? "";
  }

String? patientId = "";
getPatientCode() async {
  try {
    String link = AppUrl.getPatientCodeEndPoint;
    final token = getToken();

    var response = await Dio().get(
      link,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    print("Response =====> ${response.data}");
    if (response.statusCode == 401) {
      Utils.showTopSnackBar(context, "Session expired. Please log in again.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(
            isLogin: true,
          ),
        ),
      );
      return;
    }
    setState(() {
      patientId = response.data["data"].toString();
    });
    print("Patient ID =========> $patientId");

  } catch (e) {
    print("getPatientCode ERROR =======> $e");
  }
}

  @override
  void initState() {
    DateTime now = DateTime.now();
    String mm = now.month.toString().padLeft(2, '0');
    String dd = now.day.toString().padLeft(2, '0');
    String yyyy = now.year.toString();
    birthdayController.text = "$mm-$dd-$yyyy";
    calculateAgeFromBirthday(now);
    getPatientCode();
    super.initState();
    yearController.text = "";
    monthController.text = "";
    dayController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      backgroundColor: ColorManager.appbarColor,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Patient Entry",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(10.0.r),
                  border: Border.all(color: const Color.fromARGB(255, 2, 196, 163), width: 1.0.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2, blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 6,child: Text("Patient ID",style: AllTextStyle.textFieldHeadStyle)),
                        const Expanded(flex: 1,child: Text(":")),
                        Expanded(
                          flex: 16,
                          child: Container(
                            height: 25.h,
                            decoration: ContDecoration.contDecoration,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w,top: 3.h),
                              child: Text(patientId.toString(),
                                style: AllTextStyle.dropDownlistStyle
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Name",
                      controller: _patientNameController,
                      hintText: "Enter Patient Name",
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Mobile",
                      controller: _mobileController,
                      hintText: "Enter Mobile Number",
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 4.0.h),
                     Row(
                        children: [
                          Expanded(flex:6, child: Text("Age", style:AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex:5,
                            child: Container(
                            height: 25.h,
                            decoration: ContDecoration.contDecoration,
                              child: TextField(
                                controller: yearController,
                                keyboardType: TextInputType.number,
                                style: AllTextStyle.dropDownlistStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                  hintStyle: AllTextStyle.dropDownlistStyle,
                                  hintText: "Year"),
                                onChanged: (v) => calculateBirthdayFromAge(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex:5,
                            child: Container(
                            height: 25.h,
                            decoration: ContDecoration.contDecoration,
                              child: TextField(
                                controller: monthController,
                                keyboardType: TextInputType.number,
                                style: AllTextStyle.dropDownlistStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                  hintStyle: AllTextStyle.dropDownlistStyle,
                                  hintText: "Month"),
                                onChanged: (v) => calculateBirthdayFromAge(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex:5,
                            child: Container(
                            height: 25.h,
                            decoration: ContDecoration.contDecoration,
                              child: TextField(
                                controller: dayController,
                                keyboardType: TextInputType.number,
                                style: AllTextStyle.dropDownlistStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                  hintStyle: AllTextStyle.dropDownlistStyle,
                                  hintText: "Day"
                                  ),
                                onChanged: (v) => calculateBirthdayFromAge(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Expanded(flex:6, child: Text("Date of Birth", style:AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                            height: 25.h,
                            decoration: ContDecoration.contDecoration,
                              child: TextField(
                                controller: birthdayController,
                                readOnly: true,
                                style: AllTextStyle.dropDownlistStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5.w, bottom: 14.h),
                                  suffixIcon: Icon(Icons.calendar_month, color: Colors.black87,size: 16.r),
                                ),
                                onTap: pickBirthday,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "NID No",
                      controller: _nidNoController,
                      hintText: "Enter NID Number",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Remark",
                      controller: _remarkController,
                      hintText: "Enter Remark",
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Address",
                      controller: _addressController,
                      hintText: "Enter Address",
                      maxLines: 2,
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Gender             :  ", style: AllTextStyle.textFieldHeadStyle),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            gender="Male";
                          });
                        },
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  fillColor:MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 5, 114, 165)),
                                  value: "Male",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                 });
                                  }),
                            ),
                            const Text("Male"),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                        GestureDetector(
                        onTap: () {
                          setState(() {
                            gender="Female";
                            });
                        },
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  fillColor:MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 5, 114, 165)),
                                  value: "Female",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                   });
                                  }),
                            ),
                            const Text("Female"),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                        GestureDetector(
                        onTap: () {
                          setState(() {
                            gender="Other";
                            });
                        },
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  fillColor:MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 5, 114, 165)),
                                  value: "Other",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                   });
                                  }),
                            ),
                            const Text("Other"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      Utils.closeKeyBoard(context);
                      print("Tapped Save");
                      if (_patientNameController.text == '') {
                        Utils.showTopSnackBar(context, "Patient name is required");
                        return;
                      }
                      if (_mobileController.text == '') {
                        Utils.showTopSnackBar(context, "Mobile Number is required");
                        return;
                      }
                      if (_addressController.text == '') {
                        Utils.showTopSnackBar(context, "Address is required");
                        return;
                      }
                      if (gender == '') {
                        Utils.showTopSnackBar(context, "Please select gender");
                        return;
                      }
                      setState(() {
                        patientEntryBtnClk = true;
                      });
                      var result = await patientEntry(context);
                      if (result == "true") {
                        Provider.of<PatientsProvider>(context, listen: false).getPatients();
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 28.0.h,
                      width: 80.0.w,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(5.0.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: patientEntryBtnClk
                            ? SizedBox(
                                height: 20.0.h,
                                width: 20.0.w,
                                child: CircularProgressIndicator(color: Colors.white),
                              )
                            : Text("SAVE", style: AllTextStyle.saveButtonTextStyle),
                      ),
                    ),
                  ),
                  ),
                  SizedBox(height: 4.0.h),
                 ],
                ),
              ),
            ),
           ],
        ),
      ),
    );
  }
void emptyMethod() {
  setState(() {
    _patientIDController.text = "";
    _patientNameController.text = "";
    _mobileController.text = "";
    _addressController.text = "";
    _nidNoController.text = "";
    _remarkController.text = "";
    yearController.text = "";
    monthController.text = "";
    dayController.text = "";
    DateTime now = DateTime.now();
    String mm = now.month.toString().padLeft(2, '0');
    String dd = now.day.toString().padLeft(2, '0');
    String yyyy = now.year.toString();
    birthdayController.text = "$mm-$dd-$yyyy";
    calculateAgeFromBirthday(now);
  });
}
bool patientEntryBtnClk = false;
Future<String> patientEntry(BuildContext context) async {
  String link = AppUrl.addPatientEndPoint;
  try {
    final token = getToken();
    var response = await Dio().post(link,
      data:{
          "patient_code": "$patientId",
          "name": _patientNameController.text.trim(),
          "mobile": _mobileController.text.trim(),
          "address": _addressController.text.trim(),
          "nid": _nidNoController.text.trim(),
          "gender": "$gender",
          "date_of_birth": "$dob",
          "remark": _remarkController.text.trim(),
        },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    var item = response.data;
    print("API Response: $item");

    if (item["success"] == true) {
      setState(() {
        patientEntryBtnClk = false;
      });
      emptyMethod();
      CustomSnackBar.showTopSnackBar(context, "${item["message"]}");
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => const PatientEntryScreen()));
      return "true";
    } else {
      setState(() {
        patientEntryBtnClk = false;
      });
      Utils.showTopSnackBar(context,"${item["message"]}");
      return "false";
    }
  } catch (e) {
    setState(() {
      patientEntryBtnClk = false;
    });
    print("Exception caught: $e");
    Utils.showTopSnackBar(context, "Something went wrong: $e");
    return "false";
  }
 }
}
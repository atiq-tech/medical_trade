library;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/models/department_module.dart';
import 'package:medical_trade/diagnostic_module/models/slot_model.dart';
import 'package:medical_trade/diagnostic_module/providers/department_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/doctors_provider.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/animation_snackbar.dart';
import 'package:medical_trade/diagnostic_module/utils/common_textfield.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:provider/provider.dart';

class DoctorEntryScreen extends StatefulWidget {
  const DoctorEntryScreen({super.key,});
  @override
  State<DoctorEntryScreen> createState() => _DoctorEntryScreenState();
}

class _DoctorEntryScreenState extends State<DoctorEntryScreen> {
  Color getColor(Set<WidgetState> states) {
    return Colors.blue.shade200;
  }

  Color getColors(Set<WidgetState> states) {
    return Colors.white;
  }
  final _doctorIDController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _nameBanglaController = TextEditingController();
  final _mobileController = TextEditingController();
  final _remarkController = TextEditingController();
  final _educationLevelController = TextEditingController();
  final _eduLevelBanglaController = TextEditingController();
  final _addressController = TextEditingController();
  final _biographyController = TextEditingController();
  final _feesController = TextEditingController();
  final _commissionAmountController = TextEditingController();
  final _commissionPercentController = TextEditingController();
  final _dayController = TextEditingController();
  final _departmentController = TextEditingController();
  

  // SharedPreferences? sharedPreferences;
  // Future<void> _initializeData() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   userEmployeeId = "${sharedPreferences?.getString('employeeId')}";
  //   userName = "${sharedPreferences?.getString('userName')}";
  //   userType = "${sharedPreferences?.getString('userType')}";
  //   print("userEmployeeId==== $userEmployeeId");
  //   print("userName==== $userName");
  //   print("userType==== $userType");
  // }

  String? customerType = "";
  String? employeeSlNo;
  String? _departmentId;
  String? employeeId = "";
  String? userEmployeeId = "";
  String userName = "";
  String userType = "";

TimeOfDay? startTime;
TimeOfDay? endTime;

List<SlotModel> slotList = [];

String formatTime(TimeOfDay? time) {
  if (time == null) return "--:--";
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat("hh:mm a").format(dt);  // UI FORMAT
}
String formatTimeForApi(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat("HH:mm").format(dt);  // API FORMAT
}
Future<void> pickTime(bool isStart) async {
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (picked != null) {
    setState(() {
      if (isStart) {
        startTime = picked;
      } else {
        endTime = picked;
      }
    });
  }
}

void addSlot() {
  if (startTime != null && endTime != null) {
    setState(() {
      slotList.add(SlotModel(start: startTime!, end: endTime!));
      // startTime = null;
      // endTime = null;
    });
  }
}

  String? firstPickedDate;
  var backEndFirstDate;
  var backEndSecondtDate;

  var toDay = DateTime.now();

  final List<String> _allDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];
  List<String> _selectedDays = [];

  void _calculateCommission() {
  double fees = double.tryParse(_feesController.text) ?? 0;
  double percent = double.tryParse(_commissionPercentController.text) ?? 0;

  // ✅ Percent empty হলে Amount ও clear
  if (_commissionPercentController.text.isEmpty) {
    _commissionAmountController.clear();
    return;
  }

  if (fees > 0 && percent > 0) {
    double amount = (fees * percent) / 100;
    _commissionAmountController.text = amount.toStringAsFixed(2);
  }
}


void _calculateCommissionFromPercent() {
  double fees = double.tryParse(_feesController.text) ?? 0;
  double percent = double.tryParse(_commissionPercentController.text) ?? 0;

  // ✅ Percent clear হলে Amount clear
  if (_commissionPercentController.text.isEmpty) {
    _commissionAmountController.clear();
    return;
  }

  if (fees > 0 && percent > 0) {
    double amount = (fees * percent) / 100;
    _commissionAmountController.text = amount.toStringAsFixed(2);
  }
}


void _calculateCommissionFromAmount() {
  double fees = double.tryParse(_feesController.text) ?? 0;
  double amount = double.tryParse(_commissionAmountController.text) ?? 0;

  // ✅ Amount clear হলে Percent clear
  if (_commissionAmountController.text.isEmpty) {
    _commissionPercentController.clear();
    return;
  }

  if (fees > 0 && amount > 0) {
    double percent = (amount / fees) * 100;
    _commissionPercentController.text = percent.toStringAsFixed(2);
  }
}


  static String getToken() {
    final box = GetStorage();
    return box.read('loginToken') ?? "";
  }

String? doctorId = "";
getDoctorCode() async {
  try {
    String link = AppUrl.getDoctorCodeEndPoint;
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
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginView(isLogin: true,)));
      return;
    }
    setState(() {
      doctorId = response.data["data"].toString();
    });
    print("doctorId ID =========> $doctorId");

  } catch (e) {
    print("doctorId ERROR =======> $e");
  }
}
  @override
  void initState() {
    getDoctorCode();
    _dayController.addListener(_onTextChanged);
    // TODO: implement initState
    super.initState();
    //_initializeData();
    /// Set current time initially for start & end
    TimeOfDay now = TimeOfDay.now();
    startTime = now;
    endTime = now;
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    Provider.of<DepartmentProvider>(context, listen: false).getDepartment("Doctor");
  }

  void _onTextChanged() {
    final text = _dayController.text;
    final typedDays = text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final validDays = typedDays.where((day) => _allDays.contains(day)).toList();

    if (validDays.length != _selectedDays.length ||
        !_selectedDays.every(validDays.contains)) {
      setState(() {
        _selectedDays = validDays;
      });
    }
  }

  @override
  void dispose() {
    _dayController.removeListener(_onTextChanged);
    _dayController.dispose();
    super.dispose();
  }

  ScrollController mainScrollController = ScrollController();
  late final ScrollController _listViewScrollController = ScrollController()
    ..addListener(listViewScrollListener);
  ScrollPhysics _physics = const ScrollPhysics();

  void listViewScrollListener() {
    if (_listViewScrollController.offset >=
        _listViewScrollController.position.maxScrollExtent &&
        !_listViewScrollController.position.outOfRange) {
      if (mainScrollController.offset == 0) {
        mainScrollController.animateTo(50,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      }
      setState(() {
        _physics = const NeverScrollableScrollPhysics();
      });
      print("bottom");
    }
  }
  void mainScrollListener() {
    if (mainScrollController.offset <=
        mainScrollController.position.minScrollExtent &&
        !mainScrollController.position.outOfRange) {
      setState(() {
        if (_physics is NeverScrollableScrollPhysics) {
          _physics = const ScrollPhysics();
          _listViewScrollController.animateTo(
              _listViewScrollController.position.maxScrollExtent - 50,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        }
      });
      print("top");
    }
  }

  @override
  Widget build(BuildContext context) {
    final allDepartmentData = Provider.of<DepartmentProvider>(context).allDepartmentList;
    mainScrollController.addListener(mainScrollListener);
    return Scaffold(
      appBar:AppBar(
      backgroundColor: ColorManager.appbarColor,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Doctor Entry",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    ),
      body: SingleChildScrollView(
        controller: mainScrollController,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
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
                        Expanded(flex: 6,child: Text("Doctor ID",style: AllTextStyle.textFieldHeadStyle)),
                        const Expanded(flex: 1,child: Text(":")),
                        Expanded(
                          flex: 16,
                          child: Container(
                            height: 25.h,
                            decoration: ContDecoration.contDecoration,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w,top: 3.h),
                              child: Text(doctorId.toString(),
                                style: AllTextStyle.dropDownlistStyle
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0.h),
                    Row(
                    children: [
                      Expanded(flex: 6, child: Text("Department",style: AllTextStyle.textFieldHeadStyle)),
                      const Expanded(flex: 1, child: Text(":")),
                      Expanded(
                        flex: 16,
                        child: Container(
                          height: 25.h,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: ContDecoration.contDecoration,
                            child: TypeAheadField<DepartmentModel>(
                            controller: _departmentController,
                            builder: (context, controller, focusNode) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                isDense: true,
                                hintText: 'Select Department',
                                hintStyle: TextStyle(fontSize: 13),
                                suffixIcon: _departmentId == '' || _departmentId == 'null' || _departmentId == null || controller.text == '' ? null
                                    : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _departmentController.clear();
                                      controller.clear();
                                      _departmentId = null;
                                    });
                                  },
                                  child: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.close, size: 16)),
                                ),
                                suffixIconConstraints: BoxConstraints(maxHeight: 30),
                                filled: false,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                            );
                          },
                          suggestionsCallback: (pattern) async {
                            return Future.delayed(const Duration(seconds: 1), () {
                          return allDepartmentData
                            .where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()))
                          .toList().cast<DepartmentModel>(); 
                            });
                            },
                        
                          itemBuilder: (context, DepartmentModel suggestion) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 4.h),
                              child: Text("${suggestion.name}",
                                style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                          onSelected: (DepartmentModel suggestion) {
                                _departmentController.text = "${suggestion.name}";
                                  setState(() {
                                    _departmentId = suggestion.id.toString();
                                  // previousDueController.text = suggestion.dueAmount.toString();
                                  });
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Name",
                      controller: _doctorNameController,
                      hintText: "Enter Doctor Name",
                    ),
                     SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Name(Bangla)",
                      controller: _nameBanglaController,
                      hintText: "Enter Bangla Name",
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Mobile",
                      controller: _mobileController,
                      hintText: "Enter Mobile Number",
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Remark",
                      controller: _remarkController,
                      hintText: "Enter Remark",
                    ),
                    SizedBox(height: 4.0.h),
                     /// ---- Slot Input Row (আপনার কোড) ----
                      Row(
                        children: [
                          Expanded(flex: 3, child: Text("Slot(S/E)", style:AllTextStyle.textFieldHeadStyle)),
                          Expanded(flex: 0, child: Text("   :   ")),
                          Expanded(
                            flex: 4,
                            child: GestureDetector(
                              onTap: () => pickTime(true),
                              child: Container(
                                height: 25.h,
                                decoration: ContDecoration.contDecoration,
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 2.w, bottom: 15.h),
                                    hintStyle: TextStyle(fontSize: 9.sp, color: Colors.black54,fontWeight: FontWeight.bold),
                                    hintText: startTime == null ? "": formatTime(startTime),
                                    suffixIcon: Padding(padding: EdgeInsets.only(right: 0.w),
                                   child: Icon(Icons.alarm_on, color: Colors.black87,size: 16.r)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:2.w),
                          Expanded(
                            flex: 4,
                            child: GestureDetector(
                              onTap: () => pickTime(false),
                              child: Container(
                                height: 25.h,
                                decoration: ContDecoration.contDecoration,
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 2.w, bottom: 15.h),
                                    hintStyle: TextStyle(fontSize: 9.sp, color: Colors.black54,fontWeight: FontWeight.bold),
                                    hintText: endTime == null ? "" : formatTime(endTime),
                                    suffixIcon: Padding(padding: EdgeInsets.only(right: 0.w),
                                   child: Icon(Icons.alarm_on, color: Colors.black87,size: 16.r)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                          onTap: addSlot,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            height: 25.h,
                            width: 25.h,
                            child: Icon(Icons.add, color: Colors.white, size: 16.r))),
                        ],
                      ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowHeight: 18.h,
                          dataRowHeight: 18.h,
                          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade900),
                          border: TableBorder.all(color: const Color.fromARGB(255, 110, 143, 145), width: 1),
                          columns: [
                            DataColumn(label: Center(child: Text('Slot No',style: TextStyle(color: Colors.white,fontSize: 10.sp)))),
                            DataColumn(label: Center(child: Text('Start Time',style: TextStyle(color: Colors.white,fontSize: 10.sp)))),
                            DataColumn(label: Center(child: Text('End Time',style: TextStyle(color: Colors.white,fontSize: 10.sp)))),
                            DataColumn(label: Center(child: Text('Action',style: TextStyle(color: Colors.white,fontSize: 10.sp)))),
                          ],
                          rows: List.generate(
                            slotList.length,
                            (index) {
                              final slot = slotList[index];
                              return DataRow(
                                color: MaterialStateProperty.resolveWith((states) =>index % 2 == 0? const Color.fromARGB(255, 197, 248, 255): Colors.white),
                                cells: [
                                  DataCell(Center(child: Text("Slot ${index + 1}",style: TextStyle(fontSize: 10.sp)))),
                                  DataCell(Center(child: Text(formatTime(slot.start), style: TextStyle(fontSize: 10.sp)))),
                                  DataCell(Center(child: Text(formatTime(slot.end),style: TextStyle(fontSize: 10.sp)))),
                                  DataCell(Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          slotList.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.delete,color: Colors.blue.shade800, size: 15.r),
                                    ),
                                  )),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    CommonTextFieldRow(
                      label: "Address",
                      controller: _addressController,
                      hintText: "Enter Address",
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Fees",
                      controller: _feesController,
                      hintText: "0",
                      onChanged: (value) {
                        _calculateCommission();
                      },
                    ),
                    SizedBox(height: 4.0.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text("Comm(%)", style: AllTextStyle.textFieldHeadStyle),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 25.0.h,
                            child: TextField(
                              controller: _commissionPercentController,
                              style: AllTextStyle.dropDownlistStyle,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: AllTextStyle.textValueStyle,
                                contentPadding: EdgeInsets.only(left: 5.w, top: 4.h),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                              ),
                              onChanged: (value) {
                                _calculateCommissionFromPercent();
                              },
                            ),
                          ),
                        ),
                        const Expanded(flex: 3, child: Center(child: Text("(৳):"))),
                        Expanded(
                          flex: 7,
                          child: SizedBox(
                            height: 25.0.h,
                            child: TextField(
                              controller: _commissionAmountController,
                              style: AllTextStyle.dropDownlistStyle,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: AllTextStyle.textValueStyle,
                                contentPadding: EdgeInsets.only(left: 5.w, top: 4.h),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                              ),
                              onChanged: (value) {
                                _calculateCommissionFromAmount();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0.h),
                  CommonTextFieldRow(
                    label: "Edu.Level",
                    controller: _educationLevelController,
                    hintText: "Enter Education Level",
                    maxLines: 2,
                  ),
                  CommonTextFieldRow(
                    label: "Edu(Bangla)",
                    controller: _eduLevelBanglaController,
                    hintText: "Enter Education Level",
                    maxLines: 2,
                  ),
                  SizedBox(height: 4.0.h),
                  Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      Utils.closeKeyBoard(context);
                      print("Tapped Save");

                      if (_doctorNameController.text == '') {
                        Utils.showTopSnackBar(context, "Doctor name is required");
                        return;
                      }
                      if (_departmentController.text == '') {
                        Utils.showTopSnackBar(context, "Please Select Department");
                        return;
                      }
                      if (_educationLevelController.text == '') {
                        Utils.showTopSnackBar(context, "Education Level is required");
                        return;
                      }
                      if (_feesController.text == '') {
                        Utils.showTopSnackBar(context, "Fees field is required");
                        return;
                      }
                      setState(() {
                        doctorEntryBtnClk = true;
                      });

                      var result = await addDoctor();
                      if (result == "true") {
                        Provider.of<DoctorsProvider>(context, listen: false).getDoctors();
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
                        child: doctorEntryBtnClk
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
            // SizedBox(height: 4.0.h),
            // CustomerListProvider.isCustomerTypeChange
            //     ? SizedBox(
            //     height: MediaQuery.of(context).size.height / 1.43,
            //     child: _buildShimmerEffect(allCustomerList.length))
            //     : Container(
            //   height: MediaQuery.of(context).size.height / 1.43,
            //   width: double.infinity,
            //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: double.infinity,
            //     child: SingleChildScrollView(
            //       controller: _listViewScrollController,
            //       physics: _physics,
            //       scrollDirection: Axis.vertical,
            //       child: SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: DataTable(
            //           headingRowHeight: 20.0,
            //           dataRowHeight: 20.0,
            //           headingRowColor: WidgetStateColor.resolveWith((states) => Colors.blue.shade900),
            //           showCheckboxColumn: true,
            //           border: TableBorder.all(color: Colors.grey.shade400, width: 1),
            //           columns: [
            //             DataColumn(label: Expanded(child: Center(child: Text('Sl.',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Customer Id',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Customer Name',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Owner Name',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Area',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Contact Number',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Employee Name',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Customer Type',style: AllTextStyle.tableHeadTextStyle)))),
            //             DataColumn(label: Expanded(child: Center(child: Text('Credit Limit',style: AllTextStyle.tableHeadTextStyle)))),
            //           ],
            //           rows: List.generate(
            //            allCustomerList.length,
            //                 (int index) => DataRow(
            //               color: index % 2 == 0 ? WidgetStateProperty.resolveWith(getColor) : WidgetStateProperty.resolveWith(getColors),
            //               cells: <DataCell>[
            //                 DataCell(Center(child: Text('${index +1}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].customerCode??""}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].customerName??""}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].ownerName??""}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].unitAreaName??""}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].customerMobile??""}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].addBy??""}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].customerType??""}'))),
            //                 DataCell(Center(child: Text('${allCustomerList[index].customerCreditLimit??""}'))),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 15.0.h),
          ],
        ),
      ),
    );
  }
  // Widget _buildShimmerEffect(int length) {
  //   return ListView.builder(
  //     itemCount: length+1,
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
  //         child: Shimmer.fromColors(
  //           baseColor: Colors.grey.shade300,
  //           highlightColor: Colors.grey.shade100,
  //           child: Container(
  //             height: 15.h,
  //             decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(2.r)),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  void emptyMethod() {
  setState(() {
    _doctorIDController.text = "";
    _doctorNameController.text = "";
    _mobileController.text = "";
    _remarkController.text = "";
     _educationLevelController.text = "";
    _eduLevelBanglaController.text = "";
    _addressController.text = "";
    _biographyController.text = "";
    _feesController.text = "";
    _commissionAmountController.text = "";
    _commissionPercentController.text = "";
    _remarkController.text = "";
    employeeId = "";
    _departmentId = "";
    //_image = null;
  });
}
bool doctorEntryBtnClk = false;
addDoctor() async {
  String link = AppUrl.addDoctorEndPoint;

  try {
    final token = getToken();

    // 🔹 Convert Slot List for API
    var slotData = slotList.map((slot) {
      return {
        "slotName": "Slot ${slotList.indexOf(slot) + 1}",
        "startTime": formatTimeForApi(slot.start), // HH:mm
        "endTime": formatTimeForApi(slot.end),     // HH:mm
      };
    }).toList();

    // 🔹 Doctor Data Body for API
    var doctorData = {
      "doctor_code": doctorId.toString(),
      "department_id": _departmentId.toString(),
      "name": _doctorNameController.text.trim(),
      "name_bangla": _nameBanglaController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "education_level": _educationLevelController.text.trim(),
      "education_level_bangla": _eduLevelBanglaController.text.trim(),
      "address": _addressController.text.trim(),
      "remark": _remarkController.text.trim(),
      "fees": _feesController.text.trim(),
      "slots": slotData,
    };

    // 🔹 Debug print
    print("======== 📤 ADD DOCTOR API CALL ========");
    print("Slot Data:\n$slotData");
    print("Doctor Data:\n$doctorData");

    // 🔹 API Post
    Response response = await Dio().post(
      link,
      data: doctorData,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    var res = response.data;
    print("======== ✅ API RESPONSE ========");
    print(res);

    // 🔹 Response handle
    if (res["success"] == true) {
       setState(() {
        doctorEntryBtnClk = false;
      });
      CustomSnackBar.showTopSnackBar(context, "${res['message']}");

      emptyMethod(); // Clear fields
      slotList.clear();
      setState(() {});

    } else {
      setState(() {
        doctorEntryBtnClk = false;
      });
      Utils.showTopSnackBar(
          context, res["errorMsg"] ?? "Doctor entry failed!");
    }
  } catch (e) {
    print("❌ Error Add Doctor: $e");
    Utils.showTopSnackBar(context, e.toString());
  }
}


}
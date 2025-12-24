library;
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/models/agents_model.dart';
import 'package:medical_trade/diagnostic_module/models/available_slots_model.dart';
import 'package:medical_trade/diagnostic_module/models/department_module.dart';
import 'package:medical_trade/diagnostic_module/models/doctors_model.dart';
import 'package:medical_trade/diagnostic_module/models/patients_model.dart';
import 'package:medical_trade/diagnostic_module/providers/agents_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/available_slots_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/department_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/doctors_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/patients_provider.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/animation_snackbar.dart';
import 'package:medical_trade/diagnostic_module/utils/common_textfield.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:provider/provider.dart';

class AppointmentEntryScreen extends StatefulWidget {
  const AppointmentEntryScreen({super.key,});
  @override
  State<AppointmentEntryScreen> createState() => _AppointmentEntryScreenState();
}

class _AppointmentEntryScreenState extends State<AppointmentEntryScreen> {
  Color getColor(Set<WidgetState> states) {return Colors.blue.shade200;}
  Color getColors(Set<WidgetState> states) {return Colors.white;}
  
  final _patientController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _addressController = TextEditingController();
   final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayAgeController = TextEditingController();
  final _remarkController = TextEditingController();
  final _timeController = TextEditingController();
   final _departmentController = TextEditingController();
  final _slotController = TextEditingController();
  final _conFeesController = TextEditingController();
  final _subTotalController = TextEditingController();
  final _remarkAppointController = TextEditingController();
  final _referenceController = TextEditingController();
  final _discountParcentController = TextEditingController();
  final _discountController = TextEditingController();
  final _advanceController = TextEditingController();
  
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
  String? appointType = "";
  String? customerType = "";
  String? employeeSlNo;
  String? employeeId = "";
  String? userEmployeeId = "";
  String userName = "";
  String userType = "";
  String? _selectedPatientId;
  String? _departmentId;
  String? _slotsId;
  String? _doctorId;
  String? _referenceId;
  String? referenceName;
  double consultationFees = 0;
  double subTotal = 0;
  String dueAmmount = "0";

   void _calculateAll() {
    consultationFees = double.tryParse(_conFeesController.text) ?? 0;
     
    double discountPercent = double.tryParse(_discountParcentController.text) ?? 0;
    double discountAmount = double.tryParse(_discountController.text) ?? 0;
    double advance = double.tryParse(_advanceController.text) ?? 0;

    // Auto calculate discount amount when percentage changes
    if (_discountParcentController.text.isNotEmpty) {
      discountAmount = (consultationFees * discountPercent) / 100;
      _discountController.text = discountAmount.toStringAsFixed(2);
    }

    // Auto calculate discount percentage when amount changes
    if (_discountController.text.isNotEmpty &&
        _discountParcentController.text.isEmpty) {
      discountPercent = (discountAmount / consultationFees) * 100;
      _discountParcentController.text = discountPercent.toStringAsFixed(2);
    }

    double netTotal = consultationFees - discountAmount;
    _subTotalController.text = netTotal.toString();


    // Due = Net Total - Advance
    double due = netTotal - advance;

    setState(() {
      dueAmmount = "$due" ;
      print("due amount $dueAmmount");
    });
  }


  String? firstPickedDate;
  var backEndFirstDate;
  var backEndSecondtDate;

  var toDay = DateTime.now();
  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(selectedDate); // UI show
        backEndFirstDate = Utils.formatBackEndDate(selectedDate); // yyyy-MM-dd
      });

      /// 🔥 এখানে অবশ্যই backend format পাঠাতে হবে
      calculateAge(backEndFirstDate);
    } else {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
      });

      calculateAge(backEndFirstDate);
    }
  }



  String? secondPickedDate;
  void _secondSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndSecondtDate = Utils.formatBackEndDate(selectedDate);
      });
    }else{
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(toDay);
        backEndSecondtDate = Utils.formatBackEndDate(toDay);
      });
    }
  }

   Future<void> _pickTime() async {
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (picked != null) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);

    setState(() {
      _timeController.text = DateFormat('hh:mm').format(dt);  // ✅ 12-hour format with AM/PM
    });
  }
}

  // ✅ Variables
  final List<String> _allGender = ["Male", "Female", "Other"];
  String? _selectedGender;

  // ✅ Controller
  final TextEditingController _genderController = TextEditingController();

void calculateAge(String dobString) {
  try {
    if (dobString.isEmpty) return;

    DateTime dob = DateTime.parse(dobString);
    DateTime now = DateTime.now();

    int year = now.year - dob.year;
    int month = now.month - dob.month;
    int day = now.day - dob.day;

    if (day < 0) {
      month--;
      int prevMonth = now.month == 1 ? 12 : now.month - 1;
      int prevYear = now.month == 1 ? now.year - 1 : now.year;
      day += DateTime(prevYear, prevMonth + 1, 0).day;
    }

    if (month < 0) {
      year--;
      month += 12;
    }

    setState(() {
      _yearController.text = year.toString();
      _monthController.text = month.toString();
      _dayAgeController.text = day.toString();
    });
  } catch (e) {
    print("Age Calculation Error: $e");
  }
}

static String getToken() {
  final box = GetStorage();
  return box.read('loginToken') ?? "";
}

String? appointmentTrID = "";
getAppointmentTrID() async {
  try {
    String link = AppUrl.getAppointmentTrIDEndPoint;
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
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoginView(isLogin: true)),
      );
      return;
    }
    setState(() {
      appointmentTrID = response.data["data"].toString();
    });
    print("appointmentTrID ID =========> $appointmentTrID");

  } catch (e) {
    print("appointmentTrID ERROR =======> $e");
  }
}

String? appointmentSerialNo = "";
getAppointSerialNumber() async {
  try {
    String link = AppUrl.getAppointSerialNumberEndPoint;
    final token = getToken();

    var response = await Dio().post(
      link,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) => status! < 500,
      ),
    );
    print("Response =====> ${response.data}");

    if (response.statusCode == 401) {
      Utils.showTopSnackBar(context, "Session expired. Please log in again.");
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoginView(isLogin: true)),
      );
      return;
    }
    setState(() {
      appointmentSerialNo = response.data.toString();
    });
    print("appointmentSerialNo =========> $appointmentSerialNo");
  } catch (e) {
    print("appointmentSerialNo ERROR =======> $e");
  }
}


   @override
  void initState() {
    _calculateAll();
    getAppointmentTrID();
    getAppointSerialNumber();
    // TODO: implement initState
    super.initState();
    //_initializeData();
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndSecondtDate = Utils.formatBackEndDate(DateTime.now());
    Provider.of<AgentsProvider>(context,listen: false).getAgents();
    Provider.of<PatientsProvider>(context,listen: false).getPatients();
    Provider.of<DoctorsProvider>(context,listen: false).getDoctors();
    Provider.of<DepartmentProvider>(context,listen: false).getDepartment("Doctor");
    Provider.of<AvailableSlotsProvider>(context,listen: false).getAvailableSlots("$_doctorId",""); 
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
    mainScrollController.addListener(mainScrollListener);
    final allAgentsData = Provider.of<AgentsProvider>(context).allAgentsList;
    final allDoctorData = Provider.of<DoctorsProvider>(context).allDoctorsList;
    final allPatientData = Provider.of<PatientsProvider>(context).allPatientList;
    final allDepartmentData = Provider.of<DepartmentProvider>(context).allDepartmentList;
    final allAvailableSlotsData = Provider.of<AvailableSlotsProvider>(context).availableSlotsList; 
    return Scaffold(
      appBar:AppBar(
      backgroundColor: ColorManager.appbarColor,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Appointment Entry",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 217, 213, 255),
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
                    SizedBox(
                          height: 25.h,
                          width: double.infinity,
                          child: Card(
                            margin: EdgeInsets.only(bottom:3.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r),topRight: Radius.circular(6.r)),
                                color: const Color.fromARGB(255, 70, 54, 141),
                              ),
                              child: Center(child: Text('Patient Information',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 16.sp, color: Colors.white))),
                            ),
                          ),
                        ),
                    Container(
                       padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 0.0.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 6, child: Text("Existing Patients",style: AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 16,
                                child: Container(
                                  height: 25.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: ContDecoration.contDecoration,
                                    child: TypeAheadField<PatientsModel>(
                                    controller: _patientController,
                                    builder: (context, controller, focusNode) {
                                    return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                        isDense: true,
                                        hintText: 'Select Patient',
                                        hintStyle: TextStyle(fontSize: 13),
                                        suffixIcon: _selectedPatientId == '' || _selectedPatientId == 'null' || _selectedPatientId == null || controller.text == '' ? null
                                            : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _patientController.clear();
                                              controller.clear();
                                              _selectedPatientId = null;
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
                                  return allPatientData
                                    .where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()))
                                  .toList().cast<PatientsModel>(); 
                                    });
                                    },
                                
                                  itemBuilder: (context, PatientsModel suggestion) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 4.h),
                                      child: Text("${suggestion.name} - ${suggestion.mobile} - ${suggestion.patientCode}",
                                        style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  },
                                  onSelected: (PatientsModel suggestion) {
                                    _patientController.text = "${suggestion.name} - ${suggestion.mobile} - ${suggestion.patientCode}";
                                      setState(() {
                                        _selectedPatientId = suggestion.id.toString();
                                        _nameController.text = suggestion.name.toString();
                                        _mobileController.text = suggestion.mobile.toString();
                                        _addressController.text = suggestion.address.toString();
                                        _remarkController.text = suggestion.remark ?? "n/a";
                                        _selectedGender = suggestion.gender;  
                                        _genderController.text = suggestion.gender.toString();
                                         firstPickedDate = suggestion.dateOfBirth ?? ""; 
                                         calculateAge("$firstPickedDate"); 
                                      });
                                      print("_selectedPatientId ======>>> $_selectedPatientId");
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CommonTextFieldRow(
                            label: "Name",
                            controller: _nameController,
                            hintText: "Enter Name",
                          ),
                      
                          SizedBox(height: 4.0.h),
                          CommonTextFieldRow(
                            label: "Mobile No",
                            controller: _mobileController,
                            hintText: "Enter Mobile",
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 4.0.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Gender",style: AllTextStyle.dateFormatStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 16,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      _selectedGender ?? "Select gender",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: _selectedGender == null
                                            ? Colors.grey
                                            : const Color.fromARGB(221, 83, 83, 83),
                                      ),
                                    ),
                                    // ✅ Items
                                    items: _allGender
                                        .map((gender) => DropdownMenuItem(
                                              value: gender,
                                              child: Text(
                                                gender,
                                                style: AllTextStyle.dateFormatStyle,
                                              ),
                                            ))
                                        .toList(),

                                    // ✅ Value
                                    value: _selectedGender,
                                    // ✅ On Change
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                        _genderController.text = value;
                                      });
                                    },

                                    // ✅ Style
                                    buttonStyleData: ButtonStyleData(
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.r),
                                        border: Border.all(color: Colors.grey),
                                        color: Colors.white,
                                      ),
                                    ),

                                    iconStyleData: IconStyleData(
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24.r,
                                    ),

                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.r),
                                        color: Colors.white,
                                      ),
                                    ),

                                    menuItemStyleData: MenuItemStyleData(
                                      height: 32.h,
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Age ", style: AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1,child: Text(":")),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 25.0.h,
                                  child: TextField(
                                    controller: _yearController,
                                    keyboardType: TextInputType.number,
                                    style: AllTextStyle.dropDownlistStyle,
                                    decoration: InputDecoration(
                                      hintText: "Year",
                                      hintStyle: AllTextStyle.textValueStyle,
                                      contentPadding: EdgeInsets.only(left: 5.w, top: 4.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 25.0.h,
                                  child: TextField(
                                    controller: _monthController,
                                    keyboardType: TextInputType.number,
                                    style: AllTextStyle.dropDownlistStyle,
                                    decoration: InputDecoration(
                                      hintText: "Month",
                                      hintStyle: AllTextStyle.textValueStyle,
                                      contentPadding: EdgeInsets.only(left: 5.w, top: 4.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 25.0.h,
                                  child: TextField(
                                    controller: _dayAgeController,
                                    keyboardType: TextInputType.number,
                                    style: AllTextStyle.dropDownlistStyle,
                                    decoration: InputDecoration(
                                      hintText: "Day",
                                      hintStyle: AllTextStyle.textValueStyle,
                                      contentPadding: EdgeInsets.only(left: 5.w, top: 4.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                         SizedBox(height: 4.0.h),
                          Row(children: [
                            Expanded(flex:6, child: Text("DOB", style:AllTextStyle.textFieldHeadStyle)),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: 25.h,
                                child: GestureDetector(
                                  onTap: (() {
                                    //FocusScope.of(context).requestFocus(quantityFocusNode);
                                    _firstSelectedDate();
                                  }),
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Padding(padding: EdgeInsets.only(left: 20.w),
                                      child: Icon(Icons.calendar_month, color: Colors.black87,size: 16.r)),
                                      border: OutlineInputBorder(borderSide: BorderSide(color:  Colors.grey,width: 5.w)),
                                      hintText: firstPickedDate,
                                      hintStyle: AllTextStyle.dateFormatStyle
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                   
                          SizedBox(height: 4.0.h),
                          CommonTextFieldRow(
                            label: "Address",
                            controller: _addressController,
                            hintText: "Enter Address",
                          ),
                          
                          SizedBox(height: 4.0.h),
                          CommonTextFieldRow(
                            label: "Remark",
                            controller: _remarkController,
                            hintText: "Enter Remark",
                            maxLines: 2,
                          ),
                       ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      
            Container(
            padding: EdgeInsets.all(8.0.r),
            child: Container(
              width: double.infinity,
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
                  SizedBox(
                    height: 25.h,
                    width: double.infinity,
                    child: Card(
                      margin: EdgeInsets.only(bottom:3.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r),topRight: Radius.circular(6.r)),
                          color: Colors.blue.shade900,
                        ),
                        child: Center(child: Text('Appointment Information',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 16.sp, color: Colors.white))),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                    child: Column(
                      children: [
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Tr.ID",style: AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1,child: Text(":")),
                              Expanded(
                                flex: 16,
                                child: Container(
                                  height: 25.h,
                                  decoration: ContDecoration.contDecoration,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5.w, right: 5.w,top: 3.h),
                                    child: Text(appointmentTrID.toString(),
                                      style: AllTextStyle.dropDownlistStyle
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0.h),
                          Row(children: [
                          Expanded(flex:6, child: Text("Apt.Date", style:AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                              height: 25.h,
                              margin: EdgeInsets.only(bottom: 4.h),
                              child: GestureDetector(
                                onTap: (() {
                                  _secondSelectedDate();
                                }),
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Padding(padding: EdgeInsets.only(left: 20.w),
                                    child: Icon(Icons.calendar_month, color: Colors.black87,size: 16.r)),
                                    border: OutlineInputBorder(borderSide: BorderSide(color:  Colors.grey,width: 5.w)),
                                    hintText: secondPickedDate,
                                    hintStyle: AllTextStyle.dateFormatStyle
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                       Row(
                        children: [
                          Expanded(flex: 6, child: Text("Doctor", style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                              height: 25.h,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: ContDecoration.contDecoration,
                              child: TypeAheadField<DoctorsModel>(
                                controller: _doctorNameController,
                                builder: (context, controller, focusNode) {
                                  return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                      isDense: true,
                                      hintText: 'Select Doctor',
                                      hintStyle: TextStyle(fontSize: 13),
                                      suffixIcon: _doctorId == null || controller.text.isEmpty
                                          ? null
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _doctorNameController.clear();
                                                  controller.clear();

                                                  _doctorId = null;

                                                  /// Doctor clear করলে Department ও clear হবে
                                                  _departmentId = null;
                                                  _departmentController.clear();
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Icon(Icons.close, size: 16),
                                              ),
                                            ),
                                      suffixIconConstraints: BoxConstraints(maxHeight: 30),
                                      border: InputBorder.none,
                                    ),
                                  );
                                },
                                suggestionsCallback: (pattern) async {
                                  return Future.delayed(const Duration(milliseconds: 300), () {
                                    return allDoctorData
                                        .where((element) =>
                                            element.name.toLowerCase().contains(pattern.toLowerCase()))
                                        .toList()
                                        .cast<DoctorsModel>();
                                  });
                                },
                                itemBuilder: (context, DoctorsModel suggestion) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                    child: Text(
                                      "${suggestion.doctorCode} ${suggestion.name != "" ? " - ${suggestion.name}" : ""}",
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                onSelected: (DoctorsModel suggestion) {
                                  _doctorNameController.text = "${suggestion.doctorCode} ${suggestion.name != "" ? " - ${suggestion.name}" : ""}";

                                  setState(() {
                                    _doctorId = suggestion.id.toString();
                                    _conFeesController.text = suggestion.fees.toString();
                                    _subTotalController.text = suggestion.fees.toString();
                                    dueAmmount = suggestion.fees.toString();
                                    String doctorDeptId = suggestion.departmentId.toString();
                                    var matchedDepartment = allDepartmentData.firstWhere(
                                      (d) => d.id.toString() == doctorDeptId,
                                      orElse: () => DepartmentModel(id: null, name: "", useFor: null, createdBy: null, updatedBy: null, createdAt: null, updatedAt: null, deletedAt: null, ipAddress: null, branchId: null),
                                    );
                                    if (matchedDepartment.id != null) {
                                      _departmentId = matchedDepartment.id.toString();
                                      _departmentController.text = matchedDepartment.name;
                                    }
                                    _calculateAll();
                                  });
                                  Provider.of<AvailableSlotsProvider>(context, listen: false).getAvailableSlots("$_doctorId", "$backEndFirstDate");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0.h),
                      Row(
                        children: [
                          Expanded(flex: 6, child: Text("Department", style: AllTextStyle.textFieldHeadStyle)),
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
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                      isDense: true,
                                      hintText: 'Select Department',
                                      hintStyle: TextStyle(fontSize: 13),
                                      suffixIcon: _departmentId == null || controller.text.isEmpty
                                          ? null
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _departmentController.clear();
                                                  controller.clear();
                                                  _departmentId = null;
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Icon(Icons.close, size: 16),
                                              ),
                                            ),
                                      suffixIconConstraints: BoxConstraints(maxHeight: 30),
                                      border: InputBorder.none,
                                    ),
                                  );
                                },
                                suggestionsCallback: (pattern) async {
                                  return Future.delayed(const Duration(milliseconds: 300), () {
                                    return allDepartmentData
                                        .where((element) =>
                                            element.name.toLowerCase().contains(pattern.toLowerCase()))
                                        .toList()
                                        .cast<DepartmentModel>();
                                  });
                                },
                                itemBuilder: (context, DepartmentModel suggestion) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                    child: Text(
                                      suggestion.name,
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                onSelected: (DepartmentModel suggestion) {
                                  setState(() {
                                    _departmentController.text = suggestion.name;
                                    _departmentId = suggestion.id.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                        SizedBox(height: 4.0.h),
                        Row(
                          children: [
                            Expanded(flex: 6, child: Text("Slot",style: AllTextStyle.textFieldHeadStyle)),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: 25.h,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: ContDecoration.contDecoration,
                                  child: TypeAheadField<AvailableSlotsModel>(
                                  controller: _slotController,
                                  builder: (context, controller, focusNode) {
                                  return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                      isDense: true,
                                      hintText: 'Select Slot',
                                      hintStyle: TextStyle(fontSize: 13),
                                      suffixIcon: _slotsId == '' || _slotsId == 'null' || _slotsId == null || controller.text == '' ? null
                                          : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _slotController.clear();
                                            controller.clear();
                                            _slotsId = null;
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
                                return allAvailableSlotsData
                                  .where((element) => element.displayText.toLowerCase().contains(pattern.toLowerCase()))
                                .toList().cast<AvailableSlotsModel>(); 
                                  });
                                  },
                              
                                itemBuilder: (context, AvailableSlotsModel suggestion) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 4.h),
                                    child: Text("${suggestion.displayText}",
                                      style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                onSelected: (AvailableSlotsModel suggestion) {
                                  _slotController.text = "${suggestion.displayText}";
                                    setState(() {
                                      _slotsId = suggestion.id.toString();
                                    });
                                },
                              ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0.h),
                        CommonTextFieldRow(
                          label: "Con.Fees",
                          controller: _conFeesController,
                          hintText: "0",
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 4.0.h),
                        CommonTextFieldRow(
                          label: "Subtotal",
                          controller: _subTotalController,
                          hintText: "0",
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 4.0.h),
                        CommonTextFieldRow(
                          label: "Remark",
                          controller: _remarkAppointController,
                          hintText: "Enter Remark",
                        ),
                        SizedBox(height: 4.0.h),
                        Row(
                          children: [
                            Expanded(flex: 6,child: Text("SL.No.",style: AllTextStyle.textFieldHeadStyle)),
                            const Expanded(flex: 1,child: Text(":")),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: 25.h,
                                decoration: ContDecoration.contDecoration,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w,top: 3.h),
                                  child: Text(appointmentSerialNo.toString(),
                                    style: AllTextStyle.dropDownlistStyle
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0.h),
                        Row(children: [
                          Expanded(flex:6, child: Text("Apt.Time", style:AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                        flex:16,
                        child: Container(
                          height: 25.h,
                          margin: EdgeInsets.only(bottom: 4.h),
                          child: TextField(
                            controller: _timeController,
                            readOnly: true,
                            style: AllTextStyle.dateFormatStyle,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Time',
                              suffixIcon: Icon(Icons.access_time,size: 15.r),
                              border: InputBorder.none,
                              focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                              enabledBorder:TextFieldInputBorder.focusEnabledBorder
                            ),
                            onTap: _pickTime,
                          ),
                        ),
                       ),]),
                        Row(
                          children: [
                            Expanded(flex: 6, child: Text("Reference",style: AllTextStyle.textFieldHeadStyle)),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: 25.h,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: ContDecoration.contDecoration,
                                  child: TypeAheadField<AgentsModel>(
                                  controller: _referenceController,
                                  builder: (context, controller, focusNode) {
                                  return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                      isDense: true,
                                      hintText: 'Select Reference',
                                      hintStyle: TextStyle(fontSize: 13),
                                      suffixIcon: _referenceId == '' || _referenceId == 'null' || _referenceId == null || controller.text == '' ? null
                                          : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _referenceController.clear();
                                            controller.clear();
                                            _referenceId = null;
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
                                return allAgentsData
                                  .where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()))
                                .toList().cast<AgentsModel>(); 
                                  });
                                  },
                              
                                itemBuilder: (context, AgentsModel suggestion) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 4.h),
                                    child: Text("${suggestion.agentCode} ${suggestion.name != "" ? " - ${suggestion.name}" : ""}",
                                      style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                onSelected: (AgentsModel suggestion) {
                                  _referenceController.text = "${suggestion.agentCode} ${suggestion.name != "" ? " - ${suggestion.name}" : ""}";
                                    setState(() {
                                      referenceName = suggestion.name; 
                                      _referenceId = suggestion.id.toString();
                                    });
                                    print("_referenceId   Id======$_referenceId");
                                    print("_name Id======${referenceName}");
                                },
                              ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 6, child: Text("Discount", style: AllTextStyle.textFieldHeadStyle)),
                            const Expanded(flex: 1, child: Text(":")),

                            Expanded(
                              flex: 7,
                              child: Container(
                                height: 25.0.h,
                                child: TextField(
                                  style: AllTextStyle.textValueStyle,
                                  controller: _discountParcentController,
                                  onChanged: (value) => _calculateAll(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 3.w),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(flex: 3, child: Center(child: Text("%", style: AllTextStyle.textFieldHeadStyle))),

                            Expanded(
                              flex: 6,
                              child: SizedBox(
                                height: 25.0.h,
                                child: TextField(
                                  style: AllTextStyle.textValueStyle,
                                  controller: _discountController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _discountParcentController.clear();
                                    _calculateAll();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 3.w),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 4.0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 6, child: Text("Advance", style: AllTextStyle.textFieldHeadStyle)),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 7,
                              child: Container(
                                height: 25.0.h,
                                child: TextField(
                                  style: AllTextStyle.textValueStyle,
                                  controller: _advanceController,
                                  onChanged: (value) => _calculateAll(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 3.w),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child: Center(child: Text("Due:", style: AllTextStyle.textFieldHeadStyle)),
                            ),

                            Expanded(
                              flex: 6,
                              child: Container(
                                height: 25.h,
                                decoration: ContDecoration.contDecoration,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w, top: 3.h),
                                  child: Text(
                                    dueAmmount ,
                                    style: AllTextStyle.textValueStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    appointType="reference";
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Text("Reference:"),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          fillColor:MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 5, 114, 165)),
                                          value: "reference",
                                          groupValue: appointType,
                                          onChanged: (value) {
                                            setState(() {
                                              appointType = value.toString();
                                        });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                                GestureDetector(
                                onTap: () {
                                  setState(() {
                                    appointType="no";
                                    });
                                },
                                child: Row(
                                  children: [
                                    const Text("No"),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          fillColor:MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 5, 114, 165)),
                                          value: "no",
                                          groupValue: appointType,
                                          onChanged: (value) {
                                            setState(() {
                                              appointType = value.toString();
                                          });
                                          }),
                                    ),
                                    
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
                          // if (_customerNameController.text == '') {
                          //   Utils.showTopSnackBar(context, "Customer name is required");
                          //   return;
                          // }
                          // if (_regionController.text == '') {
                          //   Utils.showTopSnackBar(context, "Please Select Region");
                          //   return;
                          // }
                          // if (_territoryController.text == '') {
                          //   Utils.showTopSnackBar(context, "Please Select Territory");
                          //   return;
                          // }
                          // if (_ownerMobileController.text == '') {
                          //   Utils.showTopSnackBar(context, "Owner Mobile field is required");
                          //   return;
                          // }
                          // if (_bankNameController.text == '') {
                          //   Utils.showTopSnackBar(context, "Bank Name field is required");
                          //   return;
                          // }
                          // if (_checkNoController.text == '') {
                          //   Utils.showTopSnackBar(context, "Check No. field is required");
                          //   return;
                          // }
                          // if (_bankBranchNameController.text == '') {
                          //   Utils.showTopSnackBar(context, "Bank Branch field is required");
                          //   return;
                          // }
                          // if (_accountNoController.text == '') {
                          //   Utils.showTopSnackBar(context, "Account No. field is required");
                          //   return;
                          // }
                          setState(() {
                            addAppointmentBtnClk = true;
                          });
                          var result = await addAppointmentEntry(context);
                          if (result == "true") {
                           // Provider.of<CustomerListProvider>(context, listen: false).getCustomerList("", "", "");
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
                            child: addAppointmentBtnClk
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
    _patientController.text = "";
    _doctorNameController.text = "";
    _mobileController.text = "";
    _nameController.text = "";
    employeeId = "";
  });
}
bool addAppointmentBtnClk = false;
Future<String> addAppointmentEntry(BuildContext context) async {
  String link = AppUrl.addAppointmentEndPoint;

  try {
    final token = getToken();

    /// ====== BODY DATA READY ======
    Map<String, dynamic> bodyData = {
      "patient": {
        "id": _selectedPatientId.toString(),   // Row theke neya ID
        "name": _nameController.text.trim(),
        "mobile": _mobileController.text.trim(),
        "gender": _selectedGender.toString(),
        "date_of_birth": firstPickedDate,
      },
      "appointment": {
        "token_number": appointmentTrID.toString(),
        "appointment_date": backEndSecondtDate,
        "appointment_time": _timeController.text.trim(),
        "serial_number": appointmentSerialNo,
        "department_id": _departmentId.toString(),
        "doctor_id": _doctorId.toString(),
        "reference_id": _referenceId.toString(),
        "fees": _conFeesController.text.trim(),
        "subtotal": _subTotalController.text.trim(),
        "commission_by": "Agent",
        "slot_id": _slotsId.toString(),
      }
    };

    print("Sending Body: $bodyData");

    /// ====== API CALL ======
    var response = await Dio().post(
      link,
      data: bodyData,
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
        addAppointmentBtnClk = false;
      });

      emptyMethod();
      CustomSnackBar.showTopSnackBar(context, "${item["message"]}");

      return "true";
    } else {
      setState(() {
        addAppointmentBtnClk = false;
      });

      Utils.showTopSnackBar(context, "${item["message"]}");
      return "false";
    }
  } catch (e) {
    setState(() {
      addAppointmentBtnClk = false;
    });
    print("Exception caught: $e");
    Utils.showTopSnackBar(context, "Something went wrong: $e");

    return "false";
  }
}

}
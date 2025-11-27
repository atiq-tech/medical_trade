library;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:medical_trade/diagnostic_module/models/add_cart_model.dart';
import 'package:medical_trade/diagnostic_module/models/agents_model.dart';
import 'package:medical_trade/diagnostic_module/models/doctors_model.dart';
import 'package:medical_trade/diagnostic_module/models/test_entry_model.dart';
import 'package:medical_trade/diagnostic_module/providers/agents_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/doctors_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/test_entry_provider.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/app_colors.dart';
import 'package:medical_trade/diagnostic_module/utils/common_textfield.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:provider/provider.dart';
class TestReceiptScreen extends StatefulWidget {
  const TestReceiptScreen({super.key,});
  @override
  State<TestReceiptScreen> createState() => _TestReceiptScreenState();
}

class _TestReceiptScreenState extends State<TestReceiptScreen> {
  Color getColors(Set<WidgetState> states) {
    return Colors.deepPurple.shade100;
  }

  Color getColor(Set<WidgetState> states) {
    return Colors.white;
  }
  final _patientController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _testNameController = TextEditingController();
  final _roomNoController = TextEditingController();
  final _priceController = TextEditingController();
  final _dayController = TextEditingController();
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  final _collectionChargeController = TextEditingController();
  final _subAmountController = TextEditingController();
  final _addressController = TextEditingController();
  final _vatPercentageController = TextEditingController();
  final _vatController = TextEditingController();
  final _discountParcentageController = TextEditingController();
  final _discountController = TextEditingController();
  final _paidController = TextEditingController();
   final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayAgeController = TextEditingController();
  final _testDiscountParcentController = TextEditingController();
  final _testDiscountController = TextEditingController();
  final _doctorController = TextEditingController();
  final _referenceByController = TextEditingController();
  final _invoiceNoController = TextEditingController();
  final _sLNoController = TextEditingController();
  
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

  String? invoiceType = "";
  String? employeeSlNo;
  String? employeeId = "";
  String? _testId = "";
  String? _doctorId = "";
  String? _agentId = "";
  
  String userName = "";
  String userType = "";
  String? firstPickedDate;
  var backEndFirstDate;
  var backEndSecondtDate;

  var toDay = DateTime.now();
  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndFirstDate = Utils.formatBackEndDate(selectedDate);
      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
      });
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

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
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
      _timeController.text = DateFormat('hh:mm a').format(dt);  // ✅ 12-hour format with AM/PM
    });
  }
}

  List<AddToCartModel> addToCartList = [];

  // ✅ Variables
  final List<String> _allGender = ["Male", "Female", "Other"];
  String? _selectedGender;

  // ✅ Controller
  final TextEditingController _genderController = TextEditingController();


  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndSecondtDate = Utils.formatBackEndDate(DateTime.now());
    // TODO: implement initState
    super.initState();
    //_initializeData();
    Provider.of<TestEntryProvider>(context, listen: false).getTestEntry();
    Provider.of<DoctorsProvider>(context, listen: false).getDoctors();
    Provider.of<AgentsProvider>(context,listen: false).getAgents();
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

double subTotal = 0.0;
double totalAmount = 0.0;
double dueAmount = 0.0;

// Flags to avoid loop
bool _isVatPercentChanging = false;
bool _isVatAmountChanging = false;
bool _isDiscountPercentChanging = false;
bool _isDiscountAmountChanging = false;

void _calculateTotals() {
  double vatPercentage = double.tryParse(_vatPercentageController.text) ?? 0;
  double discountPercentage = double.tryParse(_discountParcentageController.text) ?? 0;
  double others = double.tryParse(_collectionChargeController.text) ?? 0;
  double paid = double.tryParse(_paidController.text) ?? 0;

  double vatAmount = subTotal * vatPercentage / 100;
  double discountAmount = subTotal * discountPercentage / 100;

  // Update VAT
  if (!_isVatAmountChanging) {
    _isVatPercentChanging = true;
    _vatController.text = vatAmount.toStringAsFixed(2);
    _isVatPercentChanging = false;
  }

  // Update Discount
  if (!_isDiscountAmountChanging) {
    _isDiscountPercentChanging = true;
    _discountController.text = discountAmount.toStringAsFixed(2);
    _isDiscountPercentChanging = false;
  }

  totalAmount = (subTotal + vatAmount + others) - discountAmount;
  dueAmount = totalAmount - paid;

  setState(() {});
}

void _calculateSubTotal() {
  double total = 0.0;
  for (var item in addToCartList) {
    double price = double.tryParse(item.price ?? "0") ?? 0.0;
    total += price;
  }
  setState(() {
    subTotal = total;
  });
}

// VAT & Discount listeners
void _onVatPercentageChanged(String value) {
  if (_isVatPercentChanging) return;

  _calculateTotals();
}

void _onVatAmountChanged(String value) {
  if (_isVatAmountChanging) return;

  _isVatAmountChanging = true;

  double vatAmount = double.tryParse(value) ?? 0;
  double percentage = subTotal == 0 ? 0 : (vatAmount / subTotal) * 100;
  _vatPercentageController.text = percentage.toStringAsFixed(2);

  _calculateTotals();
  _isVatAmountChanging = false;
}

void _onDiscountPercentageChanged(String value) {
  if (_isDiscountPercentChanging) return;

  _calculateTotals();
}

void _onDiscountAmountChanged(String value) {
  if (_isDiscountAmountChanging) return;

  _isDiscountAmountChanging = true;

  double discountAmount = double.tryParse(value) ?? 0;
  double percentage = subTotal == 0 ? 0 : (discountAmount / subTotal) * 100;
  _discountParcentageController.text = percentage.toStringAsFixed(2);

  _calculateTotals();
  _isDiscountAmountChanging = false;
}


    void _addToCart() {
    if (_dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _testNameController.text.isEmpty ||
        _roomNoController.text.isEmpty ||
        _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      addToCartList.add(AddToCartModel(
        deliveryDate: _dateController.text,
        deliveryTime: _timeController.text,
        testName: _testNameController.text,
        roomNo: _roomNoController.text,
        price: _priceController.text, 
      ));

      _dateController.clear();
      _timeController.clear();
      _testNameController.clear();
      _roomNoController.clear();
      _priceController.clear();
    });
    _calculateSubTotal();
  }

  void allClear() {
    _patientController.clear();
    _nameController.clear();
    _mobileController.clear();
    _testNameController.clear();
    _roomNoController.clear();
    _priceController.clear();
    _dayController.clear();
    _hourController.clear();
    _minuteController.clear();
    _collectionChargeController.clear();
    _referenceByController.clear();
    _addressController.clear();
    _vatPercentageController.clear();
    _vatController.clear();
    _discountParcentageController.clear();
    _discountController.clear();
    _paidController.clear();
    setState(() {
      addToCartList.clear();
      subTotal = 0.0;
      totalAmount = 0.0;
      dueAmount = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allTestData = Provider.of<TestEntryProvider>(context).allTestEntryList;
    final allDoctorsData = Provider.of<DoctorsProvider>(context).allDoctorsList;
    final allAgentsData = Provider.of<AgentsProvider>(context).allAgentsList;
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
        "Test Receipt",
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 170, 216, 240),
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
                              child: Center(child: Text('Test Information',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 16.sp, color: Colors.white))),
                            ),
                          ),
                        ),
                    Container(
                       padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                      child: Column(
                        children: [
                          CommonTextFieldRow(
                            label: "Patient",
                            controller: _patientController,
                            hintText: "Select Patient",
                          ),
                      
                          SizedBox(height: 4.0.h),
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
                            Expanded(flex:6, child: Text("Date of Birth", style:AllTextStyle.textFieldHeadStyle)),
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
              padding: EdgeInsets.only(left: 10.0.w,right: 10.0.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 186, 185, 245),
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
                        Expanded(flex: 6, child: Text("Test Name",style: AllTextStyle.textFieldHeadStyle)),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 16,
                          child: Container(
                            height: 25.h,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: ContDecoration.contDecoration,
                            child: TypeAheadField<TestEntryModel>(
                            controller: _testNameController,
                            builder: (context, controller, focusNode) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                style: AllTextStyle.textValueStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5.w, top: 2.5.h),
                                  isDense: true,
                                  hintText: 'Select Test Name',
                                  hintStyle: TextStyle(fontSize: 13.sp),
                                  suffixIcon: _testId == '' || _testId == 'null' || _testId == null || controller.text == ''
                                      ? null
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _testNameController.clear();
                                              controller.clear();
                                              _testId = null;
                                            });
                                            // Clear করার পর নতুনভাবে customer লোড
                                            Provider.of<TestEntryProvider>(context, listen: false).getTestEntry(); 
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(5.r),
                                            child: Icon(Icons.close, size: 16.r),
                                          ),
                                        ),
                                  suffixIconConstraints: BoxConstraints(maxHeight: 30.h),
                                  filled: false,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                onTap: () {
                                  // কার্সর রাখলেই নতুনভাবে লোড হবে
                                  Provider.of<TestEntryProvider>(context, listen: false).getTestEntry(); 
                                  // আগের সিলেকশন থাকলে clear হবে
                                  if (_testId != null &&
                                      _testId != '' &&
                                      _testId != 'null') {
                                    setState(() {
                                      _testNameController.clear();
                                      controller.clear();
                                      _testId = null;
                                    });
                                  }
                                },
                              );
                            },
                            suggestionsCallback: (pattern) async {
                              return Future.delayed(const Duration(seconds: 1), () {
                                return allTestData
                                    .where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()))
                                    .toList().cast<TestEntryModel>();
                              });
                            },
                            itemBuilder: (context, TestEntryModel suggestion) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                child: Text(
                                  "${suggestion.name} - ${suggestion.testCode}",
                                  style: TextStyle(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                            onSelected: (TestEntryModel suggestion) {
                              _testNameController.text =  "${suggestion.name} - ${suggestion.testCode}";
                              setState(() {
                                _roomNoController.text = suggestion.roomNumber ?? '';
                                _priceController.text = (suggestion.price ?? 0).toString();
                                _subAmountController.text = (suggestion.price ?? 0).toString();
                                _testId = suggestion.id.toString();
                              });
                              print('Selected Test ID: $_testId');
                              print('Selected Test Name: ${_testNameController.text}');
                              print('Selected Room No: ${_roomNoController.text}');
                              print('Selected Price: ${_priceController.text}');
                              print('Selected Sub Amount: ${_subAmountController.text}');
                            },
                          ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Room No",
                      controller: _roomNoController,
                      hintText: "Enter Room No",
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Price",
                      controller: _priceController,
                      hintText: "0",
                      keyboardType: TextInputType.number,
                    ),
                     SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Sub Amount",
                      controller: _subAmountController,
                      hintText: "0",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 4.0.h),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: Text("Discount", style: AllTextStyle.textFieldHeadStyle)),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 8,
                          child: Container(
                            height: 25.0.h,
                            margin: EdgeInsets.only(left: 3.w, right: 5.w),
                            child: TextField(
                              style: AllTextStyle.textValueStyle,
                              controller: _testDiscountParcentController,
                              onChanged: (value) {
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 3.w),
                                  hintText: "0",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder:TextFieldInputBorder.focusEnabledBorder
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text("%", style: AllTextStyle.textFieldHeadStyle),
                        SizedBox(width: 8.w),
                        Expanded(
                          flex: 7,
                          child: SizedBox(
                            height: 25.0.h,
                            child: TextField(
                              style: AllTextStyle.textValueStyle,
                              controller: _testDiscountController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 6.w),
                                hintText: "0",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                enabledBorder:TextFieldInputBorder.focusEnabledBorder
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0.h),
                    Row(children: [
                      Expanded(flex:6, child: Text("Delivery At", style:AllTextStyle.textFieldHeadStyle)),
                      const Expanded(flex: 1, child: Text(":")),
                      Expanded(
                        flex: 9,
                        child: Container(
                          height: 25.h,
                          margin: EdgeInsets.only(bottom: 4.h,right: 3.w),
                          child: TextField(
                            controller: _dateController,
                            readOnly: true,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 3.h),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Date',
                              suffixIcon: Icon(Icons.calendar_today,size: 12.r),
                              border: InputBorder.none,
                              focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                              enabledBorder:TextFieldInputBorder.focusEnabledBorder
                            ),
                            onTap: _pickDate,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 25.h,
                          margin: EdgeInsets.only(bottom: 4.h),
                          child: TextField(
                            controller: _timeController,
                            readOnly: true,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 3.h),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Time',
                              suffixIcon: Icon(Icons.access_time,size: 12.r),
                              border: InputBorder.none,
                              focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                              enabledBorder:TextFieldInputBorder.focusEnabledBorder
                            ),
                            onTap: _pickTime,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 4.0.h),
                   Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: _addToCart,
                      child: Container(
                        height: 28.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 70, 54, 141),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 4.h),
                 ],
                ),
              ),
            ),
            Container(
              height: addToCartList.isEmpty ? 40
              : addToCartList.length == 1 ? 65 : 40 + (addToCartList.length * 22.0),
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 10.h, right: 10.w),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowHeight: 18.h,
                      dataRowHeight: 18.h,
                      headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 70, 54, 141)),
                      showCheckboxColumn: false,
                      border: TableBorder.all(color: const Color.fromARGB(255, 110, 143, 145), width: 1),
                      columns: const [
                        DataColumn(label: Expanded(child: Center(child: Text('SL.',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Test Name',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Room No',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Price',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Delivery Date',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Action',style: AllTextStyle.tableHeadTextStyle)))),
                      ],
                      rows: List.generate(
                        addToCartList.length,
                        (int index) => DataRow(
                          color: index % 2 == 0? MaterialStateProperty.resolveWith(getColor): MaterialStateProperty.resolveWith(getColors),
                          cells: <DataCell>[
                            DataCell(Center(child: Text("${index + 1}"))),
                            DataCell(Center(child: Text(addToCartList[index].testName!,style: TextStyle(fontSize: 11.sp)))),
                            DataCell(Center(child: Text(addToCartList[index].roomNo!,style: TextStyle(fontSize: 11.sp)))),
                            DataCell(Center(child: Text(addToCartList[index].price!,style: TextStyle(fontSize: 11.sp)))),
                            DataCell(Center(child: Text("${addToCartList[index].deliveryDate!} ${addToCartList[index].deliveryTime!}",style: TextStyle(fontSize: 11.sp)))),
                            DataCell(
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      addToCartList.removeAt(index);
                                    });
                                     _calculateSubTotal();
                                  },
                                  child: Icon(Icons.delete,size: 16.r, color: AppColors.appColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
            padding: EdgeInsets.all(8.0.r),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 170, 216, 240),
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
                          color:const Color.fromARGB(255, 70, 54, 141),
                        ),
                        child: Center(child: Text('Invoice Details',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 16.sp, color: Colors.white))),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                    child: Column(
                      children: [
                        CommonTextFieldRow(
                          label: "Invoice No",
                          controller: _invoiceNoController,
                          hintText: "1000550",
                        ),
                        SizedBox(height: 4.0.h),
                        CommonTextFieldRow(
                          label: "SL No",
                          controller: _sLNoController,
                          hintText: "1",
                        ),
                        SizedBox(height: 4.0.h),
                        Row(
                        children: [
                          Expanded(flex: 6, child: Text("Doctor",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                              height: 25.h,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: ContDecoration.contDecoration,
                                child: TypeAheadField<DoctorsModel>(
                                controller: _doctorController,
                                builder: (context, controller, focusNode) {
                                return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                    isDense: true,
                                    hintText: 'Select Doctor',
                                    hintStyle: TextStyle(fontSize: 13),
                                    suffixIcon: _doctorId == '' || _doctorId == 'null' || _doctorId == null || controller.text == '' ? null
                                        : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _doctorController.clear();
                                          controller.clear();
                                          _doctorId = null;
                                          //previousDueController.clear();
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
                              return allDoctorsData
                                .where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()))
                              .toList().cast<DoctorsModel>(); 
                                });
                                },
                            
                              itemBuilder: (context, DoctorsModel suggestion) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 4.h),
                                  child: Text("${suggestion.doctorCode} ${suggestion.name != "" ? " - ${suggestion.name}" : ""}",
                                    style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                              onSelected: (DoctorsModel suggestion) {
                                _doctorController.text = "${suggestion.doctorCode} ${suggestion.name != "" ? " - ${suggestion.name}" : ""}";
                                  setState(() {
                                    _doctorId = suggestion.id.toString();
                                    // previousDueController.text = suggestion.dueAmount.toString();
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
                          Expanded(flex: 6, child: Text("Ref.By",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                              height: 25.h,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: ContDecoration.contDecoration,
                                child: TypeAheadField<AgentsModel>(
                                controller: _referenceByController,
                                builder: (context, controller, focusNode) {
                                return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                    isDense: true,
                                    hintText: 'Select Agent',
                                    hintStyle: TextStyle(fontSize: 13),
                                    suffixIcon: _agentId == '' || _agentId == 'null' || _agentId == null || controller.text == '' ? null
                                        : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _referenceByController.clear();
                                          controller.clear();
                                          _agentId = null;
                                          //previousDueController.clear();
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
                                    _referenceByController.text = "${suggestion.agentCode} ${suggestion.name != "" ? " - ${suggestion.name}" : ""}";
                                      setState(() {
                                        _agentId = suggestion.id.toString();
                                        // previousDueController.text = suggestion.dueAmount.toString();
                                      });
                              },
                            ),
                            ),
                          ),
                        ],
                      ),
                        SizedBox(height: 4.0.h),
                        Row(children: [
                          Expanded(flex:6, child: Text("Date", style:AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                              height: 25.h,
                              child: GestureDetector(
                                onTap: (() {
                                  //FocusScope.of(context).requestFocus(quantityFocusNode);
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    invoiceType="doctor";
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Text("Doctor:"),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          fillColor:MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 5, 114, 165)),
                                          value: "doctor",
                                          groupValue: invoiceType,
                                          onChanged: (value) {
                                            setState(() {
                                              invoiceType = value.toString();
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
                                    invoiceType="ref";
                                    });
                                },
                                child: Row(
                                  children: [
                                    const Text("Ref.:"),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          fillColor:MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 5, 114, 165)),
                                          value: "ref",
                                          groupValue: invoiceType,
                                          onChanged: (value) {
                                            setState(() {
                                              invoiceType = value.toString();
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
                                    invoiceType="no";
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
                                          groupValue: invoiceType,
                                          onChanged: (value) {
                                            setState(() {
                                              invoiceType = value.toString();
                                          });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
              
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.h, left: 10.0.w, right: 10.0.w, bottom: 5.h),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 186, 185, 245),
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
                  Container(
                    padding: EdgeInsets.only(left: 4.0.w, right: 4.0.w, bottom: 2.0.h),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 6,child: Text("Sub Total",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                              flex: 16,
                              child: Container(
                                margin: EdgeInsets.only(top: 4.h),
                                height: 25.0.h,
                                padding: EdgeInsets.all(4.0.r),
                                decoration:ContDecoration.contDecoration,
                                child: Text(double.parse("$subTotal").toStringAsFixed(0), style: AllTextStyle.textValueStyle,
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 6, child: Text("Collection Charge",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 25.0.h,
                              margin: EdgeInsets.only(top: 4.h),
                              child: TextField(
                                style: AllTextStyle.textValueStyle,
                                controller: _collectionChargeController,
                                onChanged: (value) {
                                  _calculateTotals();
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 5.h, left: 3.w),
                                  hintText: "0",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text("VAT",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 25.0.h,
                              margin: EdgeInsets.only(left: 3.w, right: 5.w,top: 5.h),
                              child: TextField(
                                style: AllTextStyle.textValueStyle,
                                controller: _vatPercentageController,
                                onChanged: (value) {
                                  _onVatPercentageChanged(value);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "0",
                                    contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                ),
                              ),
                            ),
                          ),

                          ///vat Amount
                          SizedBox(width: 4.w),
                          Text("%",style: AllTextStyle.textFieldHeadStyle),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 7,
                            child: Container(
                              height: 25.0.h,
                              margin: EdgeInsets.only(top: 4.0.h),
                              child: TextField(
                                style: AllTextStyle.textValueStyle,
                                controller: _vatController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _onVatAmountChanged(value);
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 6.w),
                                    hintText: "0",
                                    hintStyle: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder:TextFieldInputBorder.focusEnabledBorder
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
                          Expanded(flex: 6, child: Text("Discount", style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 25.0.h,
                              margin: EdgeInsets.only(left: 3.w, right: 5.w),
                              child: TextField(
                                style: AllTextStyle.textValueStyle,
                                controller: _discountParcentageController,
                                onChanged: (value) {
                                  _onDiscountPercentageChanged(value);
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 3.w),
                                    hintText: "0",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text("%", style: AllTextStyle.textFieldHeadStyle),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                              height: 25.0.h,
                              child: TextField(
                                style: AllTextStyle.textValueStyle,
                                controller: _discountController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _onDiscountAmountChanged(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 6.w),
                                  hintText: "0",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder:TextFieldInputBorder.focusEnabledBorder
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
                          Expanded(flex: 6, child: Text("Total",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                            margin: EdgeInsets.only(bottom: 4.h),
                            height: 25.0.h,
                            padding: EdgeInsets.only(left: 4.h, right: 4.h, top: 3.h),
                            decoration:ContDecoration.contDecoration,
                            child: Text("$totalAmount",style: AllTextStyle.textValueStyle,
                            ),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 6, child: Text("Paid", style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                              height: 25.0.h,
                              margin: EdgeInsets.only(bottom: 4.h),
                              child: TextField(style: AllTextStyle.textValueStyle,
                                controller: _paidController,
                                onChanged: (value) {
                                  _calculateTotals();
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
                                  hintText: "0",
                                  hintStyle: TextStyle(fontSize: 13.5.sp,fontWeight: FontWeight.w400,color: Colors.grey.shade600),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: Text("Due",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                              flex: 8,
                              child: Container(
                                height: 25.0.h,
                                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.h),
                                decoration:ContDecoration.contDecoration,
                                child: Text("$dueAmount",style:AllTextStyle.textValueStyle),
                              )),
                          SizedBox(width: 4.w),
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 25.0.h,
                              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.h),
                              decoration:ContDecoration.contDecoration,
                              child: SizedBox(
                                child: Text("0",
                                  style: TextStyle(color: Colors.red,fontSize: 13.5.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              allClear();
                            },
                            child: Card(
                              elevation: 5.0,
                              child: Container(
                                height: 28.0.h,
                                width: 100.0.w,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 118, 160, 4),
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                child: Center(child: Text("New", style: AllTextStyle.saveButtonTextStyle),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () {
                           
                            },
                            child: Card(
                              elevation: 5.0,
                              child: Container(
                                height: 28.0.h,
                                width: 100.0.w,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                child: Center(child: customerEntryBtnClk ? SizedBox(height:20.h,width:20.w,child: CircularProgressIndicator(color: Colors.white))
                                    : Text("Save", style: AllTextStyle.saveButtonTextStyle)),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                
                ],
              ),
            ),
            SizedBox(height: 100.0.h),
          ],
        ),
      ),
    );
  }
  void emptyMethod() {
  setState(() {
    _patientController.text = "";
    _mobileController.text = "";
    _testNameController.text = "";
    _roomNoController.text = "";
    _priceController.text = "";
    _dayController.text = "";
    _nameController.text = "";
    _hourController.text = "";
    _minuteController.text = "";
  });
}
bool customerEntryBtnClk = false;
}
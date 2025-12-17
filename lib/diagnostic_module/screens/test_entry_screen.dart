library;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/models/specimens_model.dart';
import 'package:medical_trade/diagnostic_module/providers/specimens_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/test_entry_provider.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/animation_snackbar.dart';
import 'package:medical_trade/diagnostic_module/utils/common_textfield.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:provider/provider.dart';
class TestEntryScreen extends StatefulWidget {
  const TestEntryScreen({super.key,});
  @override
  State<TestEntryScreen> createState() => _TestEntryScreenState();
}

class _TestEntryScreenState extends State<TestEntryScreen> {
  Color getColor(Set<WidgetState> states) {
    return const Color.fromARGB(255, 255, 239, 195);
  }

  Color getColors(Set<WidgetState> states) {
    return Colors.white;
  }
  final _testIDController = TextEditingController();
  final _specimenController = TextEditingController();
  final _testNameController = TextEditingController();
  final _roomNoController = TextEditingController();
  final _priceController = TextEditingController();
  final _dayController = TextEditingController();
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  final _remarkController = TextEditingController();
  
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
  
  String? specimensId;
  String? customerType = "";
  String? employeeSlNo;
  String? employeeId = "";
  String? userEmployeeId = "";
  String userName = "";
  String userType = "";

  @override
  void initState() {
    getTestCode();
    // TODO: implement initState
    super.initState();
    //_initializeData();
    Provider.of<SpecimensProvider>(context, listen: false).getSpecimens();
    Provider.of<TestEntryProvider>(context, listen: false).getTestEntry();
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
  static String getToken() {
    final box = GetStorage();
    return box.read('loginToken') ?? "";
  }
  String? testId = "";
  getTestCode() async {
    try {
      String link = AppUrl.getTestCodeEndPoint;
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
        testId = response.data["data"].toString();
      });
      print("testId ID =========> $testId");

    } catch (e) {
      print("getPatientCode ERROR =======> $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final allTestData = Provider.of<TestEntryProvider>(context).allTestEntryList;
    final allSpecimensData = Provider.of<SpecimensProvider>(context).allSpecimensList;
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
        "Test Entry",
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
                padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
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
                        Expanded(flex: 6,child: Text("Test ID",style: AllTextStyle.textFieldHeadStyle)),
                        const Expanded(flex: 1,child: Text(":")),
                        Expanded(
                          flex: 16,
                          child: Container(
                            height: 25.h,
                            decoration: ContDecoration.contDecoration,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w,top: 3.h),
                              child: Text(testId.toString(),
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
                      controller: _testNameController,
                      hintText: "Enter Test Name",
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Expanded(flex: 6, child: Text("Specimen",style:AllTextStyle.textFieldHeadStyle)),
                      Expanded(flex: 1,child: Text(":   ",style:AllTextStyle.textFieldHeadStyle)),
                      Expanded(
                      flex: 16,
                      child: Container(
                        margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                        height: 25.0.h,
                        decoration: ContDecoration.contDecoration,
                        child: TypeAheadField<SpecimensModel>(
                            controller: _specimenController,
                            builder: (context, controller, focusNode) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                style: AllTextStyle.textValueStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5.w, top: 2.5.h),
                                  isDense: true,
                                  hintText: 'Select Specimen',
                                  hintStyle: TextStyle(fontSize: 13.sp),
                                  suffixIcon: specimensId == '' || specimensId == 'null' || specimensId == null || controller.text == ''
                                      ? null
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _specimenController.clear();
                                              controller.clear();
                                              specimensId = null;
                                            });
                                            // Clear করার পর নতুনভাবে customer লোড
                                            Provider.of<SpecimensProvider>(context, listen: false).getSpecimens(); 
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
                                  Provider.of<SpecimensProvider>(context, listen: false).getSpecimens(); 
                                  // আগের সিলেকশন থাকলে clear হবে
                                  if (specimensId != null &&
                                      specimensId != '' &&
                                      specimensId != 'null') {
                                    setState(() {
                                      _specimenController.clear();
                                      controller.clear();
                                      specimensId = null;
                                    });
                                  }
                                },
                              );
                            },
                            suggestionsCallback: (pattern) async {
                              return Future.delayed(const Duration(seconds: 1), () {
                                return allSpecimensData
                                    .where((element) => element.specimenName
                                        .toLowerCase()
                                        .contains(pattern.toLowerCase()))
                                    .toList()
                                    .cast<SpecimensModel>();
                              });
                            },
                            itemBuilder: (context, SpecimensModel suggestion) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                child: Text(
                                  "${suggestion.specimenName}",
                                  style: TextStyle(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                            onSelected: (SpecimensModel suggestion) {
                              _specimenController.text = "${suggestion.specimenName}";
                              setState(() {
                                specimensId = suggestion.id.toString();
                              });
                            },
                          ),
                      )
                      )
                      ],
                    ),
                    
                    CommonTextFieldRow(
                      label: "Room No",
                      controller: _roomNoController,
                      hintText: "Enter Room No",
                    ),

                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Price",
                      controller: _priceController,
                      hintText: "0",
                    ),
                    SizedBox(height: 4.0.h),
                    Row(
                    children: [
                      Expanded(flex: 6,child: Text("Time ", style: AllTextStyle.textFieldHeadStyle)),
                      const Expanded(flex: 1,child: Text(":")),
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 25.0.h,
                          child: TextField(
                            controller: _dayController,
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
                      SizedBox(width: 5.w),
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 25.0.h,
                          child: TextField(
                            controller: _hourController,
                            style: AllTextStyle.dropDownlistStyle,
                            decoration: InputDecoration(
                              hintText: "Hour",
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
                            controller: _minuteController,
                            style: AllTextStyle.dropDownlistStyle,
                            decoration: InputDecoration(
                              hintText: "Minute",
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
                    CommonTextFieldRow(
                      label: "Remark",
                      controller: _remarkController,
                      hintText: "Enter Remark",
                    ),
                  SizedBox(height: 4.0.h),  
                  Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      Utils.closeKeyBoard(context);
                      print("Tapped Save");

                      if (_testNameController.text == '') {
                        Utils.showTopSnackBar(context, "Test name is required");
                        return;
                      }
                      if (_specimenController.text == '') {
                        Utils.showTopSnackBar(context, "Please Select Specimen");
                        return;
                      }
                      if (_priceController.text == '') {
                        Utils.showTopSnackBar(context, "Price is required");
                        return;
                      }
                      setState(() {
                        testEntryBtnClk = true;
                      });
                      var result = await testEntry(context);
                      if (result == "true") {
                        Provider.of<TestEntryProvider>(context, listen: false).getTestEntry();
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
                        child: testEntryBtnClk
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
            SizedBox(height: 4.0.h),
            TestEntryProvider.isTestEntryLoading
                ? SizedBox(
                height: MediaQuery.of(context).size.height / 1.43,
                child: CircularProgressIndicator())
                : Container(
              height: MediaQuery.of(context).size.height / 1.43,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  controller: _listViewScrollController,
                  physics: _physics,
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowHeight: 20.0,
                      dataRowHeight: 20.0,
                      headingRowColor: WidgetStateColor.resolveWith((states) => Colors.blue.shade900),
                      showCheckboxColumn: true,
                      border: TableBorder.all(color: Colors.grey.shade400, width: 1),
                      columns: [
                        DataColumn(label: Expanded(child: Center(child: Text('ID ↕',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Name ↕',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Room ↕',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Price ↕',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Specimen ↕',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Delivery Time ↕',style: AllTextStyle.tableHeadTextStyle)))),
                        DataColumn(label: Expanded(child: Center(child: Text('Remark ↕',style: AllTextStyle.tableHeadTextStyle)))),
                     					
                      ],
                      rows: List.generate(
                       allTestData.length,
                            (int index) => DataRow(
                          color: index % 2 == 0 ? WidgetStateProperty.resolveWith(getColor) : WidgetStateProperty.resolveWith(getColors),
                          cells: <DataCell>[
                            DataCell(Center(child: Text('${allTestData[index].testCode??""}'))),
                            DataCell(Center(child: Text('${allTestData[index].name??""}'))),
                            DataCell(Center(child: Text('${allTestData[index].roomNumber??""}'))),
                            DataCell(Center(child: Text('${allTestData[index].price??""}'))),
                            DataCell(Center(child: Text('${allTestData[index].specimen.specimenName??""}'))),
                            DataCell(Center(child: Text('${allTestData[index].day??""}Days'))),
                            DataCell(Center(child: Text('${allTestData[index].remark??""}'))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0.h),
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
    _testIDController.text = "";
    _testNameController.text = "";
    _roomNoController.text = "";
    _priceController.text = "";
    _dayController.text = "";
    _specimenController.text = "";
    _remarkController.text = "";
    _hourController.text = "";
    _minuteController.text = "";
    specimensId = "";
  });
}
bool testEntryBtnClk = false;
Future<String> testEntry(BuildContext context) async {
  String link = AppUrl.addTestEntryEndPoint;
  try {
    final token = getToken();
    var response = await Dio().post(link,
      data: {
        "test_code": testId.toString(),
        "room_number": _roomNoController.text.trim(),
        "name": _testNameController.text.trim(),
        "specimen_id": specimensId.toString(),
        "price": _priceController.text.trim(),
        "day": _dayController.text.trim(),
        "hour": _hourController.text.trim(),
        "minute": _minuteController.text.trim(),
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
        testEntryBtnClk = false;
      });
      emptyMethod();
      CustomSnackBar.showTopSnackBar(context, "${item["message"]}");
      getTestCode();
      return "true";
    } else {
      setState(() {
        testEntryBtnClk = false;
      });
      Utils.showTopSnackBar(context,"${item["message"]}");
      return "false";
    }
  } catch (e) {
    setState(() {
      testEntryBtnClk = false;
    });
    print("Exception caught: $e");
    Utils.showTopSnackBar(context, "Something went wrong: $e");
    return "false";
  }
 }
}
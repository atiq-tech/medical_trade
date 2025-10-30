library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/common_textfield.dart';
import 'package:medical_trade/utilities/color_manager.dart';
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
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  
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
  String? employeeId = "";
  String? userEmployeeId = "";
  String userName = "";
  String userType = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initializeData();
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
        controller: mainScrollController,
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
                    CommonTextFieldRow(
                      label: "Patient ID",
                      controller: _patientIDController,
                      hintText: "P00001",
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
                    ),

                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Age",
                      controller: _ageController,
                      hintText: "Enter Age",
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
                            customerType="male";
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
                                  value: "male",
                                  groupValue: customerType,
                                  onChanged: (value) {
                                    setState(() {
                                      customerType = value.toString();
                                 });
                                  }),
                            ),
                            const Text("Male"),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                        GestureDetector(
                        onTap: () {
                          setState(() {
                            customerType="female";
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
                                  value: "female",
                                  groupValue: customerType,
                                  onChanged: (value) {
                                    setState(() {
                                      customerType = value.toString();
                                   });
                                  }),
                            ),
                            const Text("Female"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      // Utils.closeKeyBoard(context);
                      // print("Tapped Save");

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

                      // setState(() {
                      //   customerEntryBtnClk = true;
                      // });

                      // var result = await customerEntry(context);
                      // if (result == "true") {
                      //   Provider.of<CustomerListProvider>(context, listen: false).getCustomerList("", "", "");
                      // }
                      // setState(() {});
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
                        child: customerEntryBtnClk
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
    _patientIDController.text = "";
    _patientNameController.text = "";
    _mobileController.text = "";
    _ageController.text = "";
    _addressController.text = "";
    //_image = null;
  });
}
bool customerEntryBtnClk = false;
// Future<String> customerEntry(BuildContext context) async {
//   String link = "${baseUrl}add_customer";
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   try {
//     var response = await Dio().post(link,
//       data:{
//         "Customer_SlNo": 0,
//         "Customer_Code": "",
//         "Customer_Name": _customerNameController.text.trim(),
//         "Customer_Type": customerType.toString().trim(),
//         "Customer_Phone": '',
//         "Customer_Mobile": _ownerMobileController.text.trim(),
//         "cheque_number": _chequeDetailsController.text.trim(),
//         "Customer_Email": _emailController.text.trim(),
//         "Customer_OfficePhone": _pMMobileController.text.trim(),
//         "Customer_Address": _deliveryAddressController.text.trim(),
//         "Customer_Address_Others": _officeAddressController.text.trim(),
//         "owner_name": _ownerNameController.text.trim(),
//         "bank_name": _bankNameController.text.trim(),
//         "check_no": _checkNoController.text.trim(),
//         "brunch_name": _bankBranchNameController.text.trim(),
//         "account_no": _accountNoController.text.trim(),
//         "unit_area_id": regionId.toString().trim(),
//         "territory_id": territoriesId.toString().trim(),
//         "Customer_Credit_Limit": _creditLimitController.text.trim(),
//         "previous_due": _previousDueController.text.trim(),
//       },
//       options: Options(
//         headers: {
//           "Content-Type": "application/json",
//           'Cookie': 'ci_session=${sharedPreferences.getString("sessionId")}',
//           "Authorization": "Bearer ${sharedPreferences.getString("token")}",
//         },
//       ),
//     );

//     var item = response.data;
//     print("API Response: $item");

//     if (item["success"] == true) {
//       setState(() {
//         customerEntryBtnClk = false;
//       });
//       emptyMethod();
//       CustomSnackBar.showTopSnackBar(context, "${item["message"]}");
//       Navigator.push(context,MaterialPageRoute(builder:(context) => const CustomerEntryScreen()));
//       return "true";
//     } else {
//       setState(() {
//         customerEntryBtnClk = false;
//       });
//       Utils.showTopSnackBar(context,"${item["message"]}");
//       return "false";
//     }
//   } catch (e) {
//     setState(() {
//       customerEntryBtnClk = false;
//     });
//     print("Exception caught: $e");
//     Utils.showTopSnackBar(context, "Something went wrong: $e");
//     return "false";
//   }
// }
 
}
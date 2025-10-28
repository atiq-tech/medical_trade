library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:medical_trade/diagonostic_module/models/add_cart_model.dart';
import 'package:medical_trade/diagonostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagonostic_module/utils/app_colors.dart';
import 'package:medical_trade/diagonostic_module/utils/common_textfield.dart';
import 'package:medical_trade/diagonostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
class TestReceiptScreen extends StatefulWidget {
  const TestReceiptScreen({super.key,});
  @override
  State<TestReceiptScreen> createState() => _TestReceiptScreenState();
}

class _TestReceiptScreenState extends State<TestReceiptScreen> {
  Color getColor(Set<WidgetState> states) {
    return Colors.blue.shade200;
  }

  Color getColors(Set<WidgetState> states) {
    return Colors.white;
  }
  final _testIDController = TextEditingController();
  final _departmentController = TextEditingController();
  final _testNameController = TextEditingController();
  final _roomNoController = TextEditingController();
  final _priceController = TextEditingController();
  final _dayController = TextEditingController();
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  
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
  double subtotal = 0.0;

   List<AddToCartModel> addToCartList = [];
  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
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
        productId: _dateController.text,
        name: _timeController.text,
        code: _testNameController.text,
        categoryId: _roomNoController.text,
        categoryName: _priceController.text, 
        salesRate: '', 
        purchaseRate: '', 
        colorId: '',
        color: '', 
        sizeId: '', 
        size: '', 
        quantity: '', 
        discount: '', 
        vat: '', 
        discountAmount: '', 
        total: '', 
        note: '', isService: '', isConvert: '', convertQty: '', convertName: '', unitName: '', pcsQty: '', unitQty: '',
      ));
  // deliveryDate: _dateController.text,
  //       deliveryTime: _timeController.text,
  //       testName: _testNameController.text,
  //       roomNo: _roomNoController.text,
  //       price: _priceController.text,

      _dateController.clear();
      _timeController.clear();
      _testNameController.clear();
      _roomNoController.clear();
      _priceController.clear();
    });
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
                padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 5.0.h),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 221, 231, 221),
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
                    Row(children: [
                      Expanded(flex:6, child: Text("Bill Date", style:AllTextStyle.textFieldHeadStyle)),
                      const Expanded(flex: 1, child: Text(":")),
                      Expanded(
                        flex: 16,
                        child: Container(
                          height: 25.h,
                          margin: EdgeInsets.only(bottom: 4.h),
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
                    CommonTextFieldRow(
                      label: "Patient",
                      controller: _testIDController,
                      hintText: "Select Patient",
                    ),

                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Name",
                      controller: _departmentController,
                      hintText: "Enter Name",
                    ),

                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Mobile",
                      controller: _testNameController,
                      hintText: "Enter Mobile",
                    ),

                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Referred by",
                      controller: _priceController,
                      hintText: "Atiqur Rahman Atiq",
                    ),
                    
                    SizedBox(height: 4.0.h),
                    CommonTextFieldRow(
                      label: "Address",
                      controller: _roomNoController,
                      hintText: "Enter Address",
                      maxLines: 2,
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
                  color: Color.fromARGB(255, 221, 231, 221),
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
                    Row(children: [
                      Expanded(flex:6, child: Text("Delivery Date", style:AllTextStyle.textFieldHeadStyle)),
                      const Expanded(flex: 1, child: Text(":")),
                      Expanded(
                        flex: 9,
                        child: Container(
                          height: 25.h,
                          margin: EdgeInsets.only(bottom: 4.h,right: 3.w),
                          child: TextField(
                            controller: _dateController,
                            readOnly: true,
                            style: AllTextStyle.dateFormatStyle,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
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
                            style: AllTextStyle.dateFormatStyle,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
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
                    CommonTextFieldRow(
                      label: "Test Name",
                      controller: _testNameController,
                      hintText: "Enter Test Name",
                    ),

                    SizedBox(height: 4.0.h),
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
                   Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: _addToCart,
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
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
                            "ADD",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                 ],
                ),
              ),
            ),
            Container(
              height: addToCartList.isEmpty ? 40
              : addToCartList.length == 1 ? 65 : 40 + (addToCartList.length * 22.0),
              width: double.infinity,
              padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
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
                      headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 1, 129, 143)),
                      showCheckboxColumn: false,
                      border: TableBorder.all(color: const Color.fromARGB(255, 164, 217, 219), width: 1),
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
                            DataCell(Center(child: Text(addToCartList[index].productId!,style: TextStyle(fontSize: 11.sp)))),
                            DataCell(Center(child: Text(addToCartList[index].code!,style: TextStyle(fontSize: 11.sp)))),
                            DataCell(Center(child: Text(addToCartList[index].categoryId!,style: TextStyle(fontSize: 11.sp)))),
                            DataCell(Center(child: Text("${addToCartList[index].productId!} ${addToCartList[index].name!}",style: TextStyle(fontSize: 11.sp)))),
                            DataCell(
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      addToCartList.removeAt(index);
                                    });
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
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.h, left: 10.0.w, right: 10.0.w, bottom: 5.h),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 231, 221),
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
                                child: Text(double.parse("$subtotal").toStringAsFixed(0), style: AllTextStyle.textValueStyle,
                                ),
                              )),
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
                                controller: _priceController,
                                // controller: _vatPercentageController,
                                onChanged: (value) {
                                  
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
                                controller: _testNameController,
                                // controller: _VatController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                              
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
                                controller: _roomNoController,
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

                          ///dis Amount
                          SizedBox(width: 4.w),
                          Text("%", style: AllTextStyle.textFieldHeadStyle),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                              height: 25.0.h,
                              child: TextField(
                                style: AllTextStyle.textValueStyle,
                                controller: _hourController,
                                //controller: _DiscountController,
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
                      Row(
                        children: [
                          Expanded(flex: 6, child: Text("Others",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                              height: 25.0.h,
                              margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                              child: TextField(
                                style: AllTextStyle.textValueStyle,
                                controller: _departmentController,
                                onChanged: (value) {
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
                          Expanded(flex: 6, child: Text("Total Bill",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 16,
                            child: Container(
                            margin: EdgeInsets.only(bottom: 4.h),
                            height: 25.0.h,
                            padding: EdgeInsets.only(left: 4.h, right: 4.h, top: 3.h),
                            decoration:ContDecoration.contDecoration,
                            child: Text("0",style: AllTextStyle.textValueStyle,
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
                                controller: _hourController,
                                onChanged: (value) {
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
                                child: Text("0",style:AllTextStyle.textValueStyle),
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
                            onTap: () {},
                            child: Card(
                              elevation: 5.0,
                              child: Container(
                                height: 28.0.h,
                                width: 100.0.w,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 118, 160, 4),
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                child: Center(child: Text("Clear", style: AllTextStyle.saveButtonTextStyle),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
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
    _testIDController.text = "";
    _testNameController.text = "";
    _roomNoController.text = "";
    _priceController.text = "";
    _dayController.text = "";
    _departmentController.text = "";
    _hourController.text = "";
    _minuteController.text = "";
  });
}
bool customerEntryBtnClk = false;

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
        _timeController.text = DateFormat('HH:mm').format(dt);
      });
    }
  }
}
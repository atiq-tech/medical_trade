import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';

class PatientPaymentEntryScreen extends StatefulWidget {
  const PatientPaymentEntryScreen({super.key});
  @override
  State<PatientPaymentEntryScreen> createState() => _PatientPaymentEntryScreenState();
}

class _PatientPaymentEntryScreenState extends State<PatientPaymentEntryScreen> {
  Color getColor(Set<WidgetState> states) {
    return Colors.blue.shade200;
  }
  Color getColors(Set<WidgetState> states) {
    return Colors.white;
  }
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController patientController = TextEditingController();
  final TextEditingController previousDueController = TextEditingController();
  var quantityController = TextEditingController();
  ///new condition
  FocusNode quantityFocusNode = FocusNode();
  //
  String? firstPickedDate;
  String? backEndFirstDate;
  bool isBtnLoading = false;

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
        // SupplierPaymentProvider().on();
        // Provider.of<SupplierPaymentProvider>(context,listen: false).getSupplierPayment("","$backEndFirstDate","$backEndFirstDate");

      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
      });
    }
  }
  bool _isDropdownOpen = false;
  // String? getTransactionType;
  // String? _transactionType = 'Payment';
  // final List<String> _transactionTypeList = [
  //   'Receive',
  //   'Payment',
  // ];

  // final LayerLink _trTypeLayerLink = LayerLink();
  // OverlayEntry? _trTypeOverlayEntry;

  // final GlobalKey _trkey = GlobalKey();
  // Size _trTypeDropdownSize = Size.zero;

  // void _getTrTypeDropdownSize(Duration _) {
  //   final RenderBox renderBox = _trkey.currentContext?.findRenderObject() as RenderBox;
  //   _trTypeDropdownSize = renderBox.size;
  // }

  // void _toggleTrTypeDropdown() {
  //   if (_isDropdownOpen) {
  //     _removeTrTypeDropdown();
  //   } else {
  //     _showTrTypeDropdown();
  //   }
  // }

  // void _showTrTypeDropdown() {
  //   _trTypeOverlayEntry = _createTrTypeOverlayEntry();
  //   Overlay.of(context).insert(_trTypeOverlayEntry!);
  //   setState(() {
  //     _isDropdownOpen = true;
  //   });
  // }

  // void _removeTrTypeDropdown() {
  //   _trTypeOverlayEntry?.remove();
  //   _trTypeOverlayEntry = null;
  //   setState(() {
  //     _isDropdownOpen = false;
  //   });
  // }

  // OverlayEntry _createTrTypeOverlayEntry() {
  //   return OverlayEntry(
  //     builder: (context) => GestureDetector(
  //       onTap: _removeTrTypeDropdown,
  //       behavior: HitTestBehavior.translucent,
  //       child: Stack(
  //         children: [
  //           Positioned(
  //             width: _trTypeDropdownSize.width,
  //             child: CompositedTransformFollower(
  //               link: _trTypeLayerLink,
  //               showWhenUnlinked: false,
  //               offset: Offset(0.0, _trTypeDropdownSize.height + 2),
  //               child: Material(
  //                 elevation: 9.0,
  //                 color: Colors.blue.shade50,
  //                 borderRadius: BorderRadius.circular(5.r),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: _transactionTypeList.asMap().entries.map((entry) {
  //                     final index = entry.key;
  //                     final type = entry.value;
  //                     return InkWell(
  //                       onTap: () {
  //                         _onSelectedTRType(type);
  //                         _removeTrTypeDropdown();
  //                       },
  //                       child: Column(
  //                         children: [
  //                           Container(
  //                             width: double.infinity,
  //                             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
  //                             child: Text(type, style: TextStyle(fontSize: 13.sp)),
  //                           ),
  //                           if (index != _transactionTypeList.length - 1)
  //                             Divider(height: 1.h, thickness: 0.8, color: Colors.indigo.shade400),
  //                         ],
  //                       ),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void _onSelectedTRType(String selectedValue) {
  //      setState(() {
  //         _transactionType = selectedValue;
  //         if (selectedValue == "Receive") {
  //           getTransactionType = "CR";
  //         }
  //         if (selectedValue == "Payment") {
  //           getTransactionType = "CP";
  //         }
  //   });
  // }

  bool isBankListClicked = false;
  String? getPaymentType;
  String? _paymentType = 'Cash';
  final List<String> _paymentTypeList = [
    'Cash',
    'Bank',
  ];

final LayerLink _pTypeLayerLink = LayerLink();
  OverlayEntry? _pTypeOverlayEntry;

  final GlobalKey _pkey = GlobalKey();
  Size _pTypeDropdownSize = Size.zero;

  void _getPTypeDropdownSize(Duration _) {
    final RenderBox renderBox = _pkey.currentContext?.findRenderObject() as RenderBox;
    _pTypeDropdownSize = renderBox.size;
  }

  void _togglePTypeDropdown() {
    if (_isDropdownOpen) {
      _removePTypeDropdown();
    } else {
      _showPTypeDropdown();
    }
  }

  void _showPTypeDropdown() {
    _pTypeOverlayEntry = _createPTypeOverlayEntry();
    Overlay.of(context).insert(_pTypeOverlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removePTypeDropdown() {
    _pTypeOverlayEntry?.remove();
    _pTypeOverlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createPTypeOverlayEntry() {
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removePTypeDropdown,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: _pTypeDropdownSize.width,
              child: CompositedTransformFollower(
                link: _pTypeLayerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, _pTypeDropdownSize.height + 2),
                child: Material(
                  elevation: 9.0,
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(5.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _paymentTypeList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final type = entry.value;
                      return InkWell(
                        onTap: () {
                          _onSelectedPType(type);
                          _removePTypeDropdown();
                        },
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              child: Text(type, style: TextStyle(fontSize: 13.sp)),
                            ),
                            if (index != _paymentTypeList.length - 1)
                              Divider(height: 1.h, thickness: 0.8, color: Colors.indigo.shade400),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectedPType(String selectValue) {
     setState(() {
      _paymentType = selectValue;
      if (selectValue == "Cash") {
        getPaymentType = "cash";
      }
      if (selectValue == "Bank") {
        getPaymentType = "bank";
      }
      _paymentType == "Bank" ? isBankListClicked = true : isBankListClicked = false;
     });
  }


 
  // String? _selectedBankAccount;
  // String? _selectedSupplier;
  // final int _itemsPerPage = 2;
  // int _currentPage = 1;
  // List<dynamic> _getPaginatedData(List<dynamic> allGetSupplierPaymentData) {
  //   int startIndex = (_currentPage - 1) * _itemsPerPage;
  //   int endIndex = startIndex + _itemsPerPage;
  //   return allGetSupplierPaymentData.sublist(
  //     startIndex,
  //     endIndex > allGetSupplierPaymentData.length ? allGetSupplierPaymentData.length : endIndex,
  //   );
  // }
  // int? decimal = 0;
  // String? role = "";
  // List<String> actionList = [];
  // SharedPreferences? sharedPreferences;
  // Future<void> _initializeData() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   decimal = int.parse("${sharedPreferences?.getString('decimal')}");
  //   role = "${sharedPreferences?.getString('role')}";
  //   var action = "${sharedPreferences?.getString('action')}";
  //   actionList = action.split(",");
  //   print("Action=====  $actionList");
  //   print("role=====  $role");
  // }

  
  @override
  void initState() {
    //WidgetsBinding.instance.addPostFrameCallback(_getTrTypeDropdownSize);
    WidgetsBinding.instance.addPostFrameCallback(_getPTypeDropdownSize);
    // _initializeData();
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    //getTransactionType = 'CP';
    getPaymentType = "cash";
    // SupplierPaymentProvider.isSupplierPaymentLoading = true;
    // Provider.of<SupplierPaymentProvider>(context,listen: false).supplierPaymentList = [];
    // Provider.of<SupplierDueProvider>(context,listen: false).getSupplierDue(context, "","");
    // Provider.of<SupplierPaymentProvider>(context,listen: false).getSupplierPayment("",Utils.formatBackEndDate(DateTime.now()),"${Utils.formatBackEndDate(DateTime.now())}");
    // Provider.of<BankAccountProvider>(context,listen: false).getBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // /// Suppliers due $ Supplier list
    // final allSuppliersData = Provider.of<SupplierDueProvider>(context).supplierDuelist;
    // ///Get Supplier Payment
    // final allGetSupplierPaymentData = Provider.of<SupplierPaymentProvider>(context).supplierPaymentList;
    // int totalPages = allGetSupplierPaymentData.length <= _itemsPerPage ? 1 : (allGetSupplierPaymentData.length / _itemsPerPage).ceil();
    // int displayPageCount = totalPages > 20 ? 20 : totalPages;
    // ///bank account
    // final allBankAccountList = Provider.of<BankAccountProvider>(context).bankAccountList;
    return
    //  RefreshIndicator(
    //   onRefresh: () async {
    //     SupplierPaymentProvider.isSupplierPaymentLoading = true;
    //     await Provider.of<SupplierDueProvider>(context,listen: false).getSupplierDue(context, "","");
    //     await Provider.of<SupplierPaymentProvider>(context,listen: false).getSupplierPayment("",Utils.formatBackEndDate(DateTime.now()),Utils.formatBackEndDate(DateTime.now()));
    //     await Provider.of<BankAccountProvider>(context,listen: false).getBankAccount();
    //   },
    //   child:
       Scaffold(
         appBar:AppBar(
          backgroundColor: ColorManager.appbarColor,
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Patient Payment",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color.fromARGB(255,7,125,180),width: 1.w),
                      boxShadow: [
                        // ignore: deprecated_member_use
                        BoxShadow(color: Colors.grey.withOpacity(0.6),spreadRadius: 2.r,blurRadius: 5.r,offset: Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.h,
                          width: double.infinity,
                          child: Card(
                            margin: EdgeInsets.only(bottom:3.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r),topRight: Radius.circular(6.r)),
                                color: Color.fromARGB(255, 0, 64, 160),
                              ),
                              child: Center(child: Text('Patient Payment Information',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 16.sp, color: Colors.white))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4.w, right: 4.w,bottom: 4.h),
                          child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(flex: 6,child:Text("Payment Date",style:AllTextStyle.textFieldHeadStyle)),
                                    const Expanded(flex: 1, child: Text(":")),
                                    Expanded(
                                      flex: 11,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 3.h,bottom: 3.h),
                                        height: 25.h,
                                        decoration: ContDecoration.contDecoration,
                                        child: 
                                        //role == "Superadmin" || role == "admin" ? 
                                        GestureDetector(
                                          onTap: (() {
                                            _firstSelectedDate();
                                            FocusScope.of(context).requestFocus(quantityFocusNode);
                                          }),
                                          child: TextFormField(
                                            enabled: false,
                                            decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                                suffixIcon: Padding(padding: EdgeInsets.only(left: 20.w),
                                                  child: Icon(Icons.calendar_month, color: Colors.black87, size: 16.r)),
                                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                                hintText: firstPickedDate, hintStyle:AllTextStyle.dropDownlistStyle
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return null;
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                        // :GestureDetector(
                                        //   onTap: (() {
                                        //     // _firstSelectedDate();
                                        //     // FocusScope.of(context).requestFocus(quantityFocusNode);
                                        //   }),
                                        //   child: TextFormField(
                                        //     enabled: false,
                                        //     decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                        //         // suffixIcon: const Padding(padding: EdgeInsets.only(left: 20),
                                        //         //   child: Icon(Icons.calendar_month, color: Colors.black87, size: 16)),
                                        //         border: const OutlineInputBorder(borderSide: BorderSide.none),
                                        //         hintText: firstPickedDate, hintStyle:AllTextStyle.dropDownlistStyle
                                        //     ),
                                        //     validator: (value) {
                                        //       if (value == null || value.isEmpty) {
                                        //         return null;
                                        //       }
                                        //       return null;
                                        //     },
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                               Row(
                                children: [
                                  Expanded(flex: 6, child: Text("Payment Type",style: AllTextStyle.textFieldHeadStyle)),
                                  const Expanded(flex: 1, child: Text(":")),
                                  Expanded(
                                  flex: 11,
                                  child: CompositedTransformTarget(
                                    link: _pTypeLayerLink,
                                    child: GestureDetector(
                                    onTap: _togglePTypeDropdown,
                                    child: Container(
                                    key: _pkey,
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    height: 25.h,
                                    decoration: ContDecoration.contDecoration,
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                              _paymentType!,
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            GestureDetector(
                              onTap: _togglePTypeDropdown,
                              child: Icon(
                                color: Colors.grey.shade700,
                                _isDropdownOpen
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                                 ],
                                ),
                                SizedBox(height: 3.h),
                                isBankListClicked == true
                                 ? Row(
                                   children: [
                                     Expanded(flex: 6,child: Text("Bank account",style: AllTextStyle.textFieldHeadStyle)),
                                     const Expanded(flex: 1, child: Text(":")),
                                     Expanded(
                                       flex: 11,
                                       child: Container(
                                         height: 25.h,
                                         width: MediaQuery.of(context).size.width / 2,
                                         margin: EdgeInsets.only(bottom: 3.h),
                                         decoration: ContDecoration.contDecoration,
                                          // child: TypeAheadField<BankAccountModel>(
                                          // controller: bankAccountController,
                                          // builder: (context, controller, focusNode) {
                                          // return TextField(
                                          // controller: controller,
                                          // focusNode: focusNode,
                                          // style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                          // decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                          //   isDense: true,
                                          //   hintText: 'Select Account',
                                          //   hintStyle: TextStyle(fontSize: 13),
                                          //   suffixIcon: _selectedBankAccount == '' || _selectedBankAccount == 'null' || _selectedBankAccount == null || controller.text == '' ? null
                                          //       : GestureDetector(
                                          //     onTap: () {
                                          //       setState(() {
                                          //         bankAccountController.clear();
                                          //         controller.clear();
                                          //         _selectedBankAccount = null;
                                          //       });
                                          //     },
                                          //     child: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.close, size: 16)),
                                          //   ),
                                          //   suffixIconConstraints: BoxConstraints(maxHeight: 30),
                                          //   filled: false,
                                          //   fillColor: Colors.white,
                                          //   border: InputBorder.none,
                                          // ),
                                          // );
                                          // },
                                          // suggestionsCallback: (pattern) async {
                                          // return Future.delayed(const Duration(seconds: 1), () {
                                          //   return allBankAccountList
                                          //   .where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()))
                                          //   .toList().cast<BankAccountModel>(); 
                                          //   });
                                          //   },                    
                                          // itemBuilder: (context, BankAccountModel suggestion) {
                                          //   return Padding(
                                          // padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                                          // child: Text("${suggestion.name} - ${suggestion.number} (${suggestion.bankName})",
                                          //   style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                          // ),
                                          // );
                                          // },
                                          // onSelected: (BankAccountModel suggestion) {
                                          // setState(() {
                                          //   bankAccountController.text = "${suggestion.name} - ${suggestion.number} (${suggestion.bankName})";
                                          //   _selectedBankAccount = suggestion.id.toString();
                                          // });  
                                          // },
                                          // ),
                                       ),
                                     ),
                                   ],
                                 ): Container(),
                          
                                Row(
                                  children: [
                                    Expanded(flex: 6, child: Text("Patient",style: AllTextStyle.textFieldHeadStyle)),
                                    const Expanded(flex: 1, child: Text(":")),
                                    Expanded(
                                      flex: 11,
                                      child: Container(
                                        height: 25.h,
                                        width: MediaQuery.of(context).size.width / 2,
                                        decoration: ContDecoration.contDecoration,
                                      //     child: TypeAheadField<SupplierDueModel>(
                                      //     controller: patientController,
                                      //     builder: (context, controller, focusNode) {
                                      //     return TextField(
                                      //       controller: controller,
                                      //       focusNode: focusNode,
                                      //       style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                      //       decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                      //         isDense: true,
                                      //         hintText: 'Select Supplier',
                                      //         hintStyle: TextStyle(fontSize: 13),
                                      //         suffixIcon: _selectedSupplier == '' || _selectedSupplier == 'null' || _selectedSupplier == null || controller.text == '' ? null
                                      //             : GestureDetector(
                                      //           onTap: () {
                                      //             setState(() {
                                      //               supplierController.clear();
                                      //               controller.clear();
                                      //               _selectedSupplier = null;
                                      //               previousDueController.clear();
                                      //             });
                                      //           },
                                      //           child: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.close, size: 16)),
                                      //         ),
                                      //         suffixIconConstraints: BoxConstraints(maxHeight: 30),
                                      //         filled: false,
                                      //         fillColor: Colors.white,
                                      //         border: InputBorder.none,
                                      //       ),
                                      //     );
                                      //   },
                                      //   suggestionsCallback: (pattern) async {
                                      //     return Future.delayed(const Duration(seconds: 1), () {
                                      //   return allSuppliersData
                                      //     .where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()))
                                      //   .toList().cast<SupplierDueModel>(); 
                                      //     });
                                      //     },
                                      
                                      //   itemBuilder: (context, SupplierDueModel suggestion) {
                                      //     return Padding(
                                      //       padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 4.h),
                                      //       child: Text("${suggestion.name} ${suggestion.code != "" ? " - ${suggestion.code}" : ""} ${suggestion.phone != "" ? " - ${suggestion.phone}" : ""}",
                                      //         style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                      //       ),
                                      //     );
                                      //   },
                                      //   onSelected: (SupplierDueModel suggestion) {
                                      //         supplierController.text = "${suggestion.name} ${suggestion.code != "" ? " - ${suggestion.code}" : ""} ${suggestion.phone != "" ? " - ${suggestion.phone}" : ""}";
                                      //           setState(() {
                                      //             _selectedSupplier = suggestion.id.toString();
                                      //             previousDueController.text = suggestion.due;
                                      //           });
                                      //   },
                                      // ),
                                     
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Expanded(flex: 6,child: Text("Due Amount",style: AllTextStyle.textFieldHeadStyle)),
                                    const Expanded(flex: 1, child: Text(":")),
                                    Expanded(
                                      flex: 11,
                                      child: Container(
                                        height: 25.h,
                                        width: MediaQuery.of(context).size.width / 2,
                                         decoration: ContDecoration.contDecoration,
                                        child: TextField(
                                          style: AllTextStyle.dropDownlistStyle,
                                          controller: previousDueController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            //filled: true,
                                            enabled: false,
                                            hintText: "0",
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                            border: InputBorder.none,
                                            focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                            enabledBorder: TextFieldInputBorder.focusEnabledBorder
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Expanded(flex: 6,child:Text("Amount",style: AllTextStyle.textFieldHeadStyle)),
                                    const Expanded(flex: 1, child: Text(":")),
                                    Expanded(
                                      flex: 11,
                                      child: SizedBox(
                                        height: 25.h,
                                        width: MediaQuery.of(context).size.width / 2,
                                        child: TextField(
                                          style: AllTextStyle.dropDownlistStyle,
                                          controller: _amountController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                                            filled: true,
                                            hintText: "0",
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                            enabledBorder: TextFieldInputBorder.focusEnabledBorder
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Expanded(flex: 6,child:Text("Description",style:AllTextStyle.textFieldHeadStyle)),
                                    const Expanded(flex: 1, child: Text(":")),
                                    Expanded(
                                      flex: 11,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child: TextField(
                                          style: AllTextStyle.dropDownlistStyle,
                                          maxLines: 2,
                                          controller: _descriptionController,
                                          decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                                            hintText: "Note",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                            enabledBorder: TextFieldInputBorder.focusEnabledBorder
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ///=====customer loading hide 
                                //HiddenItemsLoading(controller: quantityController,focusNode: quantityFocusNode),
                                SizedBox(height: 4.h),
                              //  ((role == 'Superadmin' || role == 'admin') || actionList.contains('e') == true) ? 
                               Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        emtyMethod();
                                        FocusScope.of(context).requestFocus(quantityFocusNode);
                                      },
                                      child: Container(
                                        height: 28.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 252, 33, 4),
                                          borderRadius: BorderRadius.circular(5.r),
                                          boxShadow: [
                                            BoxShadow(color: Colors.grey.withOpacity(0.6),spreadRadius: 2.r,blurRadius: 5.r,offset: const Offset(0, 3)),
                                          ],
                                        ),
                                        child: Center(child: Text("Clear",style:AllTextStyle.saveButtonTextStyle)),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    InkWell(
                                      onTap: () {
                                        // if(supplierController.text == ''){
                                        //   Utils.errorSnackBar(context, "Supplier is required");
                                        // }
                                        // else if (_paymentType == "Bank" && bankAccountController.text == '') {
                                        //   Utils.errorSnackBar( context, "Bank account is required");
                                        // }
                                        // else if( _amountController.text == ''){
                                        //   Utils.errorSnackBar(context, "Amount is required");
                                        // }
                                        // else{
                                        //   setState(() {
                                        //     isBtnLoading = true;
                                        //   });
                                        //   getApiAllAddSupplierPayment(context,
                                        //     _amountController.text,
                                        //    _selectedBankAccount,
                                        //     backEndFirstDate,
                                        //     getPaymentType,
                                        //     _descriptionController.text,
                                        //     _selectedSupplier,
                                        //     getTransactionType,
                                        //   ).then((value){
                                        //     if(value=='true'){
                                        //       setState(() {
                                        //         isBtnLoading = false;
                                        //       });
                                        //       _descriptionController.text = "";
                                        //       supplierController.text = '';
                                        //       _amountController.text = "";
                                        //       Provider.of<SupplierPaymentProvider>(context,listen: false).getSupplierPayment("",Utils.formatBackEndDate(DateTime.now()),Utils.formatBackEndDate(DateTime.now()));
                                        //       Provider.of<SupplierDueProvider>(context,listen: false).getSupplierDue(context, "","");
                                        //       setState(() {
                                        //       });
                                        //     }
                                        //   });
                                        // }
                                      },
                                      child: Container(
                                        height: 28.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          color:Color.fromARGB(255, 0, 64, 160),
                                          borderRadius: BorderRadius.circular(5.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.6),
                                              spreadRadius: 2.r,
                                              blurRadius: 5.r,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                            child: isBtnLoading ? SizedBox(height: 20.h,width:20.w,child: CircularProgressIndicator(color: Colors.white,)) : Text(
                                                "Save",style:AllTextStyle.saveButtonTextStyle)),
                                      ),
                                    ),
                                  ],
                                )
                                //:SizedBox(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height/1.5,
                //   padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                //   child:SupplierPaymentProvider.isSupplierPaymentLoading ? const Center(child: CircularProgressIndicator()) : allGetSupplierPaymentData.isEmpty
                //       ? const Text("No Data Found",style: AllTextStyle.nofoundTextStyle)
                //       : Column(
                //     children: [
                //       Expanded(
                //         child: SingleChildScrollView(
                //           child: SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 DataTable(
                //                   headingRowHeight: 20.0,
                //                   // ignore: deprecated_member_use
                //                   dataRowHeight: 20.0,
                //                   headingRowColor: WidgetStateColor.resolveWith((states) => Colors.indigo),
                //                   border: TableBorder.all(color: Colors.black54, width: 1),
                //                   columns: const [
                //                     DataColumn(label:Expanded(child:Center(child:Text('Transaction Id',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Date',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Supplier',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Transaction Type',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Payment by',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Amount',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Description',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Added By',style:AllTextStyle.tableHeadTextStyle)))),
                //                     DataColumn(label:Expanded(child:Center(child:Text('Invoice',style:AllTextStyle.tableHeadTextStyle)))),
                //                   ],
                //                   rows: _getPaginatedData(allGetSupplierPaymentData).asMap().entries.map((entry) {
                //                     int index = entry.key;
                //                     var supplierPayment = entry.value;
                //                     return DataRow(
                //                       color: index % 2 == 0 ? WidgetStateProperty.resolveWith(getColors) : WidgetStateProperty.resolveWith(getColor),
                //                       cells: [
                //                         DataCell(Center(child:Text(supplierPayment.invoice))),
                //                         DataCell(Center(child:Text(supplierPayment.date))),
                //                         DataCell(Center(child:Text(supplierPayment.supplier!.name))),
                //                         DataCell(Center(child:Text(supplierPayment.type))),
                //                         DataCell(
                //                           Center(
                //                            child: Text(
                //                            supplierPayment.method == "bank" && supplierPayment.bankAccount != null
                //                            ? "${supplierPayment.method} - ${supplierPayment.bankAccount?.name ?? ''} - ${supplierPayment.bankAccount?.number ?? ''}"
                //                            : supplierPayment.method),
                //                          ),
                //                         ),
                //                         DataCell(Center(child:Text(double.parse(supplierPayment.amount).toStringAsFixed(decimal!)))),
                //                         DataCell(Center(child:Text(supplierPayment.note ?? ""))),
                //                         DataCell(Center(child:Text(supplierPayment.addBy!.name))),
                //                         DataCell(
                //                          GestureDetector(
                //                           onTap: () {
                //                             Navigator.of(context).push(MaterialPageRoute(
                //                               builder: (_) => SupplierPaymentInvoicePage(paymentId: "${supplierPayment.id}"), // <=== replace with your InvoicePage
                //                             ));
                //                           },
                //                           child: Center(
                //                             child: const Icon(Icons.collections_bookmark,size: 18)
                //                           ),
                //                         ),
                //                       ), 
                //                       ],
                //                     );
                //                   }).toList(),
                //                 ),
                //                 const SizedBox(height: 5.0),
                //                 if (totalPages > 1)
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       GestureDetector(
                //                         onTap: () {
                //                           setState(() {
                //                             _currentPage = 1;
                //                           });
                //                         },
                //                         child: paginationButton(1, _currentPage == 1),
                //                       ),
                //                       if (_currentPage > 3)
                //                         const Padding(
                //                           padding: EdgeInsets.symmetric(horizontal: 5.0),
                //                           child: Text("..."),
                //                         ),
                //                       for (int i = _currentPage - 1; i <= _currentPage + 1; i++)
                //                         if (i > 1 && i < displayPageCount)
                //                           GestureDetector(
                //                             onTap: () {
                //                               setState(() {
                //                                 _currentPage = i;
                //                               });
                //                             },
                //                             child: paginationButton(i, _currentPage == i),
                //                           ),
                //                       if (_currentPage < displayPageCount - 2)
                //                        Padding(
                //                           padding: EdgeInsets.symmetric(horizontal: 5.w),
                //                           child: Text("..."),
                //                         ),
                //                       GestureDetector(
                //                         onTap: () {
                //                           setState(() {
                //                             _currentPage = displayPageCount;
                //                           });
                //                         },
                //                         child: paginationButton(displayPageCount, _currentPage == displayPageCount),
                //                       ),
                //                     ],
                //                   ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      );
    //);
  }

  Widget paginationButton(int page, bool isSelected) {
    return Container(
      height: 25.h,
      width: 25.w,
      margin: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        color: isSelected ? Colors.indigo : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: isSelected ? Colors.blue.shade700 : Colors.grey),
      ),
      child: Center(
        child: Text(
          "$page",
          style: TextStyle(fontSize: 12.sp, color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  emtyMethod() {
    setState(() {
      _descriptionController.text = "";
      patientController.text = "";
      previousDueController.text = "";
      _amountController.text = "";
      bankAccountController.text = "";
    });
  }
  // Future<String>getApiAllAddSupplierPayment(context,
  //     String? amount,
  //      bankAccountId,
  //     String? date,
  //     String? method,
  //     String? note,
  //      supplierId,
  //     String? type,
  //     ) async {
        
  //   SharedPreferences? sharedPreferences;
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   String Link = "${sharedPreferences.getString("BaseUrl")}/create-supplierpayment";
  //   try {
  //     Response response = await Dio().post(Link,
  //         data: {
  //           "amount": amount,
  //           "bank_account_id": bankAccountId ?? "",
  //           "date": date,
  //           "method": method,
  //           "note": note,
  //           "supplier_id": supplierId,
  //           "type": type,
  //         },
  //         options: Options(headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer ${sharedPreferences.getString("token")}",
  //           "Cookie": "laravel_session=${sharedPreferences.getString('sessionId')}",
  //         }));
  //     var data = response.data;
  //     if(data['status'] == true){
  //       setState(() {
  //         isBtnLoading = false;
  //       });
  //       emtyMethod();
  //       CustomSnackBar.showTopSnackBar(context, "${data["message"]}");
  //       // ===== Success dialog =====
  //       showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: const Text("Success!",style: TextStyle(color: Color.fromARGB(255, 1, 126, 5),fontWeight: FontWeight.bold),),
  //         content: const Text( "Do you want to print invoice?"),
  //         actions: [
  //           GestureDetector(
  //             onTap: () => Navigator.of(ctx).pop(), 
  //             child: Container(
  //               height: 30, 
  //               width: 60,
  //               decoration: BoxDecoration(
  //                 color: const Color.fromARGB(255, 211, 15, 1),
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: Center(child: Text("No",style: AllTextStyle.saveButtonTextStyle))),
  //           ),
  //           GestureDetector(
  //             onTap: () {
  //               Navigator.of(ctx).pop(); 
  //               Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (_) => SupplierPaymentInvoicePage(paymentId: "${data["paymentId"]}"),
  //               ));
  //             }, 
  //             child: Container(
  //               height: 30, 
  //               width: 60,
  //                 decoration: BoxDecoration(
  //                 color: const Color.fromARGB(255, 44, 40, 248),
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: Center(child: Text("Yes",style: AllTextStyle.saveButtonTextStyle))),
  //           ),
  //         ],
  //       ),
  //       );
  //       return 'true';
  //     }else{
  //       setState(() {
  //         isBtnLoading = false;
  //       });
  //       Utils.errorSnackBar(context, "${data["message"]}");
  //       return '';
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isBtnLoading = false;
  //     });
  //     Utils.errorSnackBar(context, e.toString());
  //     return '';
  //   }
  // }
}
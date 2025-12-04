import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
class BankTransactionEntryScreen extends StatefulWidget {
  const BankTransactionEntryScreen({super.key});

  @override
  State<BankTransactionEntryScreen> createState() => _BankTransactionEntryScreenState();
}

class _BankTransactionEntryScreenState extends State<BankTransactionEntryScreen> {
  Color getColor(Set<WidgetState> states) {return Colors.blue.shade100;}
  Color getColors(Set<WidgetState> states) {return Colors.white;}

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  var quantityController = TextEditingController();
  ///new condition
  FocusNode quantityFocusNode = FocusNode();

  //String? _selectedAccount;
  String? currentBalance = "0";
  String? firstPickedDate;
  var backEndFirstDate;
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
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndFirstDate = Utils.formatBackEndDate(selectedDate);
        // BankTransactionProvider().on();
        // Provider.of<BankTransactionProvider>(
        //   context,
        //   listen: false,
        // ).getBankTransactionApi(
        //   "",
        //   "${backEndFirstDate}",
        //   "${backEndFirstDate}",
        //   "",
        // );
      });
    } else {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
      });
    }
  }

  bool _isDropdownOpen = false;
  String paymentType = "";
  String? _transactionType = 'Deposit';
   final List<String> _transactionTypeList = [
    'Deposit',
    'Withdraw',
  ];

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  final GlobalKey _key = GlobalKey();
  Size _dropdownSize = Size.zero;

  void _getDropdownSize(Duration _) {
    final RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    _dropdownSize = renderBox.size;
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removeDropdown,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: _dropdownSize.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, _dropdownSize.height + 0),
                child: Material(
                  elevation: 9.0,
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(5.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _transactionTypeList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final type = entry.value;
                      return InkWell(
                        onTap: () {
                          _onSelectedType(type);
                          _removeDropdown();
                        },
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              child: Text(type, style: TextStyle(fontSize: 13.sp)),
                            ),
                            if (index != _transactionTypeList.length - 1)
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

  void _onSelectedType(String selectedValue) {
       setState(() {
         _transactionType = selectedValue;
         if (selectedValue == "Deposit") {
            paymentType = "deposit";
          }
         if (selectedValue == "Withdraw") {
             paymentType = "withdraw";
           }
    });
  }
  
  bool isLoading = false;

  ScrollController mainScrollController = ScrollController();
  late final ScrollController _listViewScrollController =
      ScrollController()..addListener(listViewScrollListener);
  ScrollPhysics _physics = ScrollPhysics();

  void listViewScrollListener() {
    if (_listViewScrollController.offset >=
            _listViewScrollController.position.maxScrollExtent &&
        !_listViewScrollController.position.outOfRange) {
      if (mainScrollController.offset == 0) {
        mainScrollController.animateTo(
          50,
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      }
      setState(() {
        _physics = NeverScrollableScrollPhysics();
      });
    }
  }

  void mainScrollListener() {
    if (mainScrollController.offset <=
            mainScrollController.position.minScrollExtent &&
        !mainScrollController.position.outOfRange) {
      setState(() {
        if (_physics is NeverScrollableScrollPhysics) {
          _physics = ScrollPhysics();

          _listViewScrollController.animateTo(
            _listViewScrollController.position.maxScrollExtent - 50,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        }
      });
    }
  }
  // final int _itemsPerPage = 15;
  // int _currentPage = 1;
  // List<dynamic> _getPaginatedData(List<dynamic> allBankTransaction) {
  //   int startIndex = (_currentPage - 1) * _itemsPerPage;
  //   int endIndex = startIndex + _itemsPerPage;
  //   return allBankTransaction.sublist(
  //     startIndex,
  //     endIndex > allBankTransaction.length
  //         ? allBankTransaction.length
  //         : endIndex,
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
    WidgetsBinding.instance.addPostFrameCallback(_getDropdownSize);
    //_initializeData();
    paymentType = "deposit";
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    // BankTransactionProvider.isBankTransactionLoading = true;
    // Provider.of<BankTransactionProvider>(context, listen: false)
    //     .bankTransactionList = [];
    // Provider.of<BankTransactionProvider>(
    //   context,
    //   listen: false,
    // ).getBankTransactionApi(
    //   "",
    //   "${Utils.formatBackEndDate(DateTime.now())}",
    //   "${Utils.formatBackEndDate(DateTime.now())}",
    //   "",
    // );
    // Provider.of<BankAccountProvider>(context, listen: false).getBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainScrollController.addListener(mainScrollListener);
    // final allBankTransaction = Provider.of<BankTransactionProvider>(context).bankTransactionList;
    // int totalPages = allBankTransaction.length <= _itemsPerPage
    //         ? 1 : (allBankTransaction.length / _itemsPerPage).ceil();
    // int displayPageCount = totalPages > 20 ? 20 : totalPages;

    // ///bank account
    // final allBankAccountList = Provider.of<BankAccountProvider>(context).bankAccountList;
    return 
    // RefreshIndicator(
    //   onRefresh: () async {
    //     BankTransactionProvider.isBankTransactionLoading = true;
    //     await Provider.of<BankTransactionProvider>(
    //       context,
    //       listen: false,
    //     ).getBankTransactionApi(
    //       "",
    //       "${Utils.formatBackEndDate(DateTime.now())}",
    //       "${Utils.formatBackEndDate(DateTime.now())}",
    //       "",
    //     );
    //     await Provider.of<BankAccountProvider>(
    //       context,
    //       listen: false,
    //     ).getBankAccount();
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
            "Bank Transaction Entry",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            controller: mainScrollController,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Color.fromARGB(255, 7, 25, 180),
                        width: 1.w,
                      ),
                      boxShadow: [
                        // ignore: deprecated_member_use
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2.r,
                          blurRadius: 5.r,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                "Tr. Date",
                                style: AllTextStyle.textFieldHeadStyle,
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 4.h),
                                height: 25.h,
                                decoration: ContDecoration.contDecoration,
                                child: 
                               // role == "Superadmin" || role == "admin" ? 
                                GestureDetector(
                                  onTap: (() {
                                    FocusScope.of(context).requestFocus(quantityFocusNode);
                                    _firstSelectedDate();
                                  }),
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5.w),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20.r),
                                        child: Icon(
                                          Icons.calendar_month,
                                          color: Colors.black87,
                                          size: 16.r,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: firstPickedDate,
                                      hintStyle: AllTextStyle.dateFormatStyle,
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
                                //     // FocusScope.of(context).requestFocus(quantityFocusNode);
                                //     // _firstSelectedDate();
                                //   }),
                                //   child: TextFormField(
                                //     enabled: false,
                                //     decoration: InputDecoration(
                                //       contentPadding: const EdgeInsets.only(
                                //         left: 5,
                                //       ),
                                //       // suffixIcon: const Padding(
                                //       //   padding: EdgeInsets.only(left: 20.0),
                                //       //   child: Icon(
                                //       //     Icons.calendar_month,
                                //       //     color: Colors.black87,
                                //       //     size: 16,
                                //       //   ),
                                //       // ),
                                //       border: const OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //       ),
                                //       hintText: firstPickedDate,
                                //       hintStyle: AllTextStyle.dateFormatStyle,
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
                            Expanded(
                              flex: 6,
                              child: Text(
                                "Account",
                                style: AllTextStyle.textFieldHeadStyle,
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: Container(
                                height: 25.h,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: ContDecoration.contDecoration,
                                // child: TypeAheadField<BankAccountModel>(
                                //   controller: accountController,
                                //   builder: (context, controller, focusNode) {
                                //     return TextField(
                                //       controller: controller,
                                //       focusNode: focusNode,
                                //       style: TextStyle(
                                //         fontSize: 13,
                                //         color: Colors.grey.shade800,
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //       decoration: InputDecoration(
                                //         contentPadding: EdgeInsets.only(
                                //           left: 5.0,
                                //           top: 4.0,
                                //         ),
                                //         isDense: true,
                                //         hintText: 'Select Account',
                                //         hintStyle: TextStyle(fontSize: 13),
                                //         suffixIcon:
                                //             _selectedAccount == '' ||
                                //                     _selectedAccount ==
                                //                         'null' ||
                                //                     _selectedAccount == null ||
                                //                     controller.text == ''
                                //                 ? null
                                //                 : GestureDetector(
                                //                   onTap: () {
                                //                     setState(() {
                                //                       accountController.clear();
                                //                       controller.clear();
                                //                       _selectedAccount = null;
                                //                     });
                                //                   },
                                //                   child: Padding(
                                //                     padding: EdgeInsets.all(5),
                                //                     child: Icon(
                                //                       Icons.close,
                                //                       size: 16,
                                //                     ),
                                //                   ),
                                //                 ),
                                //         suffixIconConstraints: BoxConstraints(
                                //           maxHeight: 30,
                                //         ),
                                //         filled: false,
                                //         fillColor: Colors.white,
                                //         border: InputBorder.none,
                                //       ),
                                //     );
                                //   },
                                //   suggestionsCallback: (pattern) async {
                                //     return Future.delayed(
                                //       const Duration(seconds: 1),
                                //       () {
                                //         return allBankAccountList
                                //             .where(
                                //               (element) => element.name
                                //                   .toLowerCase()
                                //                   .contains(
                                //                     pattern.toLowerCase(),
                                //                   ),
                                //             )
                                //             .toList()
                                //             .cast<BankAccountModel>();
                                //       },
                                //     );
                                //   },

                                //   itemBuilder: (
                                //     context,
                                //     BankAccountModel suggestion,
                                //   ) {
                                //     return Padding(
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 6,
                                //         vertical: 4,
                                //       ),
                                //       child: Text(
                                //         "${suggestion.name}-${suggestion.number} (${suggestion.bankName})",
                                //         style: TextStyle(fontSize: 12),
                                //         maxLines: 1,
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     );
                                //   },
                                //   onSelected: (BankAccountModel suggestion) {
                                //     setState(() {
                                //       accountController.text =
                                //           "${suggestion.name}-${suggestion.number} (${suggestion.bankName})";
                                //       _selectedAccount =
                                //           suggestion.id.toString();
                                //       currentBalance = suggestion.balance;
                                //     });
                                //   },
                                // ),
                             
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                "Tr. Type",
                                style: AllTextStyle.textFieldHeadStyle,
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: CompositedTransformTarget(
                                link: _layerLink,
                                child: GestureDetector(
                                onTap: _toggleDropdown,
                                child: Container(
                                key: _key,
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                height: 25.h,
                                decoration: ContDecoration.contDecoration,
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(
                          _transactionType!,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        GestureDetector(
                          onTap: _toggleDropdown,
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
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                "Amount",
                                style: AllTextStyle.textFieldHeadStyle,
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: SizedBox(
                                height: 25.h,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextField(
                                  style: TextStyle(fontSize: 13.sp),
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
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
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                "Note",
                                style: AllTextStyle.textFieldHeadStyle,
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: TextField(
                                style: TextStyle(fontSize: 13.sp),
                                controller: _noteController,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
                                  hintText: "Remarks",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder:TextFieldInputBorder.focusEnabledBorder,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ///=====customer loading hide 
                      ///HiddenItemsLoading(controller: quantityController,focusNode: quantityFocusNode),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Row(
                            //   children: [
                            //     const Text("Current Balance    :  "),
                            //     Text("$currentBalance"),
                            //   ],
                            // ),
                            // ((role == 'Superadmin' || role == 'admin') || actionList.contains('e') == true) ?
                             InkWell(
                              onTap: () {
                                // Utils.closeKeyBoard(context);
                                // if (accountController.text == '') {
                                //   Utils.errorSnackBar(
                                //     context,
                                //     "Account field is required",
                                //   );
                                // } else if (_amountController.text == "") {
                                //   Utils.errorSnackBar(
                                //     context,
                                //     "Amount field is required",
                                //   );
                                // } else {
                                //   setState(() {
                                //     isLoading = true;
                                //   });
                                //   fetchAddBankTransactions(
                                //     context,
                                //     _amountController.text,
                                //     int.parse("$_selectedAccount"),
                                //     "$backEndFirstDate",
                                //     _noteController.text,
                                //     "$paymentType",
                                //   ).then((value) {
                                //     if (value != "") {
                                //       setState(() {
                                //         isLoading = false;
                                //       });
                                //       Provider.of<BankTransactionProvider>(
                                //         context,
                                //         listen: false,
                                //       ).getBankTransactionApi(
                                //         "",
                                //         "${Utils.formatBackEndDate(DateTime.now())}",
                                //         "${Utils.formatBackEndDate(DateTime.now())}",
                                //         "",
                                //       );
                                //       emtyMethod();
                                //       setState(() {});
                                //     }
                                //   });
                                // }
                              },
                              child: Container(
                                height: 25.0.h,
                                width: 100.0.w,
                                decoration: BoxDecoration(
                                  color:Colors.indigo,
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: [
                                    // ignore: deprecated_member_use
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 2.r,
                                      blurRadius: 5.r,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child:
                                      isLoading
                                          ? SizedBox(
                                            height: 20.h,
                                            width: 20.w,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                          : Text(
                                            "Save",
                                            style:
                                                AllTextStyle
                                                    .saveButtonTextStyle,
                                          ),
                                ),
                              ),
                            )
                            // :SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 5.0),
                // Container(
                //   height: MediaQuery.of(context).size.height / 1.5,
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 5.0,
                //     vertical: 5.0,
                //   ),
                //   child:
                //       BankTransactionProvider.isBankTransactionLoading
                //           ? const Center(child: CircularProgressIndicator())
                //           : allBankTransaction.isEmpty
                //           ? const Text(
                //             "No Data Found",
                //             style: AllTextStyle.nofoundTextStyle,
                //           )
                //           : Column(
                //             children: [
                //               Expanded(
                //                 child: SingleChildScrollView(
                //                   child: SingleChildScrollView(
                //                     scrollDirection: Axis.horizontal,
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         DataTable(
                //                           headingRowHeight: 20.0,
                //                           // ignore: deprecated_member_use
                //                           dataRowHeight: 20.0,
                //                           headingRowColor:WidgetStateColor.resolveWith((states) => Colors.indigo),
                //                           border: TableBorder.all(color: Colors.black54,width: 1),
                //                           columns: const [
                //                             DataColumn(label: Expanded(child: Center(child: Text('Transaction Date',style:AllTextStyle.tableHeadTextStyle)))),
                //                             DataColumn(label: Expanded(child: Center(child: Text('Account Name',style:AllTextStyle.tableHeadTextStyle)))),
                //                             DataColumn(label: Expanded(child: Center(child: Text('Account Number',style: AllTextStyle.tableHeadTextStyle)))),
                //                             DataColumn(label: Expanded(child: Center(child: Text('Bank Name',style: AllTextStyle.tableHeadTextStyle)))),
                //                             DataColumn(label: Expanded(child: Center(child: Text('Transaction Type',style: AllTextStyle.tableHeadTextStyle)))),
                //                             DataColumn(label: Expanded(child: Center(child: Text('Note', style:AllTextStyle.tableHeadTextStyle)))),
                //                             DataColumn(label: Expanded(child: Center(child: Text('Amount',style: AllTextStyle.tableHeadTextStyle)))),
                //                             DataColumn(label: Expanded(child: Center(child: Text('Saved By',style: AllTextStyle.tableHeadTextStyle)))),
                //                           ],
                //                           rows: _getPaginatedData(allBankTransaction,).asMap().entries.map((entry) {
                //                                 int index = entry.key;
                //                                 var bankTransaction = entry.value;
                //                                 return DataRow(
                //                                   color: index % 2 == 0 ? WidgetStateProperty.resolveWith(getColors) : WidgetStateProperty.resolveWith(getColor),
                //                                   cells: [
                //                                     DataCell(Center(child: Text(bankTransaction.date))),
                //                                     DataCell(Center(child: Text(bankTransaction.bankAccount!.name))),
                //                                     DataCell(Center(child: Text(bankTransaction.bankAccount!.number))),
                //                                     DataCell(Center(child: Text(bankTransaction.bankAccount!.bankName))),
                //                                     DataCell(Center(child: Text(bankTransaction.type))),
                //                                     DataCell(Center(child: Text(bankTransaction.note ??""))),
                //                                     DataCell(Center(child: Text(double.parse(bankTransaction.amount).toStringAsFixed(decimal!)))),
                //                                     DataCell(Center(child: Text(bankTransaction.addBy!.name))),
                //                                   ],
                //                                 );
                //                               }).toList(),
                //                         ),
                //                         const SizedBox(height: 5.0),
                //                         if (totalPages > 1)
                //                           Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             children: [
                //                               GestureDetector(
                //                                 onTap: () {
                //                                   setState(() {
                //                                     _currentPage = 1;
                //                                   });
                //                                 },
                //                                 child: paginationButton(
                //                                   1,
                //                                   _currentPage == 1,
                //                                 ),
                //                               ),
                //                               if (_currentPage > 3)
                //                                 const Padding(
                //                                   padding: EdgeInsets.symmetric(
                //                                     horizontal: 5.0,
                //                                   ),
                //                                   child: Text("..."),
                //                                 ),
                //                               for (
                //                                 int i = _currentPage - 1;
                //                                 i <= _currentPage + 1;
                //                                 i++
                //                               )
                //                                 if (i > 1 &&
                //                                     i < displayPageCount)
                //                                   GestureDetector(
                //                                     onTap: () {
                //                                       setState(() {
                //                                         _currentPage = i;
                //                                       });
                //                                     },
                //                                     child: paginationButton(
                //                                       i,
                //                                       _currentPage == i,
                //                                     ),
                //                                   ),
                //                               if (_currentPage <
                //                                   displayPageCount - 2)
                //                                 const Padding(
                //                                   padding: EdgeInsets.symmetric(
                //                                     horizontal: 5.0,
                //                                   ),
                //                                   child: Text("..."),
                //                                 ),
                //                               GestureDetector(
                //                                 onTap: () {
                //                                   setState(() {
                //                                     _currentPage =
                //                                         displayPageCount;
                //                                   });
                //                                 },
                //                                 child: paginationButton(
                //                                   displayPageCount,
                //                                   _currentPage ==
                //                                       displayPageCount,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                // ),
                // const SizedBox(height: 15.0),
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
        border: Border.all(
          color: isSelected ? Colors.blue.shade700 : Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          "$page",
          style: TextStyle(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  emtyMethod() {
    setState(() {
      _amountController.text = '';
      accountController.text = '';
      _noteController.text = '';
      currentBalance = "0";
    });
  }

  // Future<String> fetchAddBankTransactions(
  //   context,
  //   String? amount,
  //   int? bankAccountId,
  //   String? date,
  //   String? note,
  //   String? type,
  // ) async {
  //   SharedPreferences? sharedPreferences;
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   String Link = "${sharedPreferences.getString("BaseUrl")}/create-banktransaction";
  //   try {
  //     Response response = await Dio().post(
  //       Link,
  //       data: {
  //         "amount": "$amount",
  //         "bank_account_id": bankAccountId,
  //         "date": "$date",
  //         "note": "$note",
  //         "type": "$type",
  //       },
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer ${sharedPreferences.getString("token")}",
  //           "Cookie": "laravel_session=${sharedPreferences.getString('sessionId')}",
  //         },
  //       ),
  //     );
  //     var data = response.data;
  //     if (data['status'] == true) {
  //       CustomSnackBar.showTopSnackBar(context, "${data["message"]}");
  //       return "true";
  //     } else {
  //       Utils.errorSnackBar(context, "${data["message"]}");
  //       return "";
  //     }
  //   } catch (e) {
  //     Utils.errorSnackBar(context, e.toString());
  //     return "";
  //   }
  // }
}
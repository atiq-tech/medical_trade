import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/models/accounts_model.dart';
import 'package:medical_trade/diagnostic_module/models/bank_account_model.dart';
import 'package:medical_trade/diagnostic_module/providers/accounts_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/bank_account_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/cash_transaction_provider.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/animation_snackbar.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:provider/provider.dart';

class CashTransactionEntryScreen extends StatefulWidget {
  const CashTransactionEntryScreen({super.key});
  @override
  State<CashTransactionEntryScreen> createState() => _CashTransactionEntryScreenState();
}

class _CashTransactionEntryScreenState extends State<CashTransactionEntryScreen> {
  Color getColor(Set<WidgetState> states) {return Colors.blue.shade100;}
  Color getColors(Set<WidgetState> states) {return Colors.white;}

  final _DescriptionController = TextEditingController();
  final _AmountController = TextEditingController();
  final tnxIdNoController = TextEditingController();
  var quantityController = TextEditingController();
  final bankAccountController = TextEditingController();
  final accountsController = TextEditingController();
  
  ///new condition
  FocusNode quantityFocusNode = FocusNode();

  bool _isDropdownOpen = false;
  String? paymentType;
  String? _selectedType = 'Payment';
  final List<String> _selectedTypeList = [
    'Received',
    'Payment',
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
                    children: _selectedTypeList.asMap().entries.map((entry) {
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
                            if (index != _selectedTypeList.length - 1)
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
         _selectedType = selectedValue;
       if (selectedValue == "Received") {
          paymentType = "Received";
        }
       if (selectedValue == "Payment") {
          paymentType = "Payment";
        }
    });
    print("paymentType========$paymentType");
  }


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
        getPaymentType = "Cash";
      }
      if (selectValue == "Bank") {
        getPaymentType = "Bank";
      }
      _paymentType == "Bank" ? isBankListClicked = true : isBankListClicked = false;
     });
  }


  String? _selectedBankAccount;
  String? accountsID;
  String? firstPickedDate;
  var backEndFirstDate;
  var toDay = DateTime.now();

  void firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndFirstDate = Utils.formatBackEndDate(selectedDate);
        CashTransactionProvider.isCashTransactionLoading = true;
        Provider.of<CashTransactionProvider>(context, listen: false).getCashTransaction("$backEndFirstDate","$backEndFirstDate");
      
      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
      });
    }
  }

  // final int _itemsPerPage = 15;
  // int _currentPage = 1;
  // List<dynamic> _getPaginatedData(List<dynamic> allCashTransaction) {
  //   int startIndex = (_currentPage - 1) * _itemsPerPage;
  //   int endIndex = startIndex + _itemsPerPage;
  //   return allCashTransaction.sublist(
  //     startIndex,
  //     endIndex > allCashTransaction.length ? allCashTransaction.length : endIndex,
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

  static String getToken() {
  final box = GetStorage();
  return box.read('loginToken') ?? "";
}

String? cashTrCode = "";
getCashTrCode() async {
  try {
    String link = AppUrl.getCashTrCodeEndPoint;
    final token = getToken();

    var response = await Dio().get(link,
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
      cashTrCode = response.data["data"].toString();
    });
    print("cashTrCode =========> $cashTrCode");

  } catch (e) {
    print("cashTrCode ERROR =======> $e");
  }
}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getDropdownSize);
    WidgetsBinding.instance.addPostFrameCallback(_getPTypeDropdownSize);
    //_initializeData();
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    paymentType = "Payment";
    getPaymentType = "Cash";
    getCashTrCode();
    // getCashTransactionId();
    // // ACCOUNTS
    CashTransactionProvider.isCashTransactionLoading = true;
    Provider.of<CashTransactionProvider>(context, listen: false).cashTransactionList = [];
    Provider.of<AccountsProvider>(context, listen: false).getAccounts();
    Provider.of<BankAccountProvider>(context, listen: false).getBankAccount();
    Provider.of<CashTransactionProvider>(context, listen: false).getCashTransaction(Utils.formatBackEndDate(DateTime.now()),Utils.formatBackEndDate(DateTime.now()));
    super.initState();
  }

  bool isLoading = false;

  ScrollController mainScrollController = ScrollController();
  late final ScrollController _listViewScrollController = ScrollController()
    ..addListener(listViewScrollListener);
  ScrollPhysics _physics = ScrollPhysics();
  void listViewScrollListener() {
    if (_listViewScrollController.offset >=
        _listViewScrollController.position.maxScrollExtent &&
        !_listViewScrollController.position.outOfRange) {
      if (mainScrollController.offset == 0) {
        mainScrollController.animateTo(50,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
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
              curve: Curves.linear);
        }
      });
    }
  }
  //final  _accountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    mainScrollController.addListener(mainScrollListener);
    // ///Get Cash Transaction
    // final allCashTransaction = Provider.of<CashTransactionProvider>(context).cashTransactionList;
    // int totalPages = allCashTransaction.length <= _itemsPerPage ? 1 : (allCashTransaction.length / _itemsPerPage).ceil();
    // int displayPageCount = totalPages > 20 ? 20 : totalPages;
    // /// account
    final allBankAccountList = Provider.of<BankAccountProvider>(context).allBankAccountList;
    final allAccountData = Provider.of<AccountsProvider>(context).accountsList;
    final allCashTransactionData = Provider.of<CashTransactionProvider>(context).cashTransactionList;
    
    return 
    //RefreshIndicator(
      // onRefresh: () async {
      //   CashTransactionProvider.isCashTransactionLoading = true;
      //   await Provider.of<AccountProvider>(context, listen: false).getAccountList();
      //   await Provider.of<CashTransactionProvider>(context, listen: false).getCashTransactionApi("",Utils.formatBackEndDate(DateTime.now()),Utils.formatBackEndDate(DateTime.now()),"");
      //  },
      //child:
       Scaffold(
        appBar:AppBar(
          backgroundColor: ColorManager.appbarColor,
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Cash Transaction Entry",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          controller: mainScrollController,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color.fromARGB(255,7,125,180),width: 1.w),
                    boxShadow: [
                      // ignore: deprecated_member_use
                      BoxShadow(color: Colors.grey.withOpacity(0.6),spreadRadius: 2,blurRadius: 5.r,offset: const Offset(0, 3)),
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
                          child: Center(child: Text('Cash Transaction Information',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 14.sp, color: Colors.white))),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:3.h,left: 8.w, right: 6.w,bottom: 6.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Tr.Id",style:AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(':')),
                              Expanded(
                                flex: 15,
                                child: Container(
                                  height: 25.h,
                                  decoration: ContDecoration.contDecoration,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text("$cashTrCode",style: AllTextStyle.dateFormatStyle),
                                  )
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:6,child:Text("Tr.Date",style:AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 15,
                                child: Container(
                                  margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                                  height: 25.h,
                                  decoration: ContDecoration.contDecoration,
                                  child: GestureDetector(
                                    onTap: (() {
                                      FocusScope.of(context).requestFocus(quantityFocusNode);
                                      firstSelectedDate();
                                    }),
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 3.w),
                                        suffixIcon: Padding(padding: EdgeInsets.only(left: 20.w),
                                          child: Icon(Icons.calendar_month,color: Colors.black87,size: 16.r),
                                        ),
                                        border: const OutlineInputBorder(borderSide: BorderSide.none),
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
                                  // ):GestureDetector(
                                  //   onTap: (() {
                                  //     // FocusScope.of(context).requestFocus(quantityFocusNode);
                                  //     // firstSelectedDate();
                                  //   }),
                                  //   child: TextFormField(
                                  //     enabled: false,
                                  //     decoration: InputDecoration(
                                  //       contentPadding: const EdgeInsets.only(left: 5),
                                  //       // suffixIcon: const Padding(padding: EdgeInsets.only(left: 20.0),
                                  //       //   child: Icon(Icons.calendar_month,color: Colors.black87,size: 16),
                                  //       // ),
                                  //       border: const OutlineInputBorder(borderSide: BorderSide.none),
                                  //       hintText: firstPickedDate,
                                  //       hintStyle: AllTextStyle.dateFormatStyle
                                  //     ),
                                  //     validator: (value) {
                                  //       if (value == null || value.isEmpty) {
                                  //         return null;
                                  //       }            return null;
                                  //     },
                                  //   ),
                                  ),
                                ),
                              )
                            ,
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Tr.Type",style:AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                            flex: 15,
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
                        _selectedType!,
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
                        SizedBox(height: 3.h),
                        Row(
                        children: [
                          Expanded(flex: 6, child: Text("Pay.Type",style: AllTextStyle.textFieldHeadStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                          flex: 15,
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
                        SizedBox(height: 4.h),
                        isBankListClicked == true
                          ? Row(
                            children: [
                              Expanded(flex: 6,child: Text("Bank",style: AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 15,
                                child: Container(
                                  height: 25.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: EdgeInsets.only(bottom: 4.h),
                                  decoration: ContDecoration.contDecoration,
                                  child: TypeAheadField<BankAccountModel>(
                                    controller: bankAccountController,
                                    builder: (context, controller, focusNode) {
                                    return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                      isDense: true,
                                      hintText: 'Select Bank Account',
                                      hintStyle: TextStyle(fontSize: 13),
                                      suffixIcon: _selectedBankAccount == '' || _selectedBankAccount == 'null' || _selectedBankAccount == null || controller.text == '' ? null
                                          : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            bankAccountController.clear();
                                            controller.clear();
                                            _selectedBankAccount = null;
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
                                      return allBankAccountList
                                      .where((element) => element.accountName.toLowerCase().contains(pattern.toLowerCase()))
                                      .toList().cast<BankAccountModel>(); 
                                      });
                                      },                    
                                    itemBuilder: (context, BankAccountModel suggestion) {
                                      return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                                    child: Text("${suggestion.accountName} - ${suggestion.accountNumber} (${suggestion.bankName})",
                                      style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    );
                                    },
                                    onSelected: (BankAccountModel suggestion) {
                                    setState(() {
                                      bankAccountController.text = "${suggestion.accountName} - ${suggestion.accountNumber} (${suggestion.bankName})";
                                      _selectedBankAccount = suggestion.id.toString();
                                    });  
                                    },
                                    ),
                                ),
                              ),
                            ],
                          ): Container(),
                          Row(
                            children: [
                              Expanded(flex: 6,child:Text("Account",style:AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 15,
                                child: Container(
                                  height: 25.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: ContDecoration.contDecoration,
                                   child: TypeAheadField<AccountsModel>(
                                    controller: accountsController,
                                    builder: (context, controller, focusNode) {
                                    return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                                      isDense: true,
                                      hintText: 'Select Account',
                                      hintStyle: TextStyle(fontSize: 13),
                                      suffixIcon: accountsID == '' || accountsID == 'null' || accountsID == null || controller.text == '' ? null
                                          : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            accountsController.clear();
                                            controller.clear();
                                            accountsID = null;
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
                                      return allAccountData
                                      .where((element) => element.accountName.toLowerCase().contains(pattern.toLowerCase()))
                                      .toList().cast<AccountsModel>(); 
                                      });
                                      },                    
                                    itemBuilder: (context, AccountsModel suggestion) {
                                      return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                                    child: Text("${suggestion.accountCode} - ${suggestion.accountName}",
                                      style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    );
                                    },
                                    onSelected: (AccountsModel suggestion) {
                                    setState(() {
                                      accountsController.text = "${suggestion.accountCode} - ${suggestion.accountName}";
                                      accountsID = suggestion.id.toString();
                                    });  
                                    },
                                    ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Amount",style:AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 15,
                                child: SizedBox(
                                  height: 25.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: TextStyle(fontSize: 13.sp),
                                    controller: _AmountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                                      hintText: "0",
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
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child:Text("Note",style:AllTextStyle.textFieldHeadStyle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 15,
                                child: TextField(
                                  style: AllTextStyle.dropDownlistStyle,
                                  controller: _DescriptionController,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                                    hintText: "Remarks",
                                    hintStyle: AllTextStyle.dropDownlistStyle,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder: TextFieldInputBorder.focusEnabledBorder
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          ///=====customer loading hide 
                          ///HiddenItemsLoading(controller: quantityController,focusNode: quantityFocusNode),
                        //  ((role == 'Superadmin' || role == 'admin') || actionList.contains('e') == true) ?
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                Utils.closeKeyBoard(context);
                                  print("Tapped Save");

                                  if (accountsController.text == '') {
                                    Utils.showTopSnackBar(context, "Please Select Account");
                                    return;
                                  }
                                  if (_paymentType == "Bank" && bankAccountController.text == '') {
                                    Utils.showTopSnackBar(context, "Please Select Bank Account");
                                    return;
                                  }
                                  setState(() {
                                    cashTrBtnClk = true;
                                  });
                                  var result = await addCashTransaction(context);
                                  if (result == "true") {
                                   Provider.of<CashTransactionProvider>(context, listen: false).getCashTransaction(backEndFirstDate,backEndFirstDate);
                                  }
                                  setState(() {});
                              },
                              child: Container(
                                height: 25.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color:Colors.indigo,
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: [
                                    // ignore: deprecated_member_use
                                    BoxShadow(color: Colors.grey.withOpacity(0.6),spreadRadius: 2,blurRadius: 5.r,offset: const Offset(0, 3)),
                                  ],
                                ),
                                child: Center(child: cashTrBtnClk ? SizedBox(height: 20.h,width:20.h,child: CircularProgressIndicator(color: Colors.white,)) : Text(
                                    "Save", style:AllTextStyle.saveButtonTextStyle)),
                              ),
                            ),
                          ),
                          // :SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CashTransactionProvider.isCashTransactionLoading ? CircularProgressIndicator()
                  : Container(
                  height: MediaQuery.of(context).size.height / 1.43,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      // controller: _listViewScrollController,
                      // physics: _physics,
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowHeight: 20.0,
                          dataRowHeight: 20.0,
                          headingRowColor: WidgetStateColor.resolveWith((states) => const Color.fromARGB(255, 70, 54, 141)),
                          showCheckboxColumn: true,
                          border: TableBorder.all(color: Colors.grey.shade400, width: 1),
                          columns: [
                            DataColumn(label: Expanded(child: Center(child: Text('S/L No.',style: AllTextStyle.tableHeadTextStyle)))),
                            DataColumn(label: Expanded(child: Center(child: Text('Transaction date',style: AllTextStyle.tableHeadTextStyle)))),
                            DataColumn(label: Expanded(child: Center(child: Text('Transaction number',style: AllTextStyle.tableHeadTextStyle)))),
                            DataColumn(label: Expanded(child: Center(child: Text('Account Name',style: AllTextStyle.tableHeadTextStyle)))),
                            DataColumn(label: Expanded(child: Center(child: Text('Account Type',style: AllTextStyle.tableHeadTextStyle)))),
                            DataColumn(label: Expanded(child: Center(child: Text('Payment By',style: AllTextStyle.tableHeadTextStyle)))),
                            DataColumn(label: Expanded(child: Center(child: Text('Amount',style: AllTextStyle.tableHeadTextStyle)))),
                            DataColumn(label: Expanded(child: Center(child: Text('Note',style: AllTextStyle.tableHeadTextStyle)))),			
                          ],
                          rows: List.generate(
                          allCashTransactionData.length,
                                (int index) => DataRow(
                              color: index % 2 == 0 ? WidgetStateProperty.resolveWith(getColor) : WidgetStateProperty.resolveWith(getColors),
                              cells: <DataCell>[
                                DataCell(Center(child: Text('${index+1}'))),
                                DataCell(Center(child: Text('${allCashTransactionData[index].transactionDate??""}'))),
                                DataCell(Center(child: Text('${allCashTransactionData[index].transactionNumber??""}'))),
                                DataCell(Center(child: allCashTransactionData[index].account == "null" || allCashTransactionData[index].account == null?Text("N/A"):Text('${allCashTransactionData[index].account!.accountCode??""} - ${allCashTransactionData[index].account!.accountName??""}'))),
                                DataCell(Center(child: Text('${allCashTransactionData[index].transactionType??""}'))),
                                DataCell(Center(child: allCashTransactionData[index].bank == "null" || allCashTransactionData[index].bank == null? Text("N/A"):Text('${allCashTransactionData[index].bank!.accountName??""} - ${allCashTransactionData[index].bank!.accountNumber??""} - ${allCashTransactionData[index].bank!.bankName??""}'))),
                                DataCell(Center(child: Text('${allCashTransactionData[index].amount??""}'))),
                                DataCell(Center(child: Text('${allCashTransactionData[index].remark??""}'))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0.h),
              // const SizedBox(height: 8.0),
              // Container(
              //   height: MediaQuery.of(context).size.height/1.5,
              //   padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
              //   child:CashTransactionProvider.isCashTransactionLoading ? const Center(child: CircularProgressIndicator()) : allCashTransaction.isEmpty
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
              //                     DataColumn(label: Expanded(child: Center(child: Text('Transaction Id',style: AllTextStyle.tableHeadTextStyle)))),
              //                     DataColumn(label: Expanded(child: Center(child: Text('Account Name',style: AllTextStyle.tableHeadTextStyle)))),
              //                     DataColumn(label: Expanded(child: Center(child: Text('Date',style: AllTextStyle.tableHeadTextStyle)))),
              //                     DataColumn(label: Expanded(child: Center(child: Text('Description',style: AllTextStyle.tableHeadTextStyle)))),
              //                     DataColumn(label: Expanded(child: Center(child: Text('Received Amount',style: AllTextStyle.tableHeadTextStyle)))),
              //                     DataColumn(label: Expanded(child: Center(child: Text('Paid Amount',style: AllTextStyle.tableHeadTextStyle)))),
              //                     DataColumn(label: Expanded(child: Center(child: Text('Saved By',style: AllTextStyle.tableHeadTextStyle)))),
              //                   ],
              //                   rows: _getPaginatedData(allCashTransaction)
              //                       .asMap()
              //                       .entries
              //                       .map((entry) {
              //                     int index = entry.key;
              //                     var cashTransaction = entry.value;
              //                     return DataRow(
              //                       color: index % 2 == 0 ? WidgetStateProperty.resolveWith(getColors) : WidgetStateProperty.resolveWith(getColor),
              //                       cells: [
              //                         DataCell(Center(child: Text(cashTransaction.code))),
              //                         DataCell(Center(child: Text(cashTransaction.account!.name))),
              //                         DataCell(Center(child: Text(cashTransaction.date))),
              //                         DataCell(Center(child: Text(cashTransaction.description??""))),
              //                         DataCell(Center(child: Text(double.parse(cashTransaction.inAmount).toStringAsFixed(decimal!)))),
              //                         DataCell(Center(child: Text(double.parse(cashTransaction.outAmount).toStringAsFixed(decimal!)))),
              //                         DataCell(Center(child: Text(cashTransaction.addBy!.name))),
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
              //                         const Padding(
              //                           padding: EdgeInsets.symmetric(horizontal: 5.0),
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
              // const SizedBox(height: 15.0),
            ],
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
 emptyMethod() {
    setState(() {
      _DescriptionController.text = "";
      _AmountController.text = "";
      accountsController.text = "";
      bankAccountController.text = "";
    });
  }

bool cashTrBtnClk = false;
Future<String> addCashTransaction(BuildContext context) async {
  String link = AppUrl.addCashTrEndPoint;
  print("transaction_number=>> $cashTrCode");
  print("accountsID=>> $accountsID");
  print("payment_type=>> $getPaymentType");
  print("_selectedBankAccount=>> $_selectedBankAccount");
  print("transaction_type=>> $paymentType");
  print("backEndFirstDate=>> $backEndFirstDate");
  print("_descriptionController.text.trim()=>> ${_DescriptionController.text.trim()}");
  print("_amountController.text.trim()=>> ${_AmountController.text.trim()}");
  try {
    final token = getToken();
    var response = await Dio().post(link,
      data: {
          "transaction_number": cashTrCode.toString(),
          "transaction_date": backEndFirstDate.toString(),
          "transaction_type": paymentType,
          "payment_type": getPaymentType,
          "bank_account_id":getPaymentType == "Cash" ? "" :_selectedBankAccount.toString(),
          "account_id": accountsID.toString(),
          "amount": _AmountController.text.trim(),
          "remark": _DescriptionController.text.trim(),
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
        cashTrBtnClk = false;
      });
      emptyMethod();
      CustomSnackBar.showTopSnackBar(context, "${item["message"]}");
      getCashTrCode();
      return "true";
    } else {
      setState(() {
        cashTrBtnClk = false;
      });
      Utils.showTopSnackBar(context,"${item["message"]}");
      return "false";
    }
  } catch (e) {
    setState(() {
      cashTrBtnClk = false;
    });
    print("Exception caught: $e");
    Utils.showTopSnackBar(context, "Something went wrong: $e");
    return "false";
  }
 }
}
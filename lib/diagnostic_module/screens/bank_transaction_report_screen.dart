import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:medical_trade/diagnostic_module/models/bank_account_model.dart';
import 'package:medical_trade/diagnostic_module/providers/bank_account_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/bank_transaction_provider.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankTransactionReportScreen extends StatefulWidget {
  const BankTransactionReportScreen({super.key});

  @override
  State<BankTransactionReportScreen> createState() => _BankTransactionReportScreenState();
}

class _BankTransactionReportScreenState extends State<BankTransactionReportScreen> {
  Color getColor(Set<WidgetState> states) {
    return Colors.blue.shade100;
  }
  Color getColors(Set<WidgetState> states) {
    return Colors.white;
  }
  Color getColorDeposit(Set<WidgetState> states) {
    return Colors.green.shade100;
  }
  Color getColorWithdraw(Set<WidgetState> states) {
    return Colors.blueGrey.shade200;
  }

  bool _isDropdownOpen = false;
  String transactionType = "";
  String? _selectedType = 'All';
   final List<String> _selectedTypeList = [
    'All',
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
          if (selectedValue == "All") {
             transactionType = "";
          }
         if (selectedValue == "Deposit") {
            transactionType = "deposit";
          }
         if (selectedValue == "Withdraw") {
             transactionType = "withdraw";
           }
    });
    print("transactionType=====$transactionType");
  }

  String? bankAccountId = "";
  final bankAccountController = TextEditingController();
  var quantityController = TextEditingController();
  ///new condition
  FocusNode quantityFocusNode = FocusNode();

  String? firstPickedDate;
  var backEndFirstDate;
  var backEndSecondDate;
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
    } else {
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
        backEndSecondDate = Utils.formatBackEndDate(selectedDate);
      });
    } else {
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(toDay);
        backEndSecondDate = Utils.formatBackEndDate(toDay);
      });
    }
  }
  bool isLoading = false;

  String? organizationName = "";
  String? organizationTitle = "";
  String? organizationPhone = "";
  String? organizationAddress = "";
  String? organizationLogo = "";
  String? dueStatus = "";
  String imageUrl = "";
  SharedPreferences? sharedPreferences;
  Future<void> _initializeData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    organizationName = "${sharedPreferences?.getString('name')}";
    organizationTitle = "${sharedPreferences?.getString('title')}";
    organizationPhone = "${sharedPreferences?.getString('phone')}";
    organizationAddress = "${sharedPreferences?.getString('address')}";
    organizationLogo = "${sharedPreferences?.getString('logo')}";
    dueStatus = "${sharedPreferences?.getString('due_status')}";
  }

  Future<Uint8List> _fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getDropdownSize);
    _initializeData();
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    backEndSecondDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    /// account
    Provider.of<BankAccountProvider>(context, listen: false).getBankAccount();
    Provider.of<BankTransactionProvider>(context, listen: false).bankTransactionList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///bank account
    final allBankAccountsData = Provider.of<BankAccountProvider>(context).allBankAccountList;
    final allBankTransactionData = Provider.of<BankTransactionProvider>(context).bankTransactionList;
    double amount = allBankTransactionData
    .map((e) => double.parse("${e.amount}"))
    .fold(0.0, (p, element) => p + element);
    double? depositValue = allBankTransactionData.where((element) => element.transactionType == 'deposit').map((e) => e.amount).fold(0.0, (p, element) => p! + double.parse("${element}"));
    double? withdrawValue = allBankTransactionData.where((element) => element.transactionType == 'withdraw').map((e) => e.amount).fold(0.0, (p, element) => p! + double.parse("${element}"));

    return Scaffold(
      appBar:AppBar(
        backgroundColor: ColorManager.appbarColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Bank Transaction Report",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(8.r),
              child: Container(
                width: double.infinity,
                padding:  EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color.fromARGB(255, 7, 125, 180),width: 1.w),
                  boxShadow: [
                    // ignore: deprecated_member_use
                    BoxShadow(color: Colors.grey.withOpacity(0.6),spreadRadius: 2.r,blurRadius: 5.r,offset: const Offset(0, 3)),
                  ],
                ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(flex: 6,child:Text("Bank Account",style: AllTextStyle.textFieldHeadStyle)),
                      const Expanded(flex: 1, child: Text(":")),
                      Expanded(
                        flex: 11,
                        child: Container(
                          height: 25.h,
                          width: MediaQuery.of(context).size.width / 2,
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
                              hintText: 'Select Account',
                              hintStyle: TextStyle(fontSize: 13),
                              suffixIcon: bankAccountId == '' || bankAccountId == 'null' || bankAccountId == null || controller.text == '' ? null
                                  : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bankAccountController.clear();
                                    controller.clear();
                                    bankAccountId = null;
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
                              return allBankAccountsData
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
                              bankAccountId = suggestion.id.toString();
                            });  
                            },
                            ),
                            
                          // child: CommonTypeAheadField<BankAccountModel>(
                          //   controller: bankAccountController,
                          //   suggestionList: allBankAccountsData,
                          //   hintText: 'Select Account',
                          //   selectedValueId: bankAccountId,
                          //   onValueIdChanged: (id) {
                          //     setState(() {
                          //       bankAccountId = id;
                          //     });
                          //   },
                          //   displayText: (bac) => "${bac.accountNumber} - ${bac.accountName} (${bac.bankName})",
                          //   valueId: (bac) => bac.accountId.toString(),
                          // ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(flex: 6,child: Text("Trans. Type",style: AllTextStyle.textFieldHeadStyle)),
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
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                          height: 25.h,
                          decoration:ContDecoration.contDecoration,
                          child: GestureDetector(
                            onTap: (() {
                              _firstSelectedDate();
                              FocusScope.of(context).requestFocus(quantityFocusNode);
                            }),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5.w),
                                suffixIcon: Padding(padding: EdgeInsets.only(left: 20.w),
                                  child: Icon(Icons.calendar_month,color: Colors.black87,size: 16.r),
                                ),
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: firstPickedDate,
                                hintStyle:AllTextStyle.dateFormatStyle
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
                      const Text("to"),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 25.h,
                          margin: EdgeInsets.only(left: 5.w, bottom: 5.h),
                          decoration:ContDecoration.contDecoration,
                          child: GestureDetector(
                            onTap: (() {
                              _secondSelectedDate();
                              FocusScope.of(context).requestFocus(quantityFocusNode);
                            }),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding:  EdgeInsets.only(left: 5.w),
                                suffixIcon:  Padding(padding: EdgeInsets.only(left: 20.0.w),
                                child: Icon(Icons.calendar_month, color: Colors.black87,size: 16.r),
                                ),
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: secondPickedDate,
                                hintStyle:AllTextStyle.dateFormatStyle
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
                    ],
                  ),
                  ///=====customer loading hide 
                  //HiddenItemsLoading(controller: quantityController,focusNode: quantityFocusNode),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: ()  {
                        BankTransactionProvider().on();
                        Provider.of<BankTransactionProvider>(context,listen: false)
                            .getBankTransaction(
                            backEndFirstDate,
                            backEndSecondDate,
                            transactionType,
                            bankAccountId??"",
                        );
                        setState(() {
                        });
                      },
                      child: Container(
                        height: 25.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color:Colors.indigo,
                          borderRadius: BorderRadius.circular(5.r),
                          boxShadow: [
                            // ignore: deprecated_member_use
                            BoxShadow(color: Colors.grey.withOpacity(0.6),spreadRadius: 2.r,blurRadius: 5.r,offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Center(child: Text("Search", style:AllTextStyle.saveButtonTextStyle)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // allBankTransactionReportData.isNotEmpty ? GestureDetector(
          //   onTap: () async{
          //     imageUrl = organizationLogo == "null"
          //     ? "${sharedPreferences!.getString("ImageBaseUrl")}noImage.gif"
          //     : "${sharedPreferences!.getString("ImageBaseUrl")}$organizationLogo";
          //   await printBankTransactionReport(
          //     allBankTransactionReportData,
          //     paymentType,
          //     depositValue,
          //     withdrawValue,
          //     decimal,
          //     context,
          //   );
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Icon(Icons.print,color: Colors.indigo.shade700),
          //       SizedBox(width: 5.0),
          //       Text("Print",style: TextStyle(color: Colors.indigo.shade700,fontWeight: FontWeight.bold)),
          //       SizedBox(width: 10.0),
          //     ],
          //   ),
          // ):SizedBox(),
          // const SizedBox(height: 5.0),
          BankTransactionProvider.isBankTransactionLoading
              ? const Center(child: CircularProgressIndicator())
              : allBankTransactionData.isNotEmpty
              ? Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTable(
                        headingRowHeight: 20.0,
                        // ignore: deprecated_member_use
                        dataRowHeight: 20.0,
                        showCheckboxColumn: true,
                        headingRowColor: transactionType == "Withdraw"? WidgetStateColor.resolveWith((states) => Colors.teal.shade700):
                        transactionType == "Deposit"? WidgetStateColor.resolveWith((states) => Colors.deepPurple.shade800):WidgetStateColor.resolveWith((states) => Colors.blueGrey.shade800),
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: const [
                          DataColumn(label: Expanded(child: Center(child: Text('Tr.Id',style:AllTextStyle.tableHeadTextStyle)))),
                          DataColumn(label: Expanded(child: Center(child: Text('Date',style:AllTextStyle.tableHeadTextStyle)))),
                          DataColumn(label: Expanded(child: Center(child: Text('Tr.Type',style:AllTextStyle.tableHeadTextStyle)))),
                          DataColumn(label: Expanded(child: Center(child: Text('Account Name',style:AllTextStyle.tableHeadTextStyle)))),
                          DataColumn(label: Expanded(child: Center(child: Text('Description',style:AllTextStyle.tableHeadTextStyle)))),
                          DataColumn(label: Expanded(child: Center(child: Text('Amount',style:AllTextStyle.tableHeadTextStyle)))),
                        ],
                        rows: [
                          ...List.generate(
                            allBankTransactionData.length,
                                (int index) => DataRow(
                               color: transactionType == "Withdraw"?index % 2 == 0 ? WidgetStateProperty.resolveWith(getColor):WidgetStateProperty.resolveWith(getColors):
                               transactionType == "Deposit"?index % 2 == 0 ? WidgetStateProperty.resolveWith(getColorDeposit):WidgetStateProperty.resolveWith(getColors):index % 2 == 0 ? WidgetStateProperty.resolveWith(getColor):WidgetStateProperty.resolveWith(getColors),
                              cells: <DataCell>[
                                DataCell(Center(child: Text(allBankTransactionData[index].transactionNumber??""))),
                                DataCell(Center(child: Text(allBankTransactionData[index].transactionDate??""))),
                                DataCell(Center(child:allBankTransactionData[index].transactionType == "Deposit"
                                    ? const Text("Deposit")
                                    : allBankTransactionData[index].transactionType == "Withdraw"
                                    ? const Text("Withdraw")
                                    : const Text("N/A"))),
                                DataCell(Center(child: allBankTransactionData[index].bank == "null" || allBankTransactionData[index].bank == null? Text("N/A"):Text('${allBankTransactionData[index].bank!.accountName??""} - ${allBankTransactionData[index].bank!.accountNumber??""} - ${allBankTransactionData[index].bank!.bankName??""}'))),
                                DataCell(Center(child: Text("${allBankTransactionData[index].remark??""}"))),
                                DataCell(Center(child: Text("${allBankTransactionData[index].amount??""}"))),
                              ],
                            ),
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(SizedBox()),
                              const DataCell(SizedBox()),
                              const DataCell(SizedBox()),
                              const DataCell(SizedBox()),
                              const DataCell(Center(child: Text('Total',style:TextStyle(fontWeight: FontWeight.bold)))),
                              DataCell(Center(child: Text(amount.toStringAsFixed(2),style:const TextStyle(fontWeight: FontWeight.bold)))),  
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ) :  Align(alignment: Alignment.center,child: Center(child: Text("No records found",style:AllTextStyle.nofoundTextStyle))),
        ],
      ),
    );
  }
}
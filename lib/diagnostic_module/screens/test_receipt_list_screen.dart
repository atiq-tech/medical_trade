import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';

class TestReceiptListScreen extends StatefulWidget {
  const TestReceiptListScreen({Key? key}) : super(key: key);
  @override
  State<TestReceiptListScreen> createState() => _TestReceiptListScreenState();
}
class _TestReceiptListScreenState extends State<TestReceiptListScreen> {
  Color getColor(Set<WidgetState> states) {
    return Colors.blue.shade100;
  }
  Color getColors(Set<WidgetState> states) {
    return Colors.white;
  }
  Color getColorsbyAll(Set<WidgetState> states) {
    return Colors.green.shade100;
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

  bool _isDropdownOpen = false;
  bool isAllTypeClicked = true;
  bool isCustomerListClicked = false;
  String _searchType = 'All';
  String customerId = '';
  final List<String> _searchTypeList = [
    'All',
    'By Doctor',
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
                    children: _searchTypeList.asMap().entries.map((entry) {
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
                            if (index != _searchTypeList.length - 1)
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
      _searchType = selectedValue;
      isAllTypeClicked = selectedValue == "All";
      isCustomerListClicked = selectedValue == "By Doctor";
      emtyMethod(); 
    });
  }

   emtyMethod() {
    setState(() {
      customerController.text= "";
      customerId="";
    });
  }

  var data;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getDropdownSize);
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndSecondtDate = Utils.formatBackEndDate(DateTime.now());
    super.initState();
  }

  var customerController = TextEditingController();
  var areaController = TextEditingController();
  ///Sub total
  double? totalCustomerDue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      backgroundColor: ColorManager.appbarColor,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Test Receipt List",
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
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
            child: Container(
              padding: EdgeInsets.only(left: 4.w, right: 4.w,bottom: 4.h),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                 color: const Color.fromARGB(255, 7, 125, 180),
                 width: 1.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(flex: 4,child: Text("Search Type",style:AllTextStyle.textFieldHeadStyle),),
                      Expanded(flex: 1,child: Text(":",style:AllTextStyle.textFieldHeadStyle),),
                      Expanded(
                      flex: 9,
                      child: CompositedTransformTarget(
                        link: _layerLink,
                        child: GestureDetector(
                        onTap: _toggleDropdown,
                        child: Container(
                        key: _key,
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        height: 25.h,decoration: ContDecoration.contDecoration,
                       child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                           _searchType,style: TextStyle(fontSize: 13.sp),
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
                  isCustomerListClicked == true
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 4, child: Text("Dortor",style:AllTextStyle.textFieldHeadStyle)),
                              Expanded(flex: 1,child: Text(":",style:AllTextStyle.textFieldHeadStyle),),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  height: 25.h,
                                  decoration: ContDecoration.contDecoration,
                            //       child: TypeAheadField<CustomerModel>(
                            //      controller: customerController,
                            //      builder: (context, controller, focusNode) {
                            //      return TextField(
                            //        controller: controller,
                            //        focusNode: focusNode,
                            //        style: TextStyle(fontSize: 13, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis),
                            //        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.0, top: 4.0),
                            //          isDense: true,
                            //          hintText: 'Select Customer',
                            //          hintStyle: TextStyle(fontSize: 13),
                            //          suffixIcon: _selectedCustomer == '' || _selectedCustomer == 'null' || _selectedCustomer == null || controller.text == '' ? null
                            //              : GestureDetector(
                            //            onTap: () {
                            //              setState(() {
                            //                customerController.clear();
                            //                controller.clear();
                            //                _selectedCustomer = null;
                            //              });
                            //            },
                            //            child: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.close, size: 16)),
                            //          ),
                            //          suffixIconConstraints: BoxConstraints(maxHeight: 30),
                            //          filled: false,
                            //          fillColor: Colors.white,
                            //          border: InputBorder.none,
                            //        ),
                            //      );
                            //    },
                            //    suggestionsCallback: (pattern) async {
                            //     return Future.delayed(const Duration(seconds: 1), () {
                            //    return allCustomerData
                            //     .where((element) => element.name!.toLowerCase().contains(pattern.toLowerCase()))
                            //    .toList().cast<CustomerModel>(); 
                            //     });
                            //     },
                             
                            //    itemBuilder: (context, CustomerModel suggestion) {
                            //      return Padding(
                            //        padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                            //        child: Text("${suggestion.name} ${suggestion.code != "" ? " - ${suggestion.code}" : ""} ${suggestion.phone != "" ? " - ${suggestion.phone}" : ""}",
                            //          style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,
                            //        ),
                            //      );
                            //    },
                            //    onSelected: (CustomerModel suggestion) {
                            //       setState(() {
                            //          customerController.text = "${suggestion.name} ${suggestion.code != "" ? " - ${suggestion.code}" : ""} ${suggestion.phone != "" ? " - ${suggestion.phone}" : ""}";
                            //          _selectedCustomer = suggestion.id.toString();
                            //       });
                            //    },
                            //  ),

                                ),
                              ),
                            ],
                          )
                        ],
                      )
                      : Container(),
                       SizedBox(
                        height: 35.h,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(right: 5.w),
                                height: 25.h,
                                padding: EdgeInsets.all(5.r),
                                decoration:ContDecoration.contDecoration,
                                child: GestureDetector(
                                  onTap: (() {
                                    _firstSelectedDate();
                                    }),
                                  child: TextFormField(
                                    style: AllTextStyle.dateFormatStyle,
                                    enabled: false,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      filled: true,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(left: 25.w),
                                        child: Icon(Icons.calendar_month, color: Color.fromARGB(221, 22, 51, 95), size: 16.r),
                                      ),
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      hintText: firstPickedDate ,
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
                            const Text("To"),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 5.w),
                                height: 25.h,
                                padding: EdgeInsets.all(5.r),
                                decoration:ContDecoration.contDecoration,
                                child: GestureDetector(
                                  onTap: (() {
                                    _secondSelectedDate();
                                  }),
                                  child: TextFormField(
                                    style: AllTextStyle.dateFormatStyle,
                                    enabled: false,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      filled: true,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(left: 25.w),
                                        child: Icon(Icons.calendar_month, color: Color.fromARGB(221, 22, 51, 95), size: 16.r),
                                      ),
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
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
                          ],
                        ),
                      ),
                      Align(
                      alignment: Alignment.bottomRight,
                       child: Container(
                       padding: EdgeInsets.all(1.r),
                        child: InkWell(
                        onTap: () {
                        setState(() {
                          _searchType == "By Doctor"
                              ? data = 'by doctor'
                              : _searchType == "All"
                              ? data = 'all' : '';
                          });

                      // CustomerDueProvider().on();
                      // Provider.of<CustomerDueProvider>(context, listen: false).getCustomerDue(
                      //   customerId: _selectedCustomer ?? '',
                      //   districtId: _selectedArea ?? '',
                      // );
                    },
                    child: Container(
                      height: 25.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 4, 113, 185),
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
                      child: Text("Search", style: AllTextStyle.saveButtonTextStyle),
                        ),
                        ),
                      ),
                      ),
                  ),
                 
                ],
              ),
            ),
          ),
        //     const SizedBox(height: 15.0),
        //     CustomerDueProvider.isCustomerDueLoading ?
        //     const Center(child: CircularProgressIndicator(),)
        //      :allCustomerDueData.isNotEmpty? Expanded(child: Container(
        //     padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        //      child: SingleChildScrollView(
        //        scrollDirection: Axis.vertical,
        //        child: SingleChildScrollView(
        //          scrollDirection: Axis.horizontal,
        //          child: Column(
        //            crossAxisAlignment: CrossAxisAlignment.start,
        //            children: [
        //              DataTable(
        //                headingRowHeight: 20.0,
        //                // ignore: deprecated_member_use
        //                dataRowHeight: 20.0,
        //                headingRowColor: data == 'all'? WidgetStateColor.resolveWith((states) => Colors.indigo):WidgetStateColor.resolveWith((states) => Colors.blue.shade900),
        //                showCheckboxColumn: true,
        //                border: TableBorder.all(color: Colors.black54, width: 1),
        //                columns: const [
        //                  DataColumn(label: Expanded(child: Center(child: Text('Sl',style:AllTextStyle.tableHeadTextStyle)))),
        //                  DataColumn(label: Expanded(child: Center(child: Text('Customer Code',style:AllTextStyle.tableHeadTextStyle)))),
        //                  DataColumn(label: Expanded(child: Center(child: Text('Customer Name',style:AllTextStyle.tableHeadTextStyle)))),
        //                  DataColumn(label: Expanded(child: Center(child: Text('Owner Name',style:AllTextStyle.tableHeadTextStyle)))),
        //                  DataColumn(label: Expanded(child: Center(child: Text('Area',style:AllTextStyle.tableHeadTextStyle)))),
        //                  DataColumn(label: Expanded(child: Center(child: Text('Phone',style:AllTextStyle.tableHeadTextStyle)))),
        //                  DataColumn(label: Expanded(child: Center(child: Text('Due Amount',style:AllTextStyle.tableHeadTextStyle)))),
        //                ],
        //                rows: [
        //                  ...List.generate(
        //                    allCustomerDueData.length,
        //                      (int index) => DataRow(
        //                       color:data == 'all'? index % 2 == 0 ? WidgetStateProperty.resolveWith(getColor):WidgetStateProperty.resolveWith(getColors):index % 2 == 0 ? WidgetStateProperty.resolveWith(getColorsbyAll):WidgetStateProperty.resolveWith(getColors),
        //                      cells: <DataCell>[
        //                        DataCell(Center(child: Text("${index+1}"))),
        //                        DataCell(Center(child: Text(allCustomerDueData[index].code))),
        //                        DataCell(SizedBox(width: MediaQuery.of(context).size.width/2.4,
        //                          child: Padding(padding: const EdgeInsets.only(left: 0),
        //                            child: Text(allCustomerDueData[index].name??""))),
        //                        ),
        //                        DataCell(Center(child: Text(allCustomerDueData[index].ownerName??""))),
        //                        DataCell(Center(child: Text(allCustomerDueData[index].areaName??""))),
        //                        DataCell(Center(child: Text(allCustomerDueData[index].phone??""))),
        //                        DataCell(Center(child: Text(double.parse(allCustomerDueData[index].dueAmount).toStringAsFixed(decimal!)))),
        //                      ],
        //                    ),
        //                  ),
        //                  // Footer row
        //                  DataRow(
        //                    cells: <DataCell>[
        //                      const DataCell(SizedBox()),
        //                      const DataCell(SizedBox()),
        //                      const DataCell(SizedBox()),
        //                      const DataCell(SizedBox()),
        //                      const DataCell(SizedBox()),
        //                      const DataCell(Center(child: Text('Total Due',style:TextStyle(fontWeight: FontWeight.bold)))),
        //                      DataCell(Center(child: Text(totalCustomerDue!.toStringAsFixed(decimal!),style:const TextStyle(fontWeight: FontWeight.bold)))),
        //                    ],
        //                  ),
        //                ],
        //              ),
        //            ],
        //          ),
        //        ),
        //      ),
        //    ),
        //  ):const Align(alignment: Alignment.center,child: Center(child: Text("No Data Found",style:AllTextStyle.nofoundTextStyle))),
       
        ],
      ),
    );
  }
}
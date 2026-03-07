import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/controller/user_record_post_api.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/model/user_record_model.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:provider/provider.dart';

class UserRecordView extends StatefulWidget {
  const UserRecordView({super.key});

  @override
  State<UserRecordView> createState() => _UserRecordViewState();
}

class _UserRecordViewState extends State<UserRecordView> {

  String? firstPickedDate;
  String? secondPickedDate;

  String? backEndFirstDate;
  String? backEndSecondDate;

  final DateTime toDay = DateTime.now();

  Timer? _tokenTimer;

@override
void initState() {
  super.initState();

  firstPickedDate = Utils.formatFrontEndDate(toDay);
  backEndFirstDate = Utils.formatBackEndDate(toDay);
  secondPickedDate = Utils.formatFrontEndDate(toDay);
  backEndSecondDate = Utils.formatBackEndDate(toDay);

  _startTokenChecking();
}

void _startTokenChecking() {
  _tokenTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
    final box = GetStorage();
    final token = box.read('loginToken');

    print("TOKEN CHECKING: $token");

    if (token == null) {
      timer.cancel();
      Utils.showTopSnackBar(context, "Session expired. Please log in again."); // ✅ timer stop
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) =>const LoginView(isLogin: true)),
        (Route<dynamic> route) =>false, 
      );
    }
  });
}

@override
void dispose() {
  _tokenTimer?.cancel();
  super.dispose();
}

  void _pickDate(bool isFirst) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: toDay,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    if (selectedDate != null) {
      setState(() {
        if (isFirst) {
          firstPickedDate = Utils.formatFrontEndDate(selectedDate);
          backEndFirstDate = Utils.formatBackEndDate(selectedDate);
        } else {
          secondPickedDate = Utils.formatFrontEndDate(selectedDate);
          backEndSecondDate = Utils.formatBackEndDate(selectedDate);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserRecordProvider>();
    final data = provider.userRecord;
    return Scaffold(
      appBar: CustomAppBar(
        onTap: () => Navigator.pop(context),
        title: "User Record",
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h,bottom: 50.h),
        child: Column(
          children: [
            buildDateFilter(provider),
            if (provider.isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSection("Client Posts", Colors.blue, data?.clientPosts ?? []),
                      buildSection("Engineer Supports", Colors.green, data?.engineerSupports ?? []),
                      buildSection("Customer Orders", Colors.orange, data?.orders ?? []),
                      buildSection("My Requirement", Colors.purple, data?.myRequirements ?? []),
                      buildSection("Others", Colors.indigo.shade900, data?.others ?? []),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// DATE FILTER
  Widget buildDateFilter(UserRecordProvider provider) {
    return Card(
      elevation: 4,
      color: Colors.purple.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.r),
        child: Column(
          children: [
            Row(
              children: [
                /// FROM DATE
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.h),
                    decoration: ContDecoration.contDecoration,
                    child: InkWell(
                      onTap: () => _pickDate(true),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(firstPickedDate ?? "",style: TextStyle(fontSize: 11.r)),
                          SizedBox(width: 6.w),
                          Icon(Icons.calendar_month, color: Colors.blue,size: 12.r),
                        ],
                      ),
                    ),
                  ),
                ),
                const Text(" To "),
                /// TO DATE
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                    decoration: ContDecoration.contDecoration,
                    child: InkWell(
                      onTap: () => _pickDate(false),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(secondPickedDate ?? "",style: TextStyle(fontSize: 11.r)),
                          SizedBox(width: 6.w),
                          Icon(Icons.calendar_month, color: Colors.red,size: 12.r),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.5.h),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900, 
                      borderRadius: BorderRadius.circular(6.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () async {
                        await provider.fetchUserRecord(
                          dateFrom: backEndFirstDate ?? "",
                          dateTo: backEndSecondDate ?? "",
                        );
                      },
                      child: Center(
                        child: const Text(
                          "Show",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

Widget buildSection(String title, Color headerColor, List<dynamic> list) {
  /// -------------------------------
  /// Dynamic column + row list
  /// -------------------------------
  List<DataColumn> columns = [];
  List<DataRow> rows = [];

  /// -------------------------------
  /// CLIENT POST TABLE
  /// -------------------------------
  if (list.isNotEmpty && list.first is ClientPost) {
    columns = const [
      DataColumn(label: Text("SL")),
      DataColumn(label: Text("Customer Post ID")),
      DataColumn(label: Text("Machine Name")),
      DataColumn(label: Text("Price")),
      DataColumn(label: Text("Model")),
      DataColumn(label: Text("Condition")),
      DataColumn(label: Text("Mobile")),
      DataColumn(label: Text("Description")),
    ];

    rows = List.generate(list.length, (index) {
      final item = list[index] as ClientPost;
      return DataRow(cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(item.customerPostId ?? "")),
        DataCell(Text(item.machineName ?? "")),
        DataCell(Text(item.price ?? "")),
        DataCell(Text(item.model ?? "")),
        DataCell(Text(item.condition ?? "")),
        DataCell(Text(item.mobile ?? "")),
        DataCell(Text(item.description ?? "")),
      ]);
    });
  }

  /// ENGINEER SUPPORT TABLE
  else if (list.isNotEmpty && list.first is EngineerSupport) {
    columns = const [
      DataColumn(label: Text("SL")),
      DataColumn(label: Text("Machine Name")),
      DataColumn(label: Text("Model")),
      DataColumn(label: Text("Origin")),
      DataColumn(label: Text("Mobile")),
      DataColumn(label: Text("Description")),
    ];

    rows = List.generate(list.length, (index) {
      final item = list[index] as EngineerSupport;
      return DataRow(cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(item.machineName ?? "")),
        DataCell(Text(item.model ?? "")),
        DataCell(Text(item.origin ?? "")),
        DataCell(Text(item.mobile ?? "")),
        DataCell(Text(item.description ?? "")),
      ]);
    });
  }

  /// MY REQUIREMENT TABLE
  else if (list.isNotEmpty && list.first is MyRequirement) {
    columns = const [
      DataColumn(label: Text("SL")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Mobile")),
      DataColumn(label: Text("Address")),
      DataColumn(label: Text("Description")),
    ];

    rows = List.generate(list.length, (index) {
      final item = list[index] as MyRequirement;
      return DataRow(cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(item.name ?? "")),
        DataCell(Text(item.mobile ?? "")),
        DataCell(Text(item.address ?? "")),
        DataCell(Text(item.description ?? "")),
      ]);
    });
  }

  /// ORDER TABLE
  else if (list.isNotEmpty && list.first is Order) {
    columns = const [
      DataColumn(label: Text("SL")),
      DataColumn(label: Text("Order ID")),
      DataColumn(label: Text("Product Name")),
      DataColumn(label: Text("Price")),
      DataColumn(label: Text("Type")),
      DataColumn(label: Text("Description")),
    ];

    rows = List.generate(list.length, (index) {
      final item = list[index] as Order;
      return DataRow(cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(item.orderId ?? "")),
        DataCell(Text(item.product?.productName ?? "")),
        DataCell(Text(item.product?.price ?? "")),
        DataCell(Text(item.product?.type ?? "")),
        DataCell(Text(item.product?.description ?? "")),
      ]);
    });
  }

  /// OTHER TABLE
  else if (list.isNotEmpty && list.first is OtherPost) {
    columns = const [
      DataColumn(label: Text("SL")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Price")),
      DataColumn(label: Text("Model")),
      DataColumn(label: Text("Origin")),
      DataColumn(label: Text("Condition")),
      DataColumn(label: Text("Upazilla")),
      DataColumn(label: Text("Mobile")),
      DataColumn(label: Text("Description")),
    ];

    rows = List.generate(list.length, (index) {
      final item = list[index] as OtherPost;
      return DataRow(cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(item.name ?? "")),
        DataCell(Text(item.price ?? "")),
        DataCell(Text(item.model ?? "")),
        DataCell(Text(item.origin ?? "")),
        DataCell(Text(item.condition ?? "")),
        DataCell(Text(item.upazilla ?? "")),
        DataCell(Text(item.mobile ?? "")),
        DataCell(Text(item.description ?? "")),
      ]);
    });
  }

  /// যদি list খালি হয়
  if (list.isEmpty) {
    // columns default
    columns = const [
      DataColumn(label: Text("Machine Name")),
      DataColumn(label: Text("Model")),
      DataColumn(label: Text("Condition")),
      DataColumn(label: Text("Description")),
    ];
    rows = [
      const DataRow(cells: [
        DataCell(Text("")),
        DataCell(Text("No Data Found",style: TextStyle(color: Colors.red))),
        DataCell(Text("")),
        DataCell(Text("")),
      ])
    ];
  }

  /// -------------------------------
  /// UI PART
  /// -------------------------------
  return Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 6.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.r),
      side: BorderSide(color: const Color.fromARGB(255, 240, 230, 186)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r)),
          ),
          child: Center(
            child: Text(
              "$title (${list.length})",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 3.h),
        Padding(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 18.h,
              dataRowHeight: 18.h,
              headingRowColor: MaterialStateProperty.all(headerColor.withOpacity(.25)),
              border: TableBorder.all(color: Colors.grey.shade300),
              columns: columns,
              rows: rows,
            ),
          ),
        ),
      ],
    ),
  );
}
}
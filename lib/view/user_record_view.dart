import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/user_record_post_api.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/app_colors.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:flutter/material.dart';
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
  String? backEndSecondtDate;

  final DateTime toDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    firstPickedDate = Utils.formatFrontEndDate(toDay);
    backEndFirstDate = Utils.formatBackEndDate(toDay);
    secondPickedDate = Utils.formatFrontEndDate(toDay);
    backEndSecondtDate = Utils.formatBackEndDate(toDay);
  }

  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: toDay,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    final date = selectedDate ?? toDay;

    setState(() {
      firstPickedDate = Utils.formatFrontEndDate(date);
      backEndFirstDate = Utils.formatBackEndDate(date);
    });
  }

  void _secondSelectedDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: toDay,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    final date = selectedDate ?? toDay;

    setState(() {
      secondPickedDate = Utils.formatFrontEndDate(date);
      backEndSecondtDate = Utils.formatBackEndDate(date);
    });
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
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [

            /// ================= DATE FILTER =================
            buildDateFilter(provider),

            const SizedBox(height: 10),

            /// ================= LOADING =================
            if (provider.isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (provider.errorMessage != null)
              Expanded(
                child: Center(child: Text(provider.errorMessage!)),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      buildDataTableSection(
                        "Client Posts",
                        data?.clientPosts ?? [],
                      ),

                      buildDataTableSection(
                        "Engineer Supports",
                        data?.engineerSupports ?? [],
                      ),

                      buildDataTableSection(
                        "Customer Orders",
                        data?.orders ?? [],
                      ),

                      buildDataTableSection(
                        "My Requirement",
                        data?.myRequirements ?? [],
                      ),

                      buildDataTableSection(
                        "Other",
                        data?.others ?? [],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// ================= DATE FILTER WIDGET =================
  Widget buildDateFilter(UserRecordProvider provider) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _firstSelectedDate,
                    child: Text(firstPickedDate ?? ""),
                  ),
                ),
                const Text("To"),
                Expanded(
                  child: InkWell(
                    onTap: _secondSelectedDate,
                    child: Text(secondPickedDate ?? ""),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  await provider.fetchUserRecord(
                    dateFrom: backEndFirstDate ?? "",
                    dateTo: backEndSecondtDate ?? "",
                  );
                },
                child: const Text("Search"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= TABLE SECTION =================
  Widget buildDataTableSection(
      String title,
      List<dynamic> list,
      ) {
    return Column(
      children: [

        Text(title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold)),

        SizedBox(height: 5.h),

        SizedBox(
          height: 120.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Sl.")),
                DataColumn(label: Text("Title")),
                DataColumn(label: Text("Description")),
                DataColumn(label: Text("Mobile")),
                DataColumn(label: Text("Date")),
              ],
              rows: list.isEmpty
                  ? const [
                DataRow(cells: [
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("No Data Found")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                ])
              ]
                  : List.generate(
                list.length,
                    (index) {
                  final item = list[index];

                  return DataRow(
                    cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(Text(item.title ?? "")),
                      DataCell(Text(item.description ?? "")),
                      DataCell(Text(item.mobile ?? "")),
                      DataCell(Text(item.date ?? "")),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
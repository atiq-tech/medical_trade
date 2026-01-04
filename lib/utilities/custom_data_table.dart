import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/engineering_support_api.dart';
import 'package:provider/provider.dart';

class EngineeringCustomDataTable extends StatefulWidget {
  const EngineeringCustomDataTable({super.key});

  @override
  State<EngineeringCustomDataTable> createState() => _EngineeringCustomDataTableState();
}

class _EngineeringCustomDataTableState extends State<EngineeringCustomDataTable> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetEngineerSupportProductProvider>(context, listen: false).fetchDataProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetEngineerSupportProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.categories.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        final products = provider.categories.reversed.toList();
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: DataTable(
                dataRowHeight: 25.0.h,
                headingRowHeight: 25.0.h,
                headingRowColor: WidgetStateProperty.all(const Color.fromARGB(255, 83, 177, 87)),
                border: TableBorder.all(color: Colors.black, width: 0.5.w),
                columns: [
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: SizedBox(
                      width: 25.w,
                      child: Center(
                        child: Text(
                          'SL.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Center(
                      child: Text(
                        'Title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Center(
                      child: Text(
                        'Person Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Center(
                      child: Text(
                        'Designation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Center(
                      child: Text(
                        'Mobile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
                rows: products.asMap().entries.map((entry) {
                  var index = entry.key;
                  var product = entry.value;
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Center(child: SizedBox(width: 35.w,child: Text((index + 1).toString(),textAlign: TextAlign.center)))),
                      DataCell(Text(product.title, textAlign: TextAlign.start)),
                      DataCell(Text(product.personName, textAlign: TextAlign.start)),
                      DataCell(Text(product.designation,textAlign: TextAlign.start)),
                      DataCell(Text(product.mobile, textAlign: TextAlign.start)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

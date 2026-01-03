import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/get_sales_old_machine_api.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/view/sales_old_machine_details_view.dart';
import 'package:provider/provider.dart';

class SalesOldMachieData extends StatefulWidget {
  const SalesOldMachieData({super.key});

  @override
  State<SalesOldMachieData> createState() => _SalesOldMachieDataState();
}

class _SalesOldMachieDataState extends State<SalesOldMachieData> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetSalesOldMachineProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final getOldMachineProvider = Provider.of<GetSalesOldMachineProvider>(context);
    print(getOldMachineProvider.categories.length);
    final machines = getOldMachineProvider.categories;
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 20.h),
      child: getOldMachineProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0.h,
                mainAxisSpacing: 4.0.w,
                childAspectRatio: 0.750,
              ),
              itemCount: machines.length,
              itemBuilder: (context, index) {
                final machine = machines[index];
                return Card(
                  elevation: 6,
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: 150.h,
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://soft.madicaltrade.com/uploads/client_gallery/${machine.images?[0].clientpostImage}'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              machine.machineName.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              machine.machineCondition.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (_) =>SalesOldMachineDetailsView(item: machine)),
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: 25.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      color: ColorManager.black,
                                      borderRadius:BorderRadius.circular(AppSize.s5.r),
                                    ),
                                    child: Center(
                                      child: Text("Read More",
                                        style: FontManager.bodyText.copyWith(color: ColorManager.white,fontSize: 11.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

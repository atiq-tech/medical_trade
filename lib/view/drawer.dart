import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/controller/get_categories_api.dart';
import 'package:medical_trade/controller/login_auth.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:medical_trade/view/by_reagent_category_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/custom_drawer_subitem_container.dart';
import 'package:medical_trade/utilities/routes/routes_name.dart';
import 'package:medical_trade/utilities/sizebox_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isByReagentExpanded = false;
  String? userName;
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    userName = box.read('userName');
    // Fetch categories when the drawer is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetCategoriesProvider>(context, listen: false).fetchData();
    });
  }

  void _toggleByReagentModule() {
    setState(() {
      _isByReagentExpanded = !_isByReagentExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<GetCategoriesProvider>(context);

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(AppSize.s50.r),bottomRight: Radius.circular(AppSize.s50.r)),
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: AppSize.s150.h,
              width: double.infinity.w,
              color: ColorManager.white,
              child: Padding(
                padding: EdgeInsets.only(left: AppPadding.p12.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:const AssetImage("assets/icons/medical.png"),
                      radius: 35.r,
                    ),
                    SizedBoxManager.width12(),
                    Padding(
                      padding: EdgeInsets.only(top: 55.h),
                      child: Column(
                        children: [
                          Text("Medical Trade",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold)),
                          Text(
                            userName ?? "Unknown User",
                            maxLines: 1,
                            style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesName.home),
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.home, size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("My Page",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
                      const Spacer(),
                      Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesName.newMachine),
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.medical_information,size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("New Machine",style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                      const Spacer(),
                      Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesName.oldMachine),
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.history, size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("Old Machine",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
                      const Spacer(),
                      Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: _toggleByReagentModule,
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.support, size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("Buy Reagent",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
                      const Spacer(),
                      Icon(_isByReagentExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,size: 24.sp,color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            if (_isByReagentExpanded) ...[
              if (categoryProvider.isLoading) ...[
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorManager.red),
                  ),
                ),
              ] else ...[
                for (var category in categoryProvider
                    .getFilteredCategories(["4", "5", "6", "7"])) ...[
                  Divider(color: Colors.grey,height: 0.5.h),
                  CustomDrawerSubitem(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (_) => ByReagentCategoryView(item: category)));
                    },
                    color: const Color(0xFFBACCDF).withOpacity(0.6),
                    title: category.name,
                  ),
                  Divider(color: Colors.grey,height: 0.5.h),
                ],
              ],
            ],
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesName.engineeringSupport),
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.build, size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("Engineering Support",style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                      const Spacer(),
                      Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black,height: 0.5.h),
            InkWell(
              onTap: () =>Navigator.pushNamed(context, RoutesName.allAccessories),
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.category, size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("All Accessories",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
                      const Spacer(),
                      Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesName.others),
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.devices_other,size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("Dental Equipment",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
                      const Spacer(),
                      Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesName.salesOldMachine),
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.monetization_on,size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("Sales Old Machine",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
                      const Spacer(),
                      Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
            InkWell(
              onTap: () {
                context.read<LoginAuthProvider>().logout();
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginView(isLogin: true)),(Route<dynamic> route) => false, // Remove all previous routes
                );
              },
              child: SizedBox(
                height: AppSize.s35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 16.sp, color: Colors.black),
                      SizedBoxManager.width24(),
                      Text("Log Out",style: TextStyle(fontSize: 14.sp,color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,height: 0.5.h),
          ],
        ),
      ),
    );
  }
}






//old====
// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   bool _isByReagentExpanded = false;
//   String? userName;
//   @override
//   void initState() {
//     super.initState();
//     final box = GetStorage();
//     userName = box.read('userName');
//     // Fetch categories when the drawer is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<GetCategoriesProvider>(context, listen: false).fetchData();
//     });
//   }

//   void _toggleByReagentModule() {
//     setState(() {
//       _isByReagentExpanded = !_isByReagentExpanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categoryProvider = Provider.of<GetCategoriesProvider>(context);

//     return Drawer(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(topRight: Radius.circular(AppSize.s50.r),bottomRight: Radius.circular(AppSize.s50.r)),
//       ),
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Container(
//               height: AppSize.s150.h,
//               width: double.infinity.w,
//               color: ColorManager.white,
//               child: Padding(
//                 padding: EdgeInsets.only(left: AppPadding.p12.w),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.white,
//                       backgroundImage:const AssetImage("assets/icons/medical.png"),
//                       radius: 35.r,
//                     ),
//                     SizedBoxManager.width12(),
//                     Padding(
//                       padding: EdgeInsets.only(top: 55.h),
//                       child: Column(
//                         children: [
//                           Text("Medical Trade",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold)),
//                           Text(
//                             userName ?? "Unknown User",
//                             maxLines: 1,
//                             style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.black),
//                             overflow: TextOverflow.ellipsis,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: () => Navigator.pushNamed(context, RoutesName.home),
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.home, size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("My Page",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
//                       const Spacer(),
//                       Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: () => Navigator.pushNamed(context, RoutesName.newMachine),
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.medical_information,size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("New Machine",style: TextStyle(fontSize: 14.sp, color: Colors.black)),
//                       const Spacer(),
//                       Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: () => Navigator.pushNamed(context, RoutesName.oldMachine),
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.history, size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("Old Machine",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
//                       const Spacer(),
//                       Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: _toggleByReagentModule,
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(Icons.support, size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("Buy Reagent",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
//                       const Spacer(),
//                       Icon(_isByReagentExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,size: 24.sp,color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             if (_isByReagentExpanded) ...[
//               if (categoryProvider.isLoading) ...[
//                 Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(ColorManager.red),
//                   ),
//                 ),
//               ] else ...[
//                 for (var category in categoryProvider
//                     .getFilteredCategories(["4", "5", "6", "7"])) ...[
//                   Divider(color: Colors.grey,height: 0.5.h),
//                   CustomDrawerSubitem(
//                     onTap: () {
//                       Navigator.push(context,MaterialPageRoute(builder: (_) => ByReagentCategoryView(item: category)));
//                     },
//                     color: const Color(0xFFBACCDF).withOpacity(0.6),
//                     title: category.productCategoryName,
//                   ),
//                   Divider(color: Colors.grey,height: 0.5.h),
//                 ],
//               ],
//             ],
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: () => Navigator.pushNamed(context, RoutesName.engineeringSupport),
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.build, size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("Engineering Support",style: TextStyle(fontSize: 14.sp, color: Colors.black)),
//                       const Spacer(),
//                       Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.black,height: 0.5.h),
//             InkWell(
//               onTap: () =>Navigator.pushNamed(context, RoutesName.allAccessories),
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.category, size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("All Accessories",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
//                       const Spacer(),
//                       Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: () => Navigator.pushNamed(context, RoutesName.others),
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.devices_other,size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("Dental Equipment",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
//                       const Spacer(),
//                       Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: () => Navigator.pushNamed(context, RoutesName.salesOldMachine),
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.monetization_on,size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("Sales Old Machine",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
//                       const Spacer(),
//                       Icon(Icons.arrow_forward,size: 16.sp, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//             InkWell(
//               onTap: () {
//                 context.read<LoginAuthProvider>().logout();
//                 Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginView(isLogin: true)),(Route<dynamic> route) => false, // Remove all previous routes
//                 );
//               },
//               child: SizedBox(
//                 height: AppSize.s35.h,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Row(
//                     children: [
//                       Icon(Icons.logout, size: 16.sp, color: Colors.black),
//                       SizedBoxManager.width24(),
//                       Text("Log Out",style: TextStyle(fontSize: 14.sp,color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey,height: 0.5.h),
//           ],
//         ),
//       ),
//     );
//   }
// }

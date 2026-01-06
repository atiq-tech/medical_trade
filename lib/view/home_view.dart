import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/controller/contact_api.dart';
import 'package:medical_trade/diagnostic_module/screens/diagnostic_module_screen.dart';
import 'package:medical_trade/diagnostic_module/utils/permission_helper.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/diagnostic_module/utils/whats_up_fab.dart';
import 'package:medical_trade/new_part/providers/category_provider.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_container1.dart';
import 'package:medical_trade/utilities/custom_container_homepage.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:medical_trade/view/details.dart';
import 'package:medical_trade/view/engineering_support.dart';
import 'package:medical_trade/view/my_wall_post_view.dart';
import 'package:medical_trade/view/sales_your_old_machine_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool showLogoutButton = false;
  String? userName;
  String? userImageName;
  String? role;
static String getToken() {
  final box = GetStorage();
  return box.read('loginToken') ?? "";
}
String? doctorId = "";
getDoctorCode() async {
  try {
    String link = AppUrl.getDoctorCodeEndPoint;
    final token = getToken();

    var response = await Dio().get(
      link,
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
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginView(isLogin: true,)));
      return;
    }
    setState(() {
      doctorId = response.data["data"].toString();
    });
    print("doctorId ID =========> $doctorId");

  } catch (e) {
    print("doctorId ERROR =======> $e");
  }
}
  @override
  void initState(){
    getDoctorCode();
    final box = GetStorage();
    userName = box.read('username');
    userImageName = box.read('image');
    role = box.read('role');
    super.initState();
    CategoryProvider.isAllCategoriesLoading = true;
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    print("role ========== $role");
    final access1 = PermissionHelper.engineerSupport();
    final access2 = PermissionHelper.saleYourOldMachine();
    print("Engineer Access ======= $access1");
    print("Sales Old Machine Access ======= $access2");
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final allCategoriesData = categoryProvider.allCategoriesList;

    final contactProvider = Provider.of<ContactProvider>(context);
    if (contactProvider.companyProfile == null &&
        !contactProvider.isLoading) {
      contactProvider.fetchContact();
    }

    //final box = GetStorage();

    void onAppBarTitleTap() {
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const MyWallPostView()),(route) => false);
    }

    /// 🔹 Static Home Items (categories এর পরে আসবে)
    final List<Map<String, dynamic>> homeItems = [
      {
        'title': 'Engineering Support',
        'icon': ImageAssets.engineeringSupport,
        'page': const EngineeringSupport(),
      },
      {
        'title': 'Diagnostic Module',
        'icon': ImageAssets.diagModule,
        'page': const DiagnosticModuleScreen(),
      },
      {
        'title': 'Sales Your Machine',
        'icon': ImageAssets.oldMachineTwo,
        'page': const SalesYourOldMachineView(),
        'requireLogin': true,
      },
    ];

    final totalItemCount = allCategoriesData.length + homeItems.length;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: CustomAppBar(
        onTap: onAppBarTitleTap,
        title: "My Page",
      ),
      
      floatingActionButton: const WhatsAppFAB(phone:  "8801711781111"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 15.h,
            bottom: 75.h,
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: totalItemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {

              /// ================= CATEGORY SECTION =================
              if (index < allCategoriesData.length) {
                final category = allCategoriesData[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context) => Details(item: category)),
                  );
                  },
                  child: CustomContainerOne(
                    backgroundColor: Colors.white,
                    text: category.name ?? '',
                    textColor: ColorManager.black,
                    networkImageUrl: category.image != null && category.image!.isNotEmpty
                          ? "https://app.medicaltradeltd.com/${category.image}"
                          : null,
                  ),
                );
              }

              /// ================= STATIC HOME ITEMS =================
              final item = homeItems[index - allCategoriesData.length];

              return InkWell(
                onTap: () async {
                  final title = item['title'];
                  //final token = box.read('loginToken');

                  /// 🔹 Engineering Support (permission)
                  if (title == 'Engineering Support') {
                    final access = await PermissionHelper.engineerSupport();
                    if (access == "true" || role == "Admin" || role == "Super Admin") {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>const EngineeringSupport()),
                      );
                    } else {
                      showWarningDialog(context);
                    }
                  }
                  /// 🔹 Engineering Support (permission)
                  else if (title == 'Sales Your Machine') {
                     final access = await PermissionHelper.saleYourOldMachine();
                    if (access == "true"|| role == "Admin" || role == "Super Admin") {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>const SalesYourOldMachineView()),
                      );
                    } else {
                      showWarningDialog(context);
                    }
                  }

                  /// 🔹 Sales Your Old Machine (login + permission)
                 // else if (title == 'Sales Your Old Machine') {
                    // if (token == null) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (_) => AlertDialog(
                    //       title: const Text('Please Register'),
                    //       content: const Text(
                    //           'You need to register or log in to access this feature.'),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () {
                    //             Navigator.pushNamed(
                    //                 context, RoutesName.login);
                    //           },
                    //           child:
                    //               const Text('Register / Log In'),
                    //         ),
                    //         TextButton(
                    //           onPressed: () =>
                    //               Navigator.pop(context),
                    //           child: const Text('Cancel'),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    //   return;
                    // }

                  //   final access =
                  //       await PermissionHelper.saleYourOldMachine();
                  //   if (access == "true"|| role == "Admin" || role == "Super Admin") {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) =>
                  //               const SalesYourOldMachineView()),
                  //     );
                  //   } else {
                  //     showWarningDialog(context);
                  //   }
                  // }

                  /// 🔹 Diagnostic Module (no permission)
                  else {
                    Navigator.push(context,MaterialPageRoute(builder: (_) => item['page']),
                    );
                  }
                },
                child: CustomContainer(
                  backgroundColor: Colors.white,
                  text: item['title'],
                  textColor: ColorManager.black,
                  iconPath: item['icon'],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 45.h,
        color: ColorManager.black,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: contactProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : contactProvider.companyProfile != null
                ? Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Hot Line:",
                        style: FontManager
                            .smallTextbottomnavigaton
                            .copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _launchPhone(
                            "${contactProvider.companyProfile!.phone}"),
                        child: Text(
                          "${contactProvider.companyProfile!.phone}",
                          style: FontManager
                              .smallTextbottomnavigaton
                              .copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(uri);
  }
}













// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/controller/contact_api.dart';
// import 'package:medical_trade/diagnostic_module/screens/diagnostic_module_screen.dart';
// import 'package:medical_trade/diagnostic_module/utils/permission_helper.dart';
// import 'package:medical_trade/new_part/providers/category_provider.dart';
// import 'package:medical_trade/utilities/assets_manager.dart';
// import 'package:medical_trade/utilities/color_manager.dart';
// import 'package:medical_trade/utilities/custom_appbar.dart';
// import 'package:medical_trade/utilities/font_manager.dart';
// import 'package:medical_trade/utilities/routes/routes_name.dart';
// import 'package:medical_trade/view/engineering_support.dart';
// import 'package:medical_trade/view/my_wall_post_view.dart';
// import 'package:medical_trade/view/sales_your_old_machine_view.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:medical_trade/utilities/custom_container_homepage.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {


// @override
// void initState() {
//   super.initState();
//   CategoryProvider.isAllCategoriesLoading = true;
//   Provider.of<CategoryProvider>(context, listen: false).getCategories();
// }

//   @override
//   Widget build(BuildContext context) {
//     final allCategoriesData = Provider.of<CategoryProvider>(context).allCategoriesList;
//     print("Category length======${allCategoriesData.length}");

//     final contactProvider = Provider.of<ContactProvider>(context);

//     if (contactProvider.companyProfile == null &&
//         !contactProvider.isLoading) {
//       contactProvider.fetchContact();
//     }

//     void onAppBarTitleTap() {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const MyWallPostView()),
//         (route) => false,
//       );
//     }

//     final box = GetStorage();

//     final List<Map<String, dynamic>> homeItems = [
//       {
//         'title': 'Engineering Support',
//         'icon': ImageAssets.engineeringSupport,
//         'page': const EngineeringSupport(),
//       },
//       {
//         'title': 'Diagnostic Module',
//         'icon': ImageAssets.diagModule,
//         'page': const DiagnosticModuleScreen(),
//       },
//       {
//         'title': 'Sales Your Old Machine',
//         'icon': ImageAssets.oldMachineTwo,
//         'page': const SalesYourOldMachineView(),
//         'requireLogin': true,
//       },
//     ];
     

//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       appBar: CustomAppBar(
//         onTap: onAppBarTitleTap,
//         title: "My Page",
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15.w),
//           child: GridView.count(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             crossAxisCount: 2,
//             crossAxisSpacing: 8.w,
//             mainAxisSpacing: 8.h,
//             childAspectRatio: 1.2,
//             children: List.generate(homeItems.length, (index) {
//               final item = homeItems[index];

//               return InkWell(
//                 onTap: () async {
//                   final title = item['title'];
//                   final token = box.read('loginToken');

//                   /// 🔹 Engineering Support permission
//                   if (title == 'Engineering Support') {
//                     final access = await PermissionHelper.engineerSupport();
//                     if (access == "true") {
//                       Navigator.push( context, MaterialPageRoute( builder: (_) => const EngineeringSupport()),);
//                     } else {
//                       showWarningDialog(context);
//                     }
//                   }

//                   /// 🔹 Sales Your Old Machine (login + permission)
//                   else if (title == 'Sales Your Old Machine') {
//                     if (token == null) {
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('Please Register'),
//                           content: const Text(
//                               'You need to register or log in to access this feature.'),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushNamed(context, RoutesName.login);
//                               },
//                               child: const Text('Register / Log In'),
//                             ),
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Cancel'),
//                             ),
//                           ],
//                         ),
//                       );
//                       return;
//                     }

//                     final access = await PermissionHelper.saleYourOldMachine();
//                     if (access == "true") {
//                       Navigator.push( context,MaterialPageRoute( builder: (_) => const SalesYourOldMachineView()));
//                     } else {
//                       showWarningDialog(context);
//                     }
//                   }
//                   /// 🔹 Other items (no permission)
//                   else {
//                     Navigator.push(  context,MaterialPageRoute( builder: (_) => item['page']),
//                     );
//                   }
//                 },
//                 child: CustomContainer(
//                   backgroundColor: Colors.white,
//                   text: item['title'],
//                   textColor: ColorManager.black,
//                   iconPath: item['icon'],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 45.h,
//         color: ColorManager.black,
//         padding: EdgeInsets.symmetric(horizontal: 4.w),
//         child: contactProvider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : contactProvider.companyProfile != null
//                 ? Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         "Hot Line:",
//                         style: FontManager
//                             .smallTextbottomnavigaton
//                             .copyWith(
//                           color: Colors.white,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => _launchPhone(
//                             "${contactProvider.companyProfile!.phone}"),
//                         child: Text(
//                           "${contactProvider.companyProfile!.phone}",
//                           style: FontManager
//                               .smallTextbottomnavigaton
//                               .copyWith(
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : const SizedBox.shrink(),
//       ),
//     );
//   }
//   void _launchPhone(String phoneNumber) async {
//     final Uri uri =
//         Uri(scheme: 'tel', path: phoneNumber);
//     await launchUrl(uri);
//   }
// }






//old====
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/controller/contact_api.dart';
// import 'package:medical_trade/diagnostic_module/screens/diagnostic_module_screen.dart';
// import 'package:medical_trade/utilities/assets_manager.dart';
// import 'package:medical_trade/utilities/color_manager.dart';
// import 'package:medical_trade/utilities/custom_appbar.dart';
// import 'package:medical_trade/utilities/font_manager.dart';
// import 'package:medical_trade/utilities/routes/routes_name.dart';
// import 'package:medical_trade/view/by_reagent.dart';
// import 'package:medical_trade/view/engineering_support.dart';
// import 'package:medical_trade/view/my_wall_post_view.dart';
// import 'package:medical_trade/view/old_machine.dart';
// import 'package:medical_trade/view/others.dart';
// import 'package:medical_trade/view/sales_your_old_machine_view.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:medical_trade/utilities/values_manager.dart';
// import 'package:medical_trade/view/all_accessories.dart';
// import 'package:medical_trade/view/new_machine.dart';
// import 'package:medical_trade/utilities/custom_container_homepage.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<ContactProvider>(context);

//     if (contactProvider.contactModel == null && !contactProvider.isLoading) {
//       contactProvider.fetchContact();
//     }

//     void onAppBarTitleTap() {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const MyWallPostView()),
//         (Route<dynamic> route) => false,
//       );
//     }

//     final box = GetStorage();
//     final List<Map<String, dynamic>> homeItems = [
//       {
//         'title': 'New Machine',
//         'color': ColorManager.homeContainerOne,
//         'icon': ImageAssets.newMachine,
//         'page': const NewMachine(),
//       },
//       {
//         'title': 'Old Machine',
//         'color': const Color(0xFF0199A6),
//         'icon': ImageAssets.oldMachine,
//         'page': const OldMachine(),
//       },
//       {
//         'title': 'Buy Reagent',
//         'color': ColorManager.homeContainerSix,
//         'icon': ImageAssets.regalSupport,
//         'page': const ByReagent(),
//       },
//       {
//         'title': 'Engineering Support',
//         'color': const Color(0xFF398E3D),
//         'icon': ImageAssets.engineeringSupport,
//         'page': const EngineeringSupport(),
//       },
//       {
//         'title': 'All Accessories',
//         'color': const Color(0xFF9D29B1),
//         'icon': ImageAssets.allAccessories,
//         'page': const AllAccessories(),
//       },
//       {
//         'title': 'Dental Equipment',
//         'color': const Color(0xFF36474F),
//         'icon': ImageAssets.others,
//         'page': const Others(),
//       },
//       {
//         'title': 'Diagnostic Module',
//         'color': const Color.fromARGB(255, 141, 127, 2),
//         'icon': ImageAssets.diagModule,
//         'page': const DiagnosticModuleScreen(),
//       },
//       {
//         'title': 'Sales Your Old Machine',
//         'color': const Color.fromARGB(255, 221, 106, 71),
//         'icon': ImageAssets.oldMachineTwo,
//         'page': const SalesYourOldMachineView(),
//         'requireLogin': true, 
//       },
//     ];

//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       appBar: CustomAppBar(onTap: onAppBarTitleTap,title: "My Page"),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15.w),
//           child: GridView.count(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             crossAxisCount: 2,
//             crossAxisSpacing: 8.w,
//             mainAxisSpacing: 8.h,
//             childAspectRatio: 1.2,
//             children: homeItems.map((item) {
//               return InkWell(
//                 onTap: () {
//                   if (item['requireLogin'] == true) {
//                     final token = box.read('loginToken');
//                     if (token != null) {
//                       Navigator.push(context,MaterialPageRoute(builder: (_) => item['page']));
//                     } else {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: const Text('Please Register'),
//                           content: const Text('You need to register or log in to access this feature.'),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushNamed(context, RoutesName.login);
//                               },
//                               child: const Text('Register / Log In'),
//                             ),
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Cancel'),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   } else {
//                     Navigator.push(context,MaterialPageRoute(builder: (_) => item['page']));
//                   }
//                 },
//                 child: CustomContainer(
//                   backgroundColor: item['color'],
//                   text: item['title'],
//                   textColor: ColorManager.white,
//                   iconPath: item['icon'],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 45.h,
//         color: ColorManager.black,
//         padding: EdgeInsets.symmetric(horizontal: 4.w),
//         child: contactProvider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : contactProvider.contactModel != null
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         "Hot Line: ",
//                         style: FontManager.smallTextbottomnavigaton.copyWith(
//                           color: Colors.white,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => _launchPhone(contactProvider.contactModel!.hotlineOne ?? ''),
//                         child: Text(
//                           contactProvider.contactModel!.hotlineOne ?? '',
//                           style:FontManager.smallTextbottomnavigaton.copyWith(
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => _launchPhone(contactProvider.contactModel!.hotlineTwo ?? ''),
//                         child: Text(
//                           contactProvider.contactModel!.hotlineTwo ?? '',
//                           style:FontManager.smallTextbottomnavigaton.copyWith(
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : const SizedBox.shrink(),
//       ),
//     );
//   }
//   // ফোন কল করার ফাংশন
//   void _launchPhone(String phoneNumber) async {
//     final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
//     await launchUrl(launchUri);
//   }
// }



















///=================main old code==============
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/controller/contact_api.dart';
// import 'package:medical_trade/diagnostic_module/screens/diagnostic_module_screen.dart';
// import 'package:medical_trade/utilities/assets_manager.dart';
// import 'package:medical_trade/utilities/color_manager.dart';
// import 'package:medical_trade/utilities/custom_appbar.dart';
// import 'package:medical_trade/utilities/font_manager.dart';
// import 'package:medical_trade/utilities/routes/routes_name.dart';
// import 'package:medical_trade/view/by_reagent.dart';
// import 'package:medical_trade/view/engineering_support.dart';
// import 'package:medical_trade/view/my_wall_post_view.dart';
// import 'package:medical_trade/view/old_machine.dart';
// import 'package:medical_trade/view/others.dart';
// import 'package:medical_trade/view/sales_your_old_machine_view.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:medical_trade/utilities/values_manager.dart';
// import 'package:medical_trade/view/all_accessories.dart';
// import 'package:medical_trade/view/new_machine.dart';
// import 'package:medical_trade/utilities/custom_container_homepage.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<ContactProvider>(context);

//     // Fetch the contact data if it hasn't been loaded yet
//     if (contactProvider.contactModel == null && !contactProvider.isLoading) {
//       contactProvider.fetchContact();
//     }
//     void onAppBarTitleTap() {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const MyWallPostView(),
//         ),
//         (Route<dynamic> route) => false, // Remove all previous routes
//       );
//     }

//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       appBar: CustomAppBar(
//         onTap: onAppBarTitleTap,
//         title: "My Page",
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomContainer(
//                     backgroundColor: ColorManager.homeContainerOne,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const NewMachine(),
//                         ),
//                       );
//                     },
//                     text: "New Machine",
//                     textColor: ColorManager.white,
//                     iconPath: ImageAssets.newMachine,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const OldMachine(),
//                         ),
//                       );
//                     },
//                     child: CustomContainer(
//                       backgroundColor: const Color(0xFF0199A6),
//                       text: "Old Machine",
//                       textColor: ColorManager.white,
//                       iconPath: ImageAssets.oldMachine,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 6.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomContainer(
//                     backgroundColor: ColorManager.homeContainerSix,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const ByReagent(),
//                         ),
//                       );
//                     },
//                     text: "Buy Reagent",
//                     textColor: ColorManager.white,
//                     iconPath: ImageAssets.regalSupport,
//                   ),
//                   CustomContainer(
//                     backgroundColor: const Color(0xFF398E3D),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const EngineeringSupport(),
//                         ),
//                       );
//                     },
//                     text: "Engineering Support",
//                     textColor: ColorManager.white,
//                     iconPath: ImageAssets.engineeringSupport,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 6.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomContainer(
//                     backgroundColor: const Color(0xFF9D29B1),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const AllAccessories(),
//                         ),
//                       );
//                     },
//                     text: "All Accessories",
//                     textColor: ColorManager.white,
//                     iconPath: ImageAssets.allAccessories,
//                   ),
//                   CustomContainer(
//                     backgroundColor: const Color(0xFF36474F),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const Others(),
//                         ),
//                       );
//                     },
//                     text: "Dental Equipment",
//                     textColor: ColorManager.white,
//                     iconPath: ImageAssets.others,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 6.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CustomContainer(
//                     backgroundColor: const Color.fromARGB(255, 170, 153, 3),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const DiagnosticModuleScreen(),
//                         ),
//                       );
//                     },
//                     text: "Diagnostic Module",
//                     textColor: ColorManager.white,
//                     iconPath: ImageAssets.diagModule,
//                   ),
//                   SizedBox(width: 16.h),
//                   CustomContainer(
//                     backgroundColor: const Color.fromARGB(255, 221, 106, 71),
//                     onTap: () {
//                       final box = GetStorage();
//                       final token = box.read('loginToken');
                  
//                       if (token != null) {
//                         // User is logged in, navigate to the desired screen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const SalesYourOldMachineView(),
//                           ),
//                         );
//                       } else {
//                         // User is not logged in, show a popup
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Please Register'),
//                               content: const Text(
//                                   'You need to register or log in to access this feature.'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, RoutesName.login);
//                                   },
//                                   child: const Text('Register / Log In'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text('Cancel'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                     text: "Sales Your Old Machine",
//                     textColor: ColorManager.white,
//                     iconPath: ImageAssets.oldMachineTwo,
//                   ),
//                 ],
//               ),
//               SizedBox(height: AppMargin.m16.h),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 45.h,
//         color: ColorManager.black,
//         padding: EdgeInsets.symmetric(horizontal: 4.w),
//         child: contactProvider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : contactProvider.contactModel != null
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         "Hot Line: ",
//                         style: FontManager.smallTextbottomnavigaton.copyWith(
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       GestureDetector(
//                         onTap: () => _launchPhone(
//                             contactProvider.contactModel!.hotlineOne ?? ''),
//                         child: Text(
//                           contactProvider.contactModel!.hotlineOne ?? '',
//                           style: FontManager.smallTextbottomnavigaton.copyWith(
//                               color: Colors.white,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => _launchPhone(
//                             contactProvider.contactModel!.hotlineTwo ?? ''),
//                         child: Text(
//                           contactProvider.contactModel!.hotlineTwo ?? '',
//                           style: FontManager.smallTextbottomnavigaton.copyWith(
//                               color: Colors.white,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   )
//                 : const SizedBox.shrink(),
//       ),
//     );
//   }
// }

// // Function to launch the phone dialer
// void _launchPhone(String phoneNumber) async {
//   final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
//   await launchUrl(launchUri); // Ensure you have url_launcher package
// }

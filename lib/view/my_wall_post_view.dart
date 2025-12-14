// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:medical_trade/controller/contact_api.dart';
// import 'package:medical_trade/controller/wall_post_api.dart';
// import 'package:medical_trade/new_part/providers/wall_postnew_provider.dart';
// import 'package:medical_trade/utilities/assets_manager.dart';
// import 'package:medical_trade/utilities/color_manager.dart';
// import 'package:medical_trade/utilities/font_manager.dart';
// import 'package:medical_trade/utilities/zoom_screen.dart';
// import 'package:medical_trade/view/auth/login_register_auth.dart';
// import 'package:medical_trade/view/home_view.dart';
// import 'package:medical_trade/view/my_wall_products_details.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:medical_trade/utilities/values_manager.dart';
// import 'package:medical_trade/view/drawer.dart';

// class MyWallPostView extends StatefulWidget {
//   const MyWallPostView({super.key});

//   @override
//   State<MyWallPostView> createState() => _MyWallPostViewState();
// }

// class _MyWallPostViewState extends State<MyWallPostView> {
//   bool showLogoutButton = false;
//   String? userName;
//   String? userImageName;

//   @override
//   void initState() {
//     super.initState();
//     final box = GetStorage();
//     userName = box.read('userName');
//     userImageName = box.read('userImageName');
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WallPostApiProvider>(context, listen: false).fetchWallData();
//       Provider.of<ContactProvider>(context, listen: false).fetchContact();

//       //Provider.of<WallPostNewProvider>(context, listen: false).getWallPostNew();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<ContactProvider>(context);
//     final provider = Provider.of<WallPostApiProvider>(context);
//     final allWallPostData = provider.wallpostdata;
//     print("wallpost=====${allWallPostData.length}");

//     // Fetch the contact data if it hasn't been loaded yet
//     if (contactProvider.companyProfile == null && !contactProvider.isLoading) {
//       contactProvider.fetchContact();
//     }
//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       appBar: AppBar(
//         backgroundColor: ColorManager.appbarColor,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(
//               Icons.menu,
//               size: AppSize.s28.r,
//               color: ColorManager.black,
//             ),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//         leadingWidth: 35.0.w,
//         title: Padding(
//           padding: EdgeInsets.only(
//             top: AppPadding.p4.h,
//             bottom: AppPadding.p4.h,
//           ),
//           child: Row(
//             children: [
//               Image.asset(
//                 ImageAssets.appBarIcon,
//                 height: AppSize.s40.h,
//                 width: AppSize.s40.w,
//               ),
//               Text(
//                 "Medical Trade",
//                 style: FontManager.subheading,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: AppPadding.p12.w),
//             child: Stack(clipBehavior: Clip.none, children: [
//               Row(
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 32.w,
//                           height: 32.h,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 1.w),
//                             borderRadius: BorderRadius.circular(45.r),
//                             image: DecorationImage(
//                               image: userImageName != null
//                                   ? NetworkImage(
//                                       'https://soft.madicaltrade.com/uploads/customers/$userImageName')
//                                   : const AssetImage(ImageAssets.person)
//                                       as ImageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 100.w,
//                           child: Center(
//                             child: Text(
//                               userName ?? "Unknown User",
//                               maxLines: 1,
//                               style: TextStyle(
//                                 fontSize: 11.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         showLogoutButton = !showLogoutButton;
//                       });
//                     },
//                     child: Icon(
//                       Icons.arrow_drop_down,
//                       size: 28.sp,
//                     ),
//                   ),
//                 ],
//               ),
//               if (showLogoutButton)
//                 Positioned(
//                   top: 0.h,
//                   right: 0.w,
//                   child: Container(
//                     height: 50.h,
//                     width: 100.w,
//                     decoration: BoxDecoration(
//                       color: ColorManager.skyBlue,
//                       borderRadius: BorderRadius.circular(5.r),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const HomeView(),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: 8.w, right: 8.w, top: 2.h),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.file_copy,
//                                   size: 18.sp,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(width: 8.w),
//                                 Text(
//                                   "My Page",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Divider(
//                           color: Colors.white,
//                           height: 0.5.h,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Show confirmation dialog before logging out
//                             showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.r),
//                                 ),
//                                 title: Text(
//                                   "Logout...!",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                     fontSize: 22.sp,
//                                   ),
//                                 ),
//                                 content: Text(
//                                   "Are you sure you want to log out?",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 actions: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       TextButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             showLogoutButton =
//                                                 false; // Show logout button again
//                                           });
//                                           Navigator.pop(
//                                               context); // Close dialog
//                                         },
//                                         child: Container(
//                                           height: 40.h,
//                                           width: 50.w,
//                                           decoration: BoxDecoration(
//                                             color: Colors.blue,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.r),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               "No",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18.sp),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           // Perform logout operation here
//                                           final storage = GetStorage();
//                                           storage.erase().then((_) {
//                                             Navigator.pop(
//                                                 context); // Close dialog
//                                             Navigator.pushAndRemoveUntil(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const LoginView(
//                                                         isLogin: true),
//                                               ),
//                                               (Route<dynamic> route) =>
//                                                   false, // Remove all previous routes
//                                             );
//                                           });
//                                         },
//                                         child: Container(
//                                           height: 40.h,
//                                           width: 50.w,
//                                           decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.r),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               "Yes",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18.sp),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: 8.w, right: 8.w, bottom: 4.h),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.logout,
//                                   size: 18.sp,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(width: 8.w),
//                                 Text(
//                                   "Logout",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ]),
//           ),
//         ],
//       ),
//       drawer: const CustomDrawer(),
//       body: WallPostNewProvider.isWallPostNewLoading
//           ? const Center(child: CircularProgressIndicator())

//           : allWallPostData.isEmpty ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                      Icon(
//                       Icons.shopping_bag_outlined,
//                       size: 80.sp,
//                       color: Colors.grey[400],
//                     ),
//                      SizedBox(height: 16.h),
//                      Text(
//                       "No products available",
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                      SizedBox(height: 8.h),
//                      Text(
//                       "Check back later!",
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                      SizedBox(height: 8.h),
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeView()),
//                         );
//                       },
//                       child: Container(
//                         padding:  EdgeInsets.symmetric(
//                             horizontal: 12.w, vertical: 8.h),
//                         decoration:  BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(8.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.blue.withOpacity(0.3),
//                               spreadRadius: 2,
//                               blurRadius: 8,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           "Continue My Page",
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     )
//                   ],
//                 ))

//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   crossAxisSpacing: 10.0.h,
//                   mainAxisSpacing: 4.0.w,
//                   childAspectRatio: 0.750,
//                 ),
//                 itemCount: allWallPostData.length,
//                 itemBuilder: (context, index) {
//                 final item = allWallPostData[index];

//                   return Card(
//                   elevation: 7,
//                   color: Colors.grey.shade200,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ImageZoomScreen(
//                                   imageUrl:
//                                       'https://app.medicaltradeltd.com/${item.image}',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             height: 150.h,
//                             width: double.infinity.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(10.r),
//                               ),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(10.r)),
//                               child: Image.network(
//                                 'https://app.medicaltradeltd.com/${item.image}',
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (BuildContext context,
//                                     Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child;
//                                   }
//                                   return Center(
//                                     child: SizedBox(
//                                       width: 24.w,
//                                       height: 24.h,
//                                       child: CircularProgressIndicator(
//                                         value: loadingProgress
//                                                     .expectedTotalBytes !=
//                                                 null
//                                             ? loadingProgress
//                                                     .cumulativeBytesLoaded /
//                                                 loadingProgress
//                                                     .expectedTotalBytes!
//                                             : null,
//                                         strokeWidth: 2.0,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Center(
//                                         child: Icon(Icons.error, size: 24.w)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsets.only(top: 6.h, left: 8.w, right: 8.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               item.title.toString(),
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               "\$ ${item.wallPostId}",
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.green,
//                               ),
//                             ),
//                             SizedBox(height: 8.h),
//                             Align(
//                               alignment: Alignment.center,
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           MyWallProductsDetails(item: item),
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   elevation: 5,
//                                   child: Container(
//                                     height: 25.h,
//                                     width: 80.w,
//                                     decoration: BoxDecoration(
//                                       color: ColorManager.black,
//                                       borderRadius:
//                                           BorderRadius.circular(AppSize.s5.r),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "Details",
//                                         style: FontManager.bodyText.copyWith(
//                                             color: ColorManager.white,
//                                             fontSize: 11.sp),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 12.h),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//                 },
//               ),
//             ),
   
//       bottomNavigationBar: Container(
//         height: 45.h,
//         color: ColorManager.black,
//         padding: EdgeInsets.symmetric(
//           horizontal: 4.w,
//         ),
//         child: contactProvider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : contactProvider.companyProfile != null
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
//                         onTap: () => _launchPhone("${contactProvider.companyProfile!.phone}"),
//                         child: Text("${contactProvider.companyProfile!.phone}",
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
//   await launchUrl(launchUri);
// }























//old===
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/controller/contact_api.dart';
import 'package:medical_trade/controller/wall_post_api.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/zoom_screen.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:medical_trade/view/home_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/view/drawer.dart';
import 'my_wall_products_details.dart';

class MyWallPostView extends StatefulWidget {
  const MyWallPostView({super.key});

  @override
  State<MyWallPostView> createState() => _MyWallPostViewState();
}

class _MyWallPostViewState extends State<MyWallPostView> {
  bool showLogoutButton = false;
  String? userName;
  String? userImageName;

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    //userName = box.read('userName');
    //userImageName = box.read('userImageName');
    userName = box.read('username');
    userImageName = box.read('image');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WallPostApiProvider>(context, listen: false).fetchWallData();
      Provider.of<ContactProvider>(context, listen: false).fetchContact();
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    // Fetch the contact data if it hasn't been loaded yet
    if (contactProvider.companyProfile == null && !contactProvider.isLoading) {
      contactProvider.fetchContact();
    }
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.appbarColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              size: AppSize.s28.r,
              color: ColorManager.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        leadingWidth: 35.0.w,
        title: Padding(
          padding: EdgeInsets.only(
            top: AppPadding.p4.h,
            bottom: AppPadding.p4.h,
          ),
          child: Row(
            children: [
              Image.asset(
                ImageAssets.appBarIcon,
                height: AppSize.s40.h,
                width: AppSize.s40.w,
              ),
              Text(
                "Medical Trade",
                style: FontManager.subheading,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppPadding.p12.w),
            child: Stack(clipBehavior: Clip.none, children: [
              Row(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.w),
                            borderRadius: BorderRadius.circular(45.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45.r),
                            child: userImageName != null &&
                                    userImageName.toString().isNotEmpty &&
                                    userImageName != 'null'
                                ? Image.network(
                                    'https://app.madicaltrade.com/uploads/customers/$userImageName',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        ImageAssets.person,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    ImageAssets.person,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Center(
                            child: Text(
                              userName ?? "Unknown User",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showLogoutButton = !showLogoutButton;
                      });
                    },
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 28.sp,
                    ),
                  ),
                ],
              ),
              if (showLogoutButton)
                Positioned(
                  top: 0.h,
                  right: 0.w,
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: ColorManager.skyBlue,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, top: 2.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_copy,
                                  size: 18.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "My Page",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          height: 0.5.h,
                        ),
                        InkWell(
                          onTap: () {
                            // Show confirmation dialog before logging out
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                title: Text(
                                  "Logout...!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22.sp,
                                  ),
                                ),
                                content: Text(
                                  "Are you sure you want to log out?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            showLogoutButton =
                                                false; // Show logout button again
                                          });
                                          Navigator.pop(
                                              context); // Close dialog
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Perform logout operation here
                                          final storage = GetStorage();
                                          storage.erase().then((_) {
                                            Navigator.pop(
                                                context); // Close dialog
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginView(
                                                        isLogin: true),
                                              ),
                                              (Route<dynamic> route) =>
                                                  false, // Remove all previous routes
                                            );
                                          });
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, bottom: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 18.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ]),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.only(
          left: 8.w,
          right: 12.w,
          top: 8.h,
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 20.h),
          child: Consumer<WallPostApiProvider>(
              builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.wallpostdata.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 80.sp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "No products available",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Check back later!",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          "Continue My Page",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0.h,
                mainAxisSpacing: 4.0.w,
                childAspectRatio: 0.750,
              ),
              itemCount: provider.wallpostdata.length,
              itemBuilder: (context, index) {
                final product = provider.wallpostdata[index];
                return Card(
                  elevation: 7,
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageZoomScreen(
                                  imageUrl:
                                      'https://app.medicaltradeltd.com/${product.image}',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 150.h,
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.r),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.r)),
                              child: Image.network(
                                'https://app.medicaltradeltd.com/${product.image}',
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: SizedBox(
                                      width: 24.w,
                                      height: 24.h,
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(
                                        child: Icon(Icons.error, size: 24.w)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 6.h, left: 8.w, right: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.title.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\$ ${product.wallPostId}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MyWallProductsDetails(item: product),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: 25.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: ColorManager.black,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s5.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Details",
                                        style: FontManager.bodyText.copyWith(
                                            color: ColorManager.white,
                                            fontSize: 11.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        height: 45.h,
        color: ColorManager.black,
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: contactProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : contactProvider.companyProfile != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Hot Line: ",
                        style: FontManager.smallTextbottomnavigaton.copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => _launchPhone(
                            contactProvider.companyProfile!.phone ?? ''),
                        child: Text(
                          contactProvider.companyProfile!.phone ?? '',
                          style: FontManager.smallTextbottomnavigaton.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () => _launchPhone(
                      //       contactProvider.contactModel!.hotlineTwo ?? ''),
                      //   child: Text(
                      //     contactProvider.contactModel!.hotlineTwo ?? '',
                      //     style: FontManager.smallTextbottomnavigaton.copyWith(
                      //         color: Colors.white,
                      //         fontSize: 16.sp,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                    ],
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}

// Function to launch the phone dialer
void _launchPhone(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(launchUri);
}

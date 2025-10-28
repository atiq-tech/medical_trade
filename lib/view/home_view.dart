import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/controller/contact_api.dart';
import 'package:medical_trade/diagonostic_module/screens/diagnostic_module_screen.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/routes/routes_name.dart';
import 'package:medical_trade/view/by_reagent.dart';
import 'package:medical_trade/view/engineering_support.dart';
import 'package:medical_trade/view/my_wall_post_view.dart';
import 'package:medical_trade/view/old_machine.dart';
import 'package:medical_trade/view/others.dart';
import 'package:medical_trade/view/sales_your_old_machine_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/view/all_accessories.dart';
import 'package:medical_trade/view/new_machine.dart';
import 'package:medical_trade/utilities/custom_container_homepage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    // Fetch the contact data if it hasn't been loaded yet
    if (contactProvider.contactModel == null && !contactProvider.isLoading) {
      contactProvider.fetchContact();
    }
    void onAppBarTitleTap() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyWallPostView(),
        ),
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    }

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: CustomAppBar(
        onTap: onAppBarTitleTap,
        title: "My Page",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    backgroundColor: ColorManager.homeContainerOne,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NewMachine(),
                        ),
                      );
                    },
                    text: "New Machine",
                    textColor: ColorManager.white,
                    iconPath: ImageAssets.newMachine,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OldMachine(),
                        ),
                      );
                    },
                    child: CustomContainer(
                      backgroundColor: const Color(0xFF0199A6),
                      text: "Old Machine",
                      textColor: ColorManager.white,
                      iconPath: ImageAssets.oldMachine,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    backgroundColor: ColorManager.homeContainerSix,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ByReagent(),
                        ),
                      );
                    },
                    text: "Buy Reagent",
                    textColor: ColorManager.white,
                    iconPath: ImageAssets.regalSupport,
                  ),
                  CustomContainer(
                    backgroundColor: const Color(0xFF398E3D),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EngineeringSupport(),
                        ),
                      );
                    },
                    text: "Engineering Support",
                    textColor: ColorManager.white,
                    iconPath: ImageAssets.engineeringSupport,
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    backgroundColor: const Color(0xFF9D29B1),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllAccessories(),
                        ),
                      );
                    },
                    text: "All Accessories",
                    textColor: ColorManager.white,
                    iconPath: ImageAssets.allAccessories,
                  ),
                  CustomContainer(
                    backgroundColor: const Color(0xFF36474F),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Others(),
                        ),
                      );
                    },
                    text: "Dental Equipment",
                    textColor: ColorManager.white,
                    iconPath: ImageAssets.others,
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomContainer(
                    backgroundColor: const Color.fromARGB(255, 170, 153, 3),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DiagnosticModuleScreen(),
                        ),
                      );
                    },
                    text: "Diagnostic Module",
                    textColor: ColorManager.white,
                    iconPath: ImageAssets.diagModule,
                  ),
                  SizedBox(width: 16.h),
                  CustomContainer(
                    backgroundColor: const Color.fromARGB(255, 221, 106, 71),
                    onTap: () {
                      final box = GetStorage();
                      final token = box.read('loginToken');
                  
                      if (token != null) {
                        // User is logged in, navigate to the desired screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SalesYourOldMachineView(),
                          ),
                        );
                      } else {
                        // User is not logged in, show a popup
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Please Register'),
                              content: const Text(
                                  'You need to register or log in to access this feature.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RoutesName.login);
                                  },
                                  child: const Text('Register / Log In'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    text: "Sales Your Old Machine",
                    textColor: ColorManager.white,
                    iconPath: ImageAssets.oldMachineTwo,
                  ),
                ],
              ),
              SizedBox(height: AppMargin.m16.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 45.h,
        color: ColorManager.black,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: contactProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : contactProvider.contactModel != null
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
                            contactProvider.contactModel!.hotlineOne ?? ''),
                        child: Text(
                          contactProvider.contactModel!.hotlineOne ?? '',
                          style: FontManager.smallTextbottomnavigaton.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _launchPhone(
                            contactProvider.contactModel!.hotlineTwo ?? ''),
                        child: Text(
                          contactProvider.contactModel!.hotlineTwo ?? '',
                          style: FontManager.smallTextbottomnavigaton.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
  await launchUrl(launchUri); // Ensure you have url_launcher package
}

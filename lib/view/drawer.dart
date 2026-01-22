import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/diagnostic_module/screens/bank_transaction_report_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/cash_transaction_report_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/diagnostic_module_screen.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/view/auth/profile_screen.dart';
import 'package:medical_trade/view/engineering_support.dart';
import 'package:medical_trade/view/sales_your_old_machine_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:medical_trade/controller/login_auth.dart';
import 'package:medical_trade/diagnostic_module/utils/permission_helper.dart';
import 'package:medical_trade/new_part/providers/category_provider.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:medical_trade/utilities/routes/routes_name.dart';
import 'package:medical_trade/utilities/sizebox_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';

// ===== Diagnostic Screens =====
import 'package:medical_trade/diagnostic_module/screens/patient_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/doctor_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/test_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/doctor_list_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_list_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/appointment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/cash_transaction_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/bank_transaction_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/commission_payment_entry_screen.dart';
import 'package:medical_trade/diagnostic_module/screens/patient_payment_entry_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? role;
  String? userName;
  String? name;
  bool _isDiagnosticOpen = false;

  final List<String> diagnosticTitles = [
    "Patient Entry",
    "Doctor Entry",
    "Test Entry",
    "Doctor List",
    "Patient List",
    "Appointment Entry",
    "Cash Transaction Entry",
    "Bank Transaction Entry",
    "Commission Payment",
    "Patient Payment",
    "Cash Transaction Report",
    "Bank Transaction Report",
  ];

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    userName = box.read('username');
    name = box.read('name');
    role = box.read('role');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.s50.r),
          bottomRight: Radius.circular(AppSize.s50.r),
        ),
      ),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ================= HEADER =================
              Container(
                height: AppSize.s150.h,
                width: double.infinity,
                padding: EdgeInsets.only(left: AppPadding.p12.w),
                color: ColorManager.appbarColor,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35.r,
                      backgroundImage:
                          const AssetImage("assets/icons/medical.png"),
                    ),
                    SizedBoxManager.width12(),
                    Padding(
                      padding: EdgeInsets.only(top: 55.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medical Trade",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            name ?? "Unknown User",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          
              Divider(height: 0.5.h),
              /// ================= MY PAGE =================
              _drawerItem(
                icon: Icons.home,
                title: "My Page",
                onTap: () => Navigator.pushNamed(context, RoutesName.home),
              ),
              Divider(height: 0.5.h),
              /// ================= Wall Post PAGE =================
              _drawerItem(
                icon: Icons.wallpaper,
                title: "Wall Post Page",
                onTap: () => Navigator.pushNamed(context, RoutesName.myWallPost),
              ),
              Divider(height: 0.5.h),
              /// ================= ENGINEERING SUPPORT =================
              _drawerItem(
                icon: Icons.build,
                title: "Engineering Support",
                onTap: () async {
                  final access = await PermissionHelper.engineerSupport();
                  if (access == "true" || role == "Admin" || role == "Super Admin") {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>const EngineeringSupport()),
                      );
                    } else {
                      showWarningDialog(context);
                    }
                },
              ),
              Divider(height: 0.5.h),
              /// ================= SALES OLD MACHINE =================
              _drawerItem(
                icon: Icons.monetization_on,
                title: "Sales Your Machine",
                onTap: () async {
                  final access = await PermissionHelper.saleYourOldMachine();
                  if (access == "true" || role == "Admin" || role == "Super Admin") {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>const SalesYourOldMachineView()),
                      );
                    } else {
                      showWarningDialog(context);
                    }
                },
              ),
              Divider(height: 0.5.h),  
              /// ================= DIAGNOSTIC MODULE =================
              InkWell(
                onTap: () {
                  setState(() {
                    _isDiagnosticOpen = !_isDiagnosticOpen;
                  });
                },
                child: SizedBox(
                  height: AppSize.s35.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Icon(Icons.category, size: 16.sp),
                        SizedBoxManager.width24(),
                        Text("Diagnostic Module", style: TextStyle(fontSize: 14.sp)),
                        const Spacer(),
                        Icon(_isDiagnosticOpen? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _isDiagnosticOpen? Divider(height: 0.5.h):SizedBox(),
              /// ================= DIAGNOSTIC CHILD =================
              if (_isDiagnosticOpen)
              Column(children: diagnosticTitles.map((title) => _diagnosticItem(title)).toList()),
               Divider(height: 0.5.h),
              /// ================= LOGOUT =================
              _drawerItem(
                icon: Icons.person,
                title: "Profile",
                showArrow: false,
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => ProfileScreen()));
                },
              ),
              Divider(height: 0.5.h),
              /// ================= LOGOUT =================
              _drawerItem(
                icon: Icons.logout,
                title: "Log Out",
                showArrow: false,
                onTap: () {
                  context.read<LoginAuthProvider>().logout();
                  Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_) => const LoginView(isLogin: true)),(_) => false,
                  );
                },
              ),
              Divider(height: 0.5.h),
            ],
          ),
        ),
      ),
    );
  }
  /// ================= DRAWER ITEM =================
  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: AppSize.s35.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Icon(icon, size: 16.sp),
              SizedBoxManager.width24(),
              Text(title, style: TextStyle(fontSize: 14.sp)),
              const Spacer(),
              if (showArrow)
                Icon(Icons.arrow_forward, size: 16.sp),
            ],
          ),
        ),
      ),
    );
  }
  /// ================= DIAGNOSTIC ITEM =================
  Widget _diagnosticItem(String title) {
    return InkWell(
      onTap: () async => _handleDiagnosticNavigation(title),
      child: Padding(
        padding:EdgeInsets.only(left: 56.w, right: 24.w, top: 0.h, bottom:5.h),
        child: Row(
          children: [
            Icon(Icons.circle, size: 6.sp),
            SizedBox(width: 12.w),
            Text(title, style: TextStyle(fontSize: 13.sp)),
            
          ],
        ),
      ),
    );
  }
  /// ================= NAVIGATION LOGIC =================
  Future<void> _handleDiagnosticNavigation(String title) async {
    if (title == "Patient Entry") {
      final access = await PermissionHelper.patientEntry();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => PatientEntryScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Doctor Entry") {
      final access = await PermissionHelper.doctorEntry();
      if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => DoctorEntryScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Test Entry") {
      final access = await PermissionHelper.testEntry();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => TestEntryScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Doctor List") {
      final access = await PermissionHelper.doctorEntry();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => DoctorListScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Patient List") {
      final access = await PermissionHelper.patientList();
      if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => PatientListScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Appointment Entry") {
      final access = await PermissionHelper.appointmentEntry();
      if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => AppointmentEntryScreen()));
      } else {
        showWarningDialog(context);
      }
          
    } else if (title == "Cash Transaction Entry") {
      final access = await PermissionHelper.cashTrEntry();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => CashTransactionEntryScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Bank Transaction Entry") {
      final access = await PermissionHelper.bankTrEntry();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => BankTransactionEntryScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Commission Payment") {
      final access = await PermissionHelper.commissionPayment();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => CommissionPaymentEntryScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Patient Payment") {
      final access = await PermissionHelper.patientPayment();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => PatientPaymentEntryScreen()));
      } else {
        showWarningDialog(context);
      }

    } else if (title == "Cash Transaction Report") {
      final access = await PermissionHelper.cashTrReport();
       if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => CashTransactionReportScreen()));
      } else {
        showWarningDialog(context);
      }

     } else if (title == "Bank Transaction Report") {
      final access = await PermissionHelper.bankTrReport();
      if (access == "true" || role == "Admin" || role == "Super Admin") {
         Navigator.push(context,MaterialPageRoute(builder: (_) => BankTransactionReportScreen()));
      } else {
        showWarningDialog(context);
      }
    }
  }
}

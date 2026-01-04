import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/client_wall_product_buy_api.dart';
import 'package:medical_trade/controller/contact_api.dart';
import 'package:medical_trade/controller/customer_product_buy_api.dart';
import 'package:medical_trade/controller/slider_controller.dart';
import 'package:medical_trade/controller/wall_post_api.dart';
import 'package:medical_trade/diagnostic_module/providers/accounts_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/agents_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/available_slots_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/bank_account_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/bank_transaction_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/cash_transaction_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/commission_payment_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/department_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/doctors_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/patient_payment_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/patients_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/specimens_provider.dart';
import 'package:medical_trade/diagnostic_module/providers/test_entry_provider.dart';
import 'package:medical_trade/new_part/providers/all_products_provider.dart';
import 'package:medical_trade/new_part/providers/category_provider.dart';
import 'package:medical_trade/new_part/providers/client_post_provider.dart';
import 'package:medical_trade/new_part/providers/wall_postnew_provider.dart';
import 'package:medical_trade/utilities/custom_error_message.dart';
import 'package:medical_trade/controller/engineering_support_api.dart';
import 'package:medical_trade/controller/engineering_support_post_api.dart';
import 'package:medical_trade/controller/get_categories_api.dart';
import 'package:medical_trade/controller/get_client_post_api.dart';
import 'package:medical_trade/controller/get_district_api.dart';
import 'package:medical_trade/controller/get_division_api.dart';
import 'package:medical_trade/controller/get_product_api_category.dart';
import 'package:medical_trade/controller/get_sales_old_machine_api.dart';
import 'package:medical_trade/controller/login_auth.dart';
import 'package:medical_trade/controller/product_api_id_type.dart';
import 'package:medical_trade/controller/register_auth.dart';
import 'package:medical_trade/controller/sales_old_machine_post_api.dart';
import 'package:provider/provider.dart';
import 'package:medical_trade/utilities/routes/routes.dart';
import 'package:medical_trade/utilities/routes/routes_name.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      CustomErrorToast.show(
        text: "No internet connection",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetCategoriesProvider()),
        ChangeNotifierProvider(create: (_) => GetCategoryProductProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (_) => LoginAuthProvider()),
        ChangeNotifierProvider(create: (_) => RegisterAuthProvider()),
        ChangeNotifierProvider(create: (_) => ClientPostProvider()),
        ChangeNotifierProvider(create: (_) => DivisionProvider()),
        ChangeNotifierProvider(create: (_) => DistrictProvider()),
        ChangeNotifierProvider(create: (_) => WallPostApiProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProductBuyApi()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        ChangeNotifierProvider(create: (_) => EngineeringSupportProvider()),
        ChangeNotifierProvider(create: (_) => ClientWallProductBuyProvider()),
        ChangeNotifierProvider(create: (_) => GetClientPostProvider()),
        ChangeNotifierProvider(create: (_) => GetEngineerSupportProductProvider()),
        ChangeNotifierProvider(create: (_) => GetSalesOldMachineProvider()),

        ///======new part
        ChangeNotifierProvider<AgentsProvider>(create: (_) => AgentsProvider()),
        ChangeNotifierProvider<DoctorsProvider>(create: (_) => DoctorsProvider()),
        ChangeNotifierProvider<CategoryProvider>(create: (_) => CategoryProvider()),
        ChangeNotifierProvider<PatientsProvider>(create: (_) => PatientsProvider()),
        ChangeNotifierProvider<AccountsProvider>(create: (_) => AccountsProvider()),
        ChangeNotifierProvider<TestEntryProvider>(create: (_) => TestEntryProvider()),
        ChangeNotifierProvider<SpecimensProvider>(create: (_) => SpecimensProvider()),
        ChangeNotifierProvider<DepartmentProvider>(create: (_) => DepartmentProvider()),
        ChangeNotifierProvider<BankAccountProvider>(create: (_) => BankAccountProvider()),
        ChangeNotifierProvider<WallPostNewProvider>(create: (_) => WallPostNewProvider()),
        ChangeNotifierProvider<AllProductsProvider>(create: (_) => AllProductsProvider()),
        ChangeNotifierProvider<NewClientPostProvider>(create: (_) => NewClientPostProvider()),
        ChangeNotifierProvider<AvailableSlotsProvider>(create: (_) => AvailableSlotsProvider()),
        ChangeNotifierProvider<PatientPaymentProvider>(create: (_) => PatientPaymentProvider()),
        ChangeNotifierProvider<CashTransactionProvider>(create: (_) => CashTransactionProvider()),
        ChangeNotifierProvider<BankTransactionProvider>(create: (_) => BankTransactionProvider()),
        ChangeNotifierProvider<CommissionPaymentProvider>(create: (_) => CommissionPaymentProvider()),
        
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp(
          navigatorKey: CustomErrorToast.navigatorKey,
          title: 'Medical Trade',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: Routes.generateRoute,
          initialRoute: GetStorage().read('loginToken') != null
              ? RoutesName.myWallPost
              : RoutesName.splash,
        ),
      ),
    );
  }
}

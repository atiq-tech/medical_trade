import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/client_wall_product_buy_api.dart';
import 'package:medical_trade/controller/contact_api.dart';
import 'package:medical_trade/controller/customer_product_buy_api.dart';
import 'package:medical_trade/controller/slider_controller.dart';
import 'package:medical_trade/controller/wall_post_api.dart';
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
  // ignore: library_private_types_in_public_api
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
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
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
        ChangeNotifierProvider(
            create: (_) => GetEngineerSupportProductProvider()),
        ChangeNotifierProvider(create: (_) => GetSalesOldMachineProvider()),
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
          initialRoute: RoutesName.myWallPost,
          // initialRoute: GetStorage().read('loginToken') != null
          //     ? RoutesName.myWallPost
          //     : RoutesName.splash,
        ),
      ),
    );
  }
}

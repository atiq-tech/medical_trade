import 'package:flutter/material.dart';
import 'package:medical_trade/diagnostic_module/screens/diagnostic_module_screen.dart';
import 'package:medical_trade/utilities/routes/routes_name.dart';
import 'package:medical_trade/view/all_accessories.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:medical_trade/view/by_reagent.dart';
import 'package:medical_trade/view/engineering_support.dart';
import 'package:medical_trade/view/home_view.dart';
import 'package:medical_trade/view/my_wall_post_view.dart';
import 'package:medical_trade/view/new_machine.dart';
import 'package:medical_trade/view/old_machine.dart';
import 'package:medical_trade/view/others.dart';
import 'package:medical_trade/view/sales_your_old_machine_view.dart';
import 'package:medical_trade/view/splash/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case RoutesName.splashTwo:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyWallPostView());
      case RoutesName.myWallPost:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyWallPostView());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView(
                  isLogin: true,
                ));

      // case RoutesName.register:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const LoginView());

      case RoutesName.logOut:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView(isLogin: false));

      case RoutesName.newMachine:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NewMachine());

      case RoutesName.oldMachine:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OldMachine());

      case RoutesName.regalSupport:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ByReagent());

      case RoutesName.engineeringSupport:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EngineeringSupport());

      case RoutesName.allAccessories:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AllAccessories());

      case RoutesName.others:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Others());

      case RoutesName.salesOldMachine:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SalesYourOldMachineView());

      case RoutesName.diagnosticModule:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DiagnosticModuleScreen());

      // case RoutesName.diagnostic:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const ClinicalMachineNewMachine());
      //      case RoutesName.diagnosticDetailsView:
      // return MaterialPageRoute(
      //     builder: (BuildContext context) => const DiagnosticDetailsView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}

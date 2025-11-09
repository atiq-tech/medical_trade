import 'package:flutter/material.dart';
import 'package:medical_trade/model/get_categories_model.dart';
import 'package:medical_trade/view/details.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_container_homepage.dart';
import 'package:medical_trade/utilities/sizebox_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/controller/get_categories_api.dart';


class NewMachine extends StatefulWidget {
  const NewMachine({super.key});

  @override
  State<NewMachine> createState() => _NewMachineState();
}

class _NewMachineState extends State<NewMachine> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch the categories when the widget is initialized
      Provider.of<GetCategoriesProvider>(context, listen: false).fetchData();
    });
  }

  void _onAppBarTitleTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetCategoriesProvider>(context);
    final categories = provider.getFilteredCategories(["1", "2"]);

    if (categories.isEmpty) {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: CustomAppBar(
          onTap: _onAppBarTitleTap,
          title: "New Machine",
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Clinical Machine
    final clinicalMachine = categories.firstWhere(
      (category) => category.id.toString() == "1",
      orElse: () => GetCategoryModel(
        id: "1",
        name: "Category 1",
        description: "",
        createdBy: "0",
        updatedBy: "0",
        ipAddress: "",
        branchId: "0",
        deletedAt: "",
        createdAt: "",
        updatedAt: "",
      ),
    );

    // Pathology Machine
    final pathologyMachine = categories.firstWhere(
      (category) => category.id.toString() == "2",
      orElse: () => GetCategoryModel(
        id: "2",
        name: "Category 2",
        description: "",
        createdBy: "0",
        updatedBy: "0",
        ipAddress: "",
        branchId: "0",
        deletedAt: "",
        createdAt: "",
        updatedAt: "",
      ),
    );

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: CustomAppBar(
        onTap: _onAppBarTitleTap,
        title: "New Machine",
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: AppPadding.p16.h, left: 12.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomContainer(
                backgroundColor: ColorManager.homeContainerSix,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                        item: clinicalMachine,
                        categoryType: "new",
                      ),
                    ),
                  );
                },
                text: clinicalMachine.name,
                textColor: ColorManager.white,
                iconPath: ImageAssets.diagnostic,
              ),
            ),
            SizedBoxManager.width(AppMargin.m8),
            Expanded(
              child: CustomContainer(
                backgroundColor: const Color.fromARGB(255, 152, 201, 154),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                        item: pathologyMachine,
                        categoryType: "new",
                      ),
                    ),
                  );
                },
                text: pathologyMachine.name,
                textColor: ColorManager.white,
                iconPath: ImageAssets.pathology,
              ),
            ),
          ],
        ),
      ),
    );
  }
}








//old====
// import 'package:flutter/material.dart';
// import 'package:medical_trade/model/get_categories_model.dart';
// import 'package:medical_trade/utilities/routes/routes_name.dart';
// import 'package:medical_trade/view/details.dart';
// import 'package:medical_trade/view/home_view.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:medical_trade/utilities/assets_manager.dart';
// import 'package:medical_trade/utilities/color_manager.dart';
// import 'package:medical_trade/utilities/custom_appbar.dart';
// import 'package:medical_trade/utilities/custom_container_homepage.dart';
// import 'package:medical_trade/utilities/sizebox_manager.dart';
// import 'package:medical_trade/utilities/values_manager.dart';
// import 'package:medical_trade/controller/get_categories_api.dart';

// class NewMachine extends StatefulWidget {
//   const NewMachine({super.key});

//   @override
//   State<NewMachine> createState() => _NewMachineState();
// }

// class _NewMachineState extends State<NewMachine> {
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Fetch the categories when the widget is initialized
//       Provider.of<GetCategoriesProvider>(context, listen: false).fetchData();
//     });
//   }

//   void _onAppBarTitleTap() {
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<GetCategoriesProvider>(context);
//     final categories = provider.getFilteredCategories(["1", "2"]);

//     if (categories.isEmpty) {
//       return Scaffold(
//         backgroundColor: ColorManager.white,
//         appBar: CustomAppBar(
//           onTap: _onAppBarTitleTap,
//           title: "New Machine",
//         ),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     final clinicalMachine = categories.firstWhere(
//       (category) => category.productCategorySlNo == "1",
//       orElse: () => GetCategoryModel(
//         productCategorySlNo: "1",
//         productCategoryName: "Clinical Machine",
//         productCategoryDescription: "",
//         status: "",
//         addBy: "",
//         addTime: "",
//         updateBy: "",
//         updateTime: "",
//         categoryBranchid: "",
//       ),
//     );

//     final pathologyMachine = categories.firstWhere(
//       (category) => category.productCategorySlNo == "2",
//       orElse: () => GetCategoryModel(
//         productCategorySlNo: "2",
//         productCategoryName: "Pathology Machine",
//         productCategoryDescription: "",
//         status: "",
//         addBy: "",
//         addTime: "",
//         updateBy: "",
//         updateTime: "",
//         categoryBranchid: "",
//       ),
//     );

//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       appBar: CustomAppBar(
//         onTap: _onAppBarTitleTap,
//         title: "New Machine",
//       ),
//       body: Padding(
//         padding:
//             EdgeInsets.only(top: AppPadding.p16.h, left: 12.w, right: 12.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Expanded(
//               child: CustomContainer(
//                 backgroundColor: ColorManager.homeContainerSix,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Details(
//                         item: clinicalMachine,
//                         categoryType: "new",
//                       ),
//                     ),
//                   );
//                 },
//                 text: clinicalMachine.productCategoryName,
//                 textColor: ColorManager.white,
//                 iconPath: ImageAssets.diagnostic,
//               ),
//             ),
//             SizedBoxManager.width(AppMargin.m8),
//             Expanded(
//               child: CustomContainer(
//                 backgroundColor: const Color.fromARGB(255, 152, 201, 154),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Details(
//                         item: pathologyMachine, // Pass the item here
//                         categoryType: "new",
//                       ),
//                     ),
//                   );
//                 },
//                 text: pathologyMachine.productCategoryName,
//                 textColor: ColorManager.white,
//                 iconPath: ImageAssets.pathology,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

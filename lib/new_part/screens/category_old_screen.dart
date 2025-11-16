import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/new_part/model/new_category_model.dart';
import 'package:medical_trade/new_part/providers/category_provider.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_container_homepage.dart';
import 'package:medical_trade/utilities/sizebox_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:provider/provider.dart';

class CategoryOldScreen extends StatefulWidget {
  const CategoryOldScreen({super.key});

  @override
  State<CategoryOldScreen> createState() => _CategoryOldScreenState();
}

class _CategoryOldScreenState extends State<CategoryOldScreen> {
  //SharedPreferences? sharedPreferences;
  TextEditingController _searchController = TextEditingController();
  List filteredCategories = [];

  @override
  void initState() {
    super.initState();
    CategoryProvider.isAllCategoriesLoading = true;
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
  }

  void filterSearchResults(List allCategoriesData) {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredCategories = allCategoriesData;
      } else {
        filteredCategories = allCategoriesData.where((category) {
          return category.productCategoryName.toLowerCase().contains(query);
        }).toList();
      }
    });
  }
  void _onAppBarTitleTap() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    final allCategoriesData = Provider.of<CategoryProvider>(context).allCategoriesList;

    // initialize filtered list initially
    if (filteredCategories.isEmpty && allCategoriesData.isNotEmpty) {
      filteredCategories = allCategoriesData;
    }

     // Clinical Machine
    final clinicalMachine = allCategoriesData.firstWhere(
      (category) => category.id.toString() == "1",
      orElse: () => NewCategoryModel(
        id: "1",
        name: "Clinical Machine",
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
     final pathologyMachine = allCategoriesData.firstWhere(
      (category) => category.id.toString() == "2",
      orElse: () => NewCategoryModel(
        id: "2",
        name: "Pathology Machine",
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
        title: "Old Machine",
      ),
      body: Padding(
        padding:EdgeInsets.only(top: AppPadding.p16.h, left: 12.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomContainer(
                backgroundColor: ColorManager.homeContainerSix,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Details(
                  //       item: clinicalMachine,
                  //       categoryType: "new",
                  //     ),
                  //   ),
                  // );
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Details(
                  //       item: pathologyMachine,
                  //       categoryType: "new",
                  //     ),
                  //   ),
                  // );
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
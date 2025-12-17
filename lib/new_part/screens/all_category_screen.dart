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

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
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
    print("Category length======${allCategoriesData.length}");

    // initialize filtered list initially
    if (filteredCategories.isEmpty && allCategoriesData.isNotEmpty) {
      filteredCategories = allCategoriesData;
    }

     // Clinical Machine
    final clinicalMachine = allCategoriesData.firstWhere(
      (category) => category.id.toString() == "1",
      orElse: () => NewCategoryModel(
        id: 1,
        name: "Clinical Machine",
        description: "",
        createdBy: 0,
        updatedBy: "0",
        ipAddress: "",
        branchId: 0,
        deletedAt: "",
        createdAt: "",
        updatedAt: "",
      ),
    );

    // Pathology Machine
     final pathologyMachine = allCategoriesData.firstWhere(
      (category) => category.id.toString() == "2",
      orElse: () => NewCategoryModel(
        id: 2,
        name: "Pathology Machine",
        description: "",
        createdBy: 0,
        updatedBy: "0",
        ipAddress: "",
        branchId: 0,
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
      // body: CategoryProvider.isAllCategoriesLoading
      //     ? Center(child: FancyNoDataDialog())
      //     : Column(
      //         children: [
      //           Padding(
      //             padding: EdgeInsets.all(10.r),
      //             child: SizedBox(
      //               height: 35.h,
      //               child: TextField(
      //                 controller: _searchController,
      //                 onChanged: (value) {
      //                   filterSearchResults(allCategoriesData);
      //                 },
      //                 decoration: InputDecoration(
      //                   hintText: 'Search Category',
      //                   hintStyle: AllTextStyle.textValueStyle,
      //                   prefixIcon: Icon(Icons.search,size: 20.r),
      //                   border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8.r),
      //                     borderSide: BorderSide(color: Colors.grey),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //             child: filteredCategories.isNotEmpty
      //                 ? Padding(
      //                     padding: EdgeInsets.only(left: 8.w,right: 8.w),
      //                     child: GridView.builder(
      //                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                         crossAxisCount: 3,
      //                         childAspectRatio: 0.9,
      //                         crossAxisSpacing: 10,
      //                         mainAxisSpacing: 10,
      //                       ),
      //                       itemCount: filteredCategories.length,
      //                       itemBuilder: (context, index) {
      //                         final category = filteredCategories[index];
      //                         return Card(
      //                           elevation: 4,
      //                           child: Column(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Expanded(
      //                                 flex: 3,
      //                                 child: Container(
      //                                   decoration: BoxDecoration(
      //                                     borderRadius: BorderRadius.only(
      //                                       topLeft: Radius.circular(5.r),
      //                                       topRight: Radius.circular(5.r),
      //                                     ),
      //                                   ),
      //                                   // child: ClipRRect(
      //                                   //   borderRadius: BorderRadius.only(
      //                                   //     topLeft: Radius.circular(5.r),
      //                                   //     topRight: Radius.circular(5.r),
      //                                   //   ),
      //                                   //   child: Image.network(
      //                                   //     "${category.name}",
      //                                   //     fit: BoxFit.cover,
      //                                   //     width: double.infinity,
      //                                   //     height: double.infinity,
      //                                   //     loadingBuilder: (context, child, loadingProgress) {
      //                                   //       if (loadingProgress == null) {
      //                                   //         return child;
      //                                   //       }
      //                                   //       return const Center(
      //                                   //         child: CircularProgressIndicator(),
      //                                   //       );
      //                                   //     },
      //                                   //     errorBuilder: (context, error, stackTrace) {
      //                                   //       return Container(
      //                                   //         decoration: BoxDecoration(
      //                                   //           color: Colors.teal.shade100,
      //                                   //           borderRadius: BorderRadius.only(
      //                                   //             topLeft: Radius.circular(5.r),
      //                                   //             topRight: Radius.circular(5.r),
      //                                   //           ),
      //                                   //           image: const DecorationImage(
      //                                   //             image: AssetImage("images/bydyimg.png"),
      //                                   //             fit: BoxFit.fill,
      //                                   //           ),
      //                                   //         ),
      //                                   //       );
      //                                   //     },
      //                                   //   ),
      //                                   // ),
      //                                 ),
      //                               ),
      //                               Expanded(
      //                                 flex: 1,
      //                                 child: Container(
      //                                   decoration: BoxDecoration(
      //                                     color: AppColors.primaryColor,
      //                                     borderRadius: BorderRadius.only(
      //                                       bottomLeft: Radius.circular(5.r),
      //                                       bottomRight: Radius.circular(5.r),
      //                                     ),
      //                                   ),
      //                                   child: Center(
      //                                     child: Text(
      //                                       category.name,
      //                                       textAlign: TextAlign.center,
      //                                       style: AllTextStyle.tableHeadTextStyle,
      //                                       maxLines: 2,
      //                                       overflow: TextOverflow.ellipsis,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         );
      //                       },
      //                     ),
      //                   )
      //                 : Center(child: Padding(padding: EdgeInsets.all(10.r),child: Text("No records found", style: AllTextStyle.nofoundTextStyle)),
      //             ),
      //           ),
      //         ],
      //       ),
    
    );
  }
}
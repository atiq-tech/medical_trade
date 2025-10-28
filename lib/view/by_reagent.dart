import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/get_categories_api.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_container_by_regant.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/view/by_reagent_category_view.dart';
import 'package:provider/provider.dart';

class ByReagent extends StatefulWidget {
  const ByReagent({super.key});

  @override
  State<ByReagent> createState() => _ByReagentState();
}

class _ByReagentState extends State<ByReagent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<GetCategoriesProvider>(context, listen: false).fetchData();
    });
  }

  void _onAppBarTitleTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTap: _onAppBarTitleTap,
        title: "Buy Reagent",
      ),
      body: Consumer<GetCategoriesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorManager.red),
              ),
            );
          }

          final categories = provider.categories;
          final filteredCategories = categories.where((category) {
            return ["4", "5", "6", "7"].contains(category.productCategorySlNo);
          }).toList();

          if (filteredCategories.isEmpty) {
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
                    "No categories available.",
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
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p8.w,
                vertical: AppPadding.p8.h,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppMargin.m8.w,
                  mainAxisSpacing: AppMargin.m8.h,
                  childAspectRatio: 1.0,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  return CustomConatinerByReagent(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ByReagentCategoryView(item: category),
                        ),
                      );
                    },
                    text: category.productCategoryName,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

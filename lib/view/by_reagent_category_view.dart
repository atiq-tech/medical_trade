import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:medical_trade/controller/get_product_api_category.dart';
import 'package:medical_trade/model/get_categories_model.dart';
import 'package:medical_trade/model/get_category_product_model.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/utilities/zoom_screen.dart';
import 'package:medical_trade/view/by_reagent_category_view_details_view.dart';
import 'package:provider/provider.dart';

class ByReagentCategoryView extends StatefulWidget {
  final GetCategoryModel item;
  const ByReagentCategoryView({super.key, required this.item});

  @override
  State<ByReagentCategoryView> createState() => _ByReagentCategoryViewState();
}

bool _isSearching = false;
final TextEditingController _searchController = TextEditingController();
final TextEditingController _productController = TextEditingController();

class _ByReagentCategoryViewState extends State<ByReagentCategoryView> {
  @override
  void initState() {
    super.initState();
    // Fetch the product data for the selected category
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<GetCategoryProductProvider>(context, listen: false)
          .fetchDataProduct(widget.item.productCategorySlNo.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
            _isSearching = false;
          },
        ),
        title: _isSearching
            ? 
            ///=====new myTask TypeAheadField new 
            Container(
              height: 35.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              child: TypeAheadField<GetCategoryProductModel>(
                controller: _productController, // <-- নতুন সিনট্যাক্স
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              bottomLeft: Radius.circular(30.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Icon(Icons.search, size: 18.sp, color: Colors.white),
                          ),
                        ),
                      ),
                      hintText: 'Search In...',
                      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 12.w, top: 2.h, bottom: 2.h),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFFC107).withOpacity(0.2),
                      isDense: true,
                    ),
                  );
                },
                suggestionsCallback: (pattern) async {
                  final data = Provider.of<GetCategoryProductProvider>(context, listen: false);
                  final products = data.categories;
                  return products
                      .where((product) => product.productName!
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, GetCategoryProductModel suggestion) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Text(
                      suggestion.productName.toString(),
                      style: TextStyle(fontSize: 14.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
                onSelected: (GetCategoryProductModel suggestion) {
                  setState(() {
                    _productController.text = suggestion.productName.toString();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ByReagentCategoryViewDetailsView(item: suggestion),
                    ),
                  );
                  _productController.clear();
                  setState(() {
                    _isSearching = false;
                  });
                },
                emptyBuilder: (context) => Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Text(
                    'No Products Found',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                decorationBuilder: (context, child) => Container(
                  color: Colors.white,
                  child: child,
                ),
              ),
            )

            //   ///=====old TypeAheadFormField code
            // Container(
            //     height: 35.h,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(30.r)),
            //     ),
            //     child: TypeAheadFormField<GetCategoryProductModel>(
            //       textFieldConfiguration: TextFieldConfiguration(
            //         controller: _productController,
            //         decoration: InputDecoration(
            //           prefixIcon: Padding(
            //             padding: EdgeInsets.only(right: 12.w),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 color: Colors.orange,
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(30.r),
            //                   bottomLeft: Radius.circular(30.r),
            //                 ),
            //               ),
            //               child: Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 8.w),
            //                 child: Icon(Icons.search,
            //                     size: 18.sp, color: Colors.white),
            //               ),
            //             ),
            //           ),
            //           hintText: 'Search In...',
            //           hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
            //           contentPadding:
            //               EdgeInsets.only(left: 12.w, top: 2.h, bottom: 2.h),
            //           border: OutlineInputBorder(
            //             borderSide: BorderSide.none,
            //             borderRadius: BorderRadius.circular(30.r),
            //           ),
            //           filled: true,
            //           fillColor: const Color(0xFFFFC107).withOpacity(0.2),
            //           isDense: true,
            //         ),
            //       ),
            //       suggestionsCallback: (pattern) async {
            //         // Use a Consumer to fetch products
            //         final data = Provider.of<GetCategoryProductProvider>(
            //             context,
            //             listen: false);
            //         final products = data.categories;

            //         return products
            //             .where((product) => product.productName!
            //                 .toLowerCase()
            //                 .contains(pattern.toLowerCase()))
            //             .toList();
            //       },
            //       itemBuilder: (context, GetCategoryProductModel suggestion) {
            //         return Padding(
            //           padding:
            //               EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            //           child: Text(
            //             suggestion.productName.toString(),
            //             style: TextStyle(fontSize: 14.sp),
            //             maxLines: 1,
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         );
            //       },
            //       onSuggestionSelected: (GetCategoryProductModel suggestion) {
            //         setState(() {
            //           _productController.text =
            //               suggestion.productName.toString();
            //         });
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) =>
            //                 ByReagentCategoryViewDetailsView(item: suggestion),
            //           ),
            //         );
            //         _productController.clear();
            //         setState(() {
            //           _isSearching = false;
            //         });
            //       },
            //       noItemsFoundBuilder: (context) {
            //         return Padding(
            //           padding: EdgeInsets.all(8.h),
            //           child: Text(
            //             'No Products Found',
            //             style: TextStyle(fontSize: 14.sp),
            //           ),
            //         );
            //       },
            //       transitionBuilder: (context, suggestionsBox, controller) {
            //         return suggestionsBox;
            //       },
            //       suggestionsBoxDecoration: const SuggestionsBoxDecoration(
            //         color: Colors.white,
            //       ),
            //     ),
             
            //   )
            
            : Text(widget.item.productCategoryName),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              size: 26.sp,
              color: Colors.green,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 20.h),
        child: Padding(
          padding: EdgeInsets.only(right: 12.w, left: 12.w),
          child: Consumer<GetCategoryProductProvider>(
            builder: (context, provider, child) {
              // Show loading indicator while data is being fetched
              if (provider.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorManager.red),
                  ),
                );
              }

              // Show message if no data is available
              if (provider.categories.isEmpty) {
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
                    ],
                  ),
                );
              }

              // Display the GridView with product data
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10.0.h,
                  mainAxisSpacing: 4.0.w,
                  childAspectRatio: 0.750,
                ),
                itemCount: provider.categories.length,
                itemBuilder: (context, index) {
                  final product = provider.categories[index];
                  return Card(
                    elevation: 6,
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
                                        'https://madicaltrade.com/uploads/products/${product.image}',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 200.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8.r),
                                    topLeft: Radius.circular(8.r)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8.r),
                                    topLeft: Radius.circular(8.r)),
                                child: Image.network(
                                  'https://madicaltrade.com/uploads/products/${product.image}',
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
                                product.productName.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "\$ ${product.productSellingPrice}",
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
                                            ByReagentCategoryViewDetailsView(
                                                item: product),
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
            },
          ),
        ),
      ),
    );
  }
}

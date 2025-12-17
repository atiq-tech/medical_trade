import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:medical_trade/model/get_category_product_model.dart';
import 'package:medical_trade/new_part/providers/all_products_provider.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/utilities/zoom_screen.dart';
import 'package:medical_trade/view/all_accessories_details_view.dart';
import 'package:provider/provider.dart';

class AllAccessories extends StatefulWidget {
  const AllAccessories({super.key});

  @override
  State<AllAccessories> createState() => _AllAccessoriesState();
}

bool _isSearching = false;
//final TextEditingController _searchController = TextEditingController();
final TextEditingController _productController = TextEditingController();

class _AllAccessoriesState extends State<AllAccessories> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Provider.of<GetCategoryProductProvider>(context, listen: false)
      //     .fetchDataProduct("3");
    });
    Provider.of<AllProductsProvider>(context, listen: false).getProducts("3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back,size: 24.sp),
        onPressed: () {
          Navigator.pop(context);
          _isSearching = false;
        },
      ),

     title: _isSearching
      ? Container(
          height: 35.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
          ),
          child: TypeAheadField<GetCategoryProductModel>(
            controller: _productController,
            suggestionsCallback: (pattern) async {
              final provider = Provider.of<AllProductsProvider>(context, listen: false);
              final products = provider.allProductslist;
              return products.where((p) => p.productName!.toLowerCase().contains(pattern.toLowerCase())).toList();
            },
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
                        child: Icon(Icons.search,size: 18.sp,color: Colors.white),
                      ),
                    ),
                  ),
                  hintText: 'Search Products...',
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
            itemBuilder: (context, GetCategoryProductModel suggestion) {
              return Padding(
                padding:EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
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
                _productController.text = suggestion.productName!;
              });
              Navigator.push(context,MaterialPageRoute(builder: (context) =>AllAccessoriesDetailsView(item: suggestion)));
              _productController.clear();
              setState(() {
                _isSearching = false;
              });
            },
            emptyBuilder: (context) {
              return Padding(
                padding: EdgeInsets.all(8.h),
                child: Text('No Products Found',style: TextStyle(fontSize: 14.sp)),
              );
            },
            decorationBuilder: (context, child) {
              return Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                child: child,
              );
            },
          ),
        )
      : Text("All Accessories",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search,size: 26.sp,color: Colors.green),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _productController.clear();
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
          child: Consumer<AllProductsProvider>(builder: (context, provider, child) {
            if (AllProductsProvider.isAllProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.allProductslist.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon( Icons.shopping_bag_outlined,size: 80.sp,color: Colors.grey[400]),
                    SizedBox(height: 16.h),
                    Text("No products available",
                      style: TextStyle(fontSize: 18.sp,color: Colors.grey[600],fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8.h),
                    Text("Check back later!",style: TextStyle(fontSize: 14.sp,color: Colors.grey[500])),
                  ],
                ),
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0.h,
                mainAxisSpacing: 4.0.w,
                childAspectRatio: 0.750,
              ),
              itemCount: provider.allProductslist.length,
              itemBuilder: (context, index) {
                final product = provider.allProductslist[index];
                return Card(
                  elevation: 7,
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => ImageZoomScreen(
                                  imageUrl:'https://app.medicaltradeltd.com/${product.image}',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(8.r),topLeft: Radius.circular(8.r)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.r),
                                  topLeft: Radius.circular(8.r)),
                              child: Image.network('https://app.medicaltradeltd.com/${product.image}',
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: SizedBox(
                                      width: 24.w,
                                      height: 24.h,
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.error, size: 24.w)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(top: 6.h, left: 8.w, right: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.productName.toString(),
                              style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("\$ ${product.price}",
                              style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.green),
                            ),
                            SizedBox(height: 8.h),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AllAccessoriesDetailsView(item: product)));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: 25.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: ColorManager.black,
                                      borderRadius:BorderRadius.circular(AppSize.s5.r),
                                    ),
                                    child: Center(
                                      child: Text( "Details",style: FontManager.bodyText.copyWith(color: ColorManager.white,fontSize: 11.sp)),
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
          }),
        ),
      ),
    );
  }
}












///========old==========
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// // import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:medical_trade/controller/get_product_api_category.dart';
// import 'package:medical_trade/model/get_category_product_model.dart';
// import 'package:medical_trade/utilities/color_manager.dart';
// import 'package:medical_trade/utilities/font_manager.dart';
// import 'package:medical_trade/utilities/values_manager.dart';
// import 'package:medical_trade/utilities/zoom_screen.dart';
// import 'package:medical_trade/view/all_accessories_details_view.dart';
// import 'package:provider/provider.dart';

// class AllAccessories extends StatefulWidget {
//   const AllAccessories({super.key});

//   @override
//   State<AllAccessories> createState() => _AllAccessoriesState();
// }

// bool _isSearching = false;
// final TextEditingController _searchController = TextEditingController();
// final TextEditingController _productController = TextEditingController();

// class _AllAccessoriesState extends State<AllAccessories> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<GetCategoryProductProvider>(context, listen: false)
//           .fetchDataProduct("3");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             size: 24.sp,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//             _isSearching = false;
//           },
//         ),
//         title: _isSearching
//             ?
//             ///=====new myTask TypeAheadField new 
//             Container(
//               height: 35.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(30.r)),
//               ),

//               /// ✅ New flutter_typeahead ^5.2.0 compatible widget
//               child: TypeAheadField<GetCategoryProductModel>(
//                 controller: _productController,

//                 /// ✅ suggestion callback
//                 suggestionsCallback: (pattern) async {
//                   final data = Provider.of<GetCategoryProductProvider>(context, listen: false);
//                   final products = data.categories;
//                   return products
//                       .where((product) => product.productName!
//                           .toLowerCase()
//                           .contains(pattern.toLowerCase()))
//                       .toList();
//                 },

//                 /// ✅ builder replaces textFieldConfiguration
//                 builder: (context, controller, focusNode) {
//                   return TextField(
//                     controller: controller,
//                     focusNode: focusNode,
//                     decoration: InputDecoration(
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.only(right: 12.w),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.orange,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30.r),
//                               bottomLeft: Radius.circular(30.r),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8.w),
//                             child: Icon(
//                               Icons.search,
//                               size: 18.sp,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       hintText: 'Search In...',
//                       hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
//                       contentPadding: EdgeInsets.only(left: 12.w, top: 2.h, bottom: 2.h),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                         borderRadius: BorderRadius.circular(30.r),
//                       ),
//                       filled: true,
//                       fillColor: const Color(0xFFFFC107).withOpacity(0.2),
//                       isDense: true,
//                     ),
//                   );
//                 },

//                 /// ✅ each suggestion tile UI
//                 itemBuilder: (context, GetCategoryProductModel suggestion) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
//                     child: Text(
//                       suggestion.productName.toString(),
//                       style: TextStyle(fontSize: 14.sp),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   );
//                 },

//                 /// ✅ when user selects a suggestion
//                 onSelected: (GetCategoryProductModel suggestion) {
//                   setState(() {
//                     _productController.text = suggestion.productName.toString();
//                   });
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AllAccessoriesDetailsView(item: suggestion),
//                     ),
//                   );
//                   _productController.clear();
//                   setState(() {
//                     _isSearching = false;
//                   });
//                 },

//                 /// ✅ no item found message
//                 emptyBuilder: (context) {
//                   return Padding(
//                     padding: EdgeInsets.all(8.h),
//                     child: Text(
//                       'No Products Found',
//                       style: TextStyle(fontSize: 14.sp),
//                     ),
//                   );
//                 },

//                 /// ✅ suggestion box design
//                 decorationBuilder: (context, child) {
//                   return Material(
//                     elevation: 4,
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10.r),
//                     child: child,
//                   );
//                 },
//               ),
//             )
//             //   ///=====old TypeAheadFormField code
//             // Container(
//             //     height: 35.h,
//             //     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.r))),
//             //     ///=====myTask new
//             //     child: TypeAheadFormField<GetCategoryProductModel>(
//             //       textFieldConfiguration: TextFieldConfiguration(
//             //         controller: _productController,
//             //         decoration: InputDecoration(
//             //           prefixIcon: Padding(
//             //             padding: EdgeInsets.only(right: 12.w),
//             //             child: Container(
//             //               decoration: BoxDecoration(
//             //                 color: Colors.orange,
//             //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),bottomLeft: Radius.circular(30.r)),
//             //               ),
//             //               child: Padding(
//             //                 padding: EdgeInsets.symmetric(horizontal: 8.w),
//             //                 child: Icon(Icons.search,size: 18.sp, color: Colors.white),
//             //               ),
//             //             ),
//             //           ),
//             //           hintText: 'Search In...',
//             //           hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
//             //           contentPadding:EdgeInsets.only(left: 12.w, top: 2.h, bottom: 2.h),
//             //           border: OutlineInputBorder(
//             //             borderSide: BorderSide.none,
//             //             borderRadius: BorderRadius.circular(30.r),
//             //           ),
//             //           filled: true,
//             //           fillColor: const Color(0xFFFFC107).withOpacity(0.2),
//             //           isDense: true,
//             //         ),
//             //       ),
//             //       suggestionsCallback: (pattern) async {
//             //         // Use a Consumer to fetch products
//             //         final data = Provider.of<GetCategoryProductProvider>(context,listen: false);
//             //         final products = data.categories;
//             //         return products.where((product) => product.productName!.toLowerCase()
//             //                 .contains(pattern.toLowerCase())).toList();
//             //       },
//             //       itemBuilder: (context, GetCategoryProductModel suggestion) {
//             //         return Padding(
//             //           padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
//             //           child: Text(
//             //             suggestion.productName.toString(),
//             //             style: TextStyle(fontSize: 14.sp),
//             //             maxLines: 1,
//             //             overflow: TextOverflow.ellipsis,
//             //           ),
//             //         );
//             //       },
//             //       onSuggestionSelected: (GetCategoryProductModel suggestion) {
//             //         setState(() {
//             //           _productController.text = suggestion.productName.toString();
//             //         });
//             //         Navigator.push(context, MaterialPageRoute(builder: (context) => AllAccessoriesDetailsView(item: suggestion),
//             //           ));
//             //         _productController.clear();
//             //         setState(() {
//             //           _isSearching = false;
//             //         });
//             //       },
//             //       noItemsFoundBuilder: (context) {
//             //         return Padding(
//             //           padding: EdgeInsets.all(8.h),
//             //           child: Text(
//             //             'No Products Found',
//             //             style: TextStyle(fontSize: 14.sp),
//             //           ),
//             //         );
//             //       },
//             //       transitionBuilder: (context, suggestionsBox, controller) {
//             //         return suggestionsBox;
//             //       },
//             //       suggestionsBoxDecoration: const SuggestionsBoxDecoration(
//             //         color: Colors.white,
//             //       ),
//             //     ),
//             //   )
           
//             : Text(
//                 "All Accessories",
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _isSearching ? Icons.close : Icons.search,
//               size: 26.sp,
//               color: Colors.green,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isSearching = !_isSearching;
//                 if (!_isSearching) {
//                   _searchController.clear();
//                 }
//               });
//             },
//           ),
//           SizedBox(width: 8.w),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 20.h),
//         child: Padding(
//           padding: EdgeInsets.only(right: 12.w, left: 12.w),
//           child: Consumer<GetCategoryProductProvider>(
//               builder: (context, provider, child) {
//             if (provider.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (provider.categories.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.shopping_bag_outlined,
//                       size: 80.sp,
//                       color: Colors.grey[400],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       "No products available",
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       "Check back later!",
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 1,
//                 crossAxisSpacing: 10.0.h,
//                 mainAxisSpacing: 4.0.w,
//                 childAspectRatio: 0.750,
//               ),
//               itemCount: provider.categories.length,
//               itemBuilder: (context, index) {
//                 final product = provider.categories[index];
//                 return Card(
//                   elevation: 7,
//                   color: Colors.grey.shade200,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ImageZoomScreen(
//                                   imageUrl:
//                                       'https://madicaltrade.com/uploads/products/${product.image}',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             height: 200.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(8.r),
//                                   topLeft: Radius.circular(8.r)),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(8.r),
//                                   topLeft: Radius.circular(8.r)),
//                               child: Image.network(
//                                 'https://madicaltrade.com/uploads/products/${product.image}',
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (BuildContext context,
//                                     Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child;
//                                   }
//                                   return Center(
//                                     child: SizedBox(
//                                       width: 24.w,
//                                       height: 24.h,
//                                       child: CircularProgressIndicator(
//                                         value: loadingProgress
//                                                     .expectedTotalBytes !=
//                                                 null
//                                             ? loadingProgress
//                                                     .cumulativeBytesLoaded /
//                                                 loadingProgress
//                                                     .expectedTotalBytes!
//                                             : null,
//                                         strokeWidth: 2.0,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Center(
//                                         child: Icon(Icons.error, size: 24.w)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsets.only(top: 6.h, left: 8.w, right: 8.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               product.productName.toString(),
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               "\$ ${product.productSellingPrice}",
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.green,
//                               ),
//                             ),
//                             SizedBox(height: 8.h),
//                             Align(
//                               alignment: Alignment.center,
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           AllAccessoriesDetailsView(
//                                               item: product),
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   elevation: 5,
//                                   child: Container(
//                                     height: 25.h,
//                                     width: 80.w,
//                                     decoration: BoxDecoration(
//                                       color: ColorManager.black,
//                                       borderRadius:
//                                           BorderRadius.circular(AppSize.s5.r),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "Details",
//                                         style: FontManager.bodyText.copyWith(
//                                             color: ColorManager.white,
//                                             fontSize: 11.sp),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 12.h),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

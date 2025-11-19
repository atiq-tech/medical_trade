import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medical_trade/controller/contact_api.dart';
import 'package:medical_trade/controller/customer_product_buy_api.dart';
import 'package:medical_trade/controller/slider_controller.dart';
import 'package:medical_trade/model/get_category_product_model.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_message.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/utilities/zoom_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AllAccessoriesDetailsView extends StatefulWidget {
  final GetCategoryProductModel item;
  const AllAccessoriesDetailsView({super.key, required this.item});

  @override
  State<AllAccessoriesDetailsView> createState() =>
      _AllAccessoriesDetailsViewState();
}

class _AllAccessoriesDetailsViewState extends State<AllAccessoriesDetailsView> {
  void _onAppBarTitleTap() {
    Navigator.pop(context);
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    // Fetch the contact data if it hasn't been loaded yet
    if (contactProvider.companyProfile == null && !contactProvider.isLoading) {
      contactProvider.fetchContact();
    }
    print(widget.item.image);
    return Scaffold(
      appBar: CustomAppBar(
        onTap: _onAppBarTitleTap,
        title: "Products Details",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          GestureDetector(
            onTap: () => _openZoomView(context),
            child: (widget.item.images == null || widget.item.images!.isEmpty)
                ? Center(
                    child: Text(
                      "No Images Available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : CarouselSlider(
                    items: widget.item.images!.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            'https://app.medicaltradeltd.com/$item',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2.0,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        Provider.of<AppProvider>(context, listen: false)
                            .setCarouselIndex(index);
                      },
                    ),
                  ),
            ),
            Consumer<AppProvider>(builder: (context, provider, _) {
              final images = widget.item.images;
              // 🔥 images null বা empty হলে কোন dot দেখাবে না
              if (images == null || images.isEmpty) {
                return const SizedBox();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: provider.carouselIndex == index
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }),
              );
            }),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageZoomScreen(
                                  imageUrl:
                                      'https://app.medicaltradeltd.com/${widget.item.image??""}',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                'https://app.medicaltradeltd.com/${widget.item.image??""}',
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
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                            : null,
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w, right: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.productName.toString(),
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "BDT ${widget.item.price??""}",
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Text(
                                    "Type :",
                                    textAlign: TextAlign.start,
                                    style: FontManager.headline.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    widget.item.type.toString(),
                                    textAlign: TextAlign.start,
                                    style: FontManager.headline.copyWith(
                                      color: Colors.green,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox( height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Category :",
                                    textAlign: TextAlign.start,
                                    style: FontManager.headline.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Flexible(
                                    child: Text(
                                      widget.item.categoryName.toString(),
                                      textAlign: TextAlign.start,
                                      style: FontManager.headline.copyWith(
                                        color: Colors.green,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Description",
                    style: FontManager.headline.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4.h),
                  Divider(color: Colors.black,height: 0.5.h),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    child: Text(
                      widget.item.description.toString(),
                      textAlign: TextAlign.justify,
                      style: FontManager.bodyText.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // Call Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.r,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                              padding: EdgeInsets.only(left: 12.w, top: 8.h, bottom: 8.h),
                              child: Text(
                                contactProvider.companyProfile?.phone?.toString() ??"",
                                style: FontManager.headline.copyWith(
                                  color: Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _launchPhone(contactProvider
                                      .companyProfile?.phone
                                      ?.toString() ??
                                  ""),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 12.w, right: 12.w),
                                child: Icon(
                                  Icons.call,
                                  size: 22.sp,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 16.h),
                      // // Call Button
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(50.r),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black26,
                      //         offset: Offset(0, 2),
                      //         blurRadius: 6.r,
                      //       ),
                      //     ],
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //        Padding(
                      //         padding: EdgeInsets.only(left: 12.w, top: 8.h, bottom: 8.h),
                      //         child: Text(
                      //           contactProvider.companyProfile?.name?.toString() ??"",
                      //           style: FontManager.headline.copyWith(
                      //             color: Colors.green,
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //       ),
                      //       InkWell(
                      //         onTap: () => _launchPhone(contactProvider
                      //                 .companyProfile?.phone
                      //                 ?.toString() ??
                      //             ""),
                      //         child: Padding(
                      //           padding:
                      //               EdgeInsets.only(left: 12.w, right: 12.w),
                      //           child: Icon(
                      //             Icons.call,
                      //             size: 22.sp,
                      //             color: Colors.green,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          // ignore: unused_local_variable
                          final provider = Provider.of<CustomerProductBuyApi>(
                              context,
                              listen: false);
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            title: Text(
                              "Order Confirmation",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 22.sp,
                              ),
                            ),
                            content: Text(
                              "Are you sure you want to place this order?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close dialog
                                    },
                                    child: Container(
                                      height: 35.h,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Consumer<CustomerProductBuyApi>(
                                    builder: (context, provider, child) {
                                      return TextButton(
                                        onPressed: provider.isLoading
                                            ? null
                                            : () {
                                                // Show loading dialog
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible:
                                                      false, // Prevent dismissing by tapping outside
                                                  builder: (context) {
                                                    return Center(
                                                      child: SpinKitCircle(
                                                        color: Colors.red,
                                                        size: 50.0.sp,
                                                      ),
                                                    );
                                                  },
                                                );

                                                provider.fetchCustomerCodeAndSendOrder(
                                                  wallpostId: widget.item.id.toString(),
                                                ).then((_) {
                                                  Navigator.pop(context); // Close loading dialog
                                                  Navigator.pop( context); // Close order confirmation dialog
                                                  if (provider.errorMessage ==null) {
                                                    CustomToast.show(context: context,
                                                      text: "Order completed successfully",
                                                      isSuccess: true,
                                                    );
                                                  } else {
                                                    CustomToast.show(
                                                      context: context,
                                                      text: provider.errorMessage ?? "An error occurred",
                                                      isSuccess: false,
                                                    );
                                                  }
                                                }).catchError((error) {
                                                  Navigator.pop(context); // Close loading dialog
                                                  CustomToast.show(
                                                    context: context,
                                                    text: "Error: $error",
                                                    isSuccess: false,
                                                  );
                                                });
                                              },
                                        child: Container(
                                          height: 35.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(5.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Confirm Order",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 35.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(AppSize.s5.r),
                        ),
                        child: Center(
                          child: Text(
                            "Order Now",
                            style: FontManager.bodyText.copyWith(
                              color: ColorManager.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _openZoomView(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          body: PhotoViewGallery.builder(
          itemCount: widget.item.images?.length ?? 0,
          pageController: PageController(initialPage: _currentIndex),
          onPageChanged: (index) => setState(() => _currentIndex = index),
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                'https://app.medicaltradeltd.com/${widget.item.images?[index]}',
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              heroAttributes: PhotoViewHeroAttributes(tag: 'gallery_$index'),
            );
          },
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              value: event == null
                  ? null
                  : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
            ),
          ),
        )

        );
      },
    );
  }

  void _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }
}














///======old=======
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:medical_trade/controller/contact_api.dart';
// import 'package:medical_trade/controller/customer_product_buy_api.dart';
// import 'package:medical_trade/controller/slider_controller.dart';
// import 'package:medical_trade/model/get_category_product_model.dart';
// import 'package:medical_trade/utilities/color_manager.dart';
// import 'package:medical_trade/utilities/custom_appbar.dart';
// import 'package:medical_trade/utilities/custom_message.dart';
// import 'package:medical_trade/utilities/font_manager.dart';
// import 'package:medical_trade/utilities/values_manager.dart';
// import 'package:medical_trade/utilities/zoom_screen.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AllAccessoriesDetailsView extends StatefulWidget {
//   final GetCategoryProductModel item;
//   const AllAccessoriesDetailsView({super.key, required this.item});

//   @override
//   State<AllAccessoriesDetailsView> createState() =>
//       _AllAccessoriesDetailsViewState();
// }

// class _AllAccessoriesDetailsViewState extends State<AllAccessoriesDetailsView> {
//   void _onAppBarTitleTap() {
//     Navigator.pop(context);
//   }

//   int _currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<ContactProvider>(context);

//     // Fetch the contact data if it hasn't been loaded yet
//     if (contactProvider.companyProfile == null && !contactProvider.isLoading) {
//       contactProvider.fetchContact();
//     }
//     print(widget.item.image);
//     return Scaffold(
//       appBar: CustomAppBar(
//         onTap: _onAppBarTitleTap,
//         title: "Products Details",
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () => _openZoomView(context),
//               child: CarouselSlider(
//                 items: widget.item.productGallery!.map((item) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Image.network(
//                         width: double.infinity.w,
//                         'https://soft.madicaltrade.com/uploads/product_gallery/${item.productImage}',
//                         fit: BoxFit.cover,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) {
//                             return child;
//                           }
//                           return Center(
//                             child: CircularProgressIndicator(
//                               value: loadingProgress.expectedTotalBytes != null
//                                   ? loadingProgress.cumulativeBytesLoaded /
//                                       loadingProgress.expectedTotalBytes!
//                                   : null,
//                               strokeWidth: 2.0,
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, error, stackTrace) =>
//                             Icon(Icons.error),
//                       );
//                     },
//                   );
//                 }).toList(),
//                 options: CarouselOptions(
//                   autoPlay: false,
//                   enlargeCenterPage: true,
//                   // aspectRatio: 2.0,
//                   viewportFraction: 1.0,
//                   onPageChanged: (index, reason) {
//                     Provider.of<AppProvider>(context, listen: false)
//                         .setCarouselIndex(index);
//                   },
//                 ),
//               ),
//             ),
//             Consumer<AppProvider>(builder: (context, provider, _) {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: widget.item.productGallery!.map((url) {
//                   int index = widget.item.productGallery!.indexOf(url);
//                   return Container(
//                     width: 8,
//                     height: 8,
//                     margin:
//                         EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: provider.carouselIndex == index
//                           ? const Color.fromRGBO(0, 0, 0, 0.9)
//                           : const Color.fromRGBO(0, 0, 0, 0.4),
//                     ),
//                   );
//                 }).toList(),
//               );
//             }),
//             SizedBox(height: 40.h),
//             Padding(
//               padding: EdgeInsets.all(16.0.r),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ImageZoomScreen(
//                                   imageUrl:
//                                       'https://madicaltrade.com/uploads/products/${widget.item.image}',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             height: 200.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8.r),
//                               child: Image.network(
//                                 'https://madicaltrade.com/uploads/products/${widget.item.image}',
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
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 8.w, right: 4.w),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 widget.item.productName.toString(),
//                                 textAlign: TextAlign.start,
//                                 style: FontManager.headline.copyWith(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 3,
//                               ),
//                               SizedBox(
//                                 height: 8.h,
//                               ),
//                               Text(
//                                 "BDT ${widget.item.productSellingPrice}",
//                                 textAlign: TextAlign.start,
//                                 style: FontManager.headline.copyWith(
//                                   color: Colors.green,
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 4.h,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Type :",
//                                     textAlign: TextAlign.start,
//                                     style: FontManager.headline.copyWith(
//                                       color: Colors.black,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 4.w,
//                                   ),
//                                   Text(
//                                     widget.item.type.toString(),
//                                     textAlign: TextAlign.start,
//                                     style: FontManager.headline.copyWith(
//                                       color: Colors.green,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 4.h,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Category :",
//                                     textAlign: TextAlign.start,
//                                     style: FontManager.headline.copyWith(
//                                       color: Colors.black,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 4.w,
//                                   ),
//                                   Flexible(
//                                     child: Text(
//                                       widget.item.productCategoryName
//                                           .toString(),
//                                       textAlign: TextAlign.start,
//                                       style: FontManager.headline.copyWith(
//                                         color: Colors.green,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 2,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 4.h,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 16.h),

//                   // // Constrain ListView.builder height here
//                   // SizedBox(
//                   //   height: 80.h,
//                   //   child: ListView.builder(
//                   //     scrollDirection: Axis.horizontal,
//                   //     itemCount: widget.item.productGallery?.length,
//                   //     itemBuilder: (context, index) {
//                   //       String? imageUrl =
//                   //           widget.item.productGallery?[index].productImage;
//                   //       return Padding(
//                   //         padding: EdgeInsets.only(right: 10.w),
//                   //         child: ClipRRect(
//                   //           borderRadius: BorderRadius.circular(5.r),
//                   //           child: Image.network(
//                   //             'https://madicaltrade.com/uploads/product_gallery/${imageUrl}',
//                   //             height: 30.h,
//                   //             width: 80.w,
//                   //             fit: BoxFit.cover,
//                   //             loadingBuilder: (BuildContext context,
//                   //                 Widget child,
//                   //                 ImageChunkEvent? loadingProgress) {
//                   //               if (loadingProgress == null) {
//                   //                 return child;
//                   //               }
//                   //               return Center(
//                   //                 child: SizedBox(
//                   //                   width: 24.w,
//                   //                   height: 24.h,
//                   //                   child: CircularProgressIndicator(
//                   //                     value:
//                   //                         loadingProgress.expectedTotalBytes !=
//                   //                                 null
//                   //                             ? loadingProgress
//                   //                                     .cumulativeBytesLoaded /
//                   //                                 loadingProgress
//                   //                                     .expectedTotalBytes!
//                   //                             : null,
//                   //                     strokeWidth: 2.0,
//                   //                   ),
//                   //                 ),
//                   //               );
//                   //             },
//                   //             errorBuilder: (context, error, stackTrace) =>
//                   //                 Icon(Icons.error),
//                   //           ),
//                   //         ),
//                   //       );
//                   //     },
//                   //   ),
//                   // ),

//                   // SizedBox(height: 16.h),
//                   Text(
//                     "Description",
//                     style: FontManager.headline.copyWith(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   SizedBox(height: 4.h),
//                   Divider(
//                     color: Colors.black,
//                     height: 0.5.h,
//                   ),
//                   SizedBox(height: 16.h),
//                   Padding(
//                     padding: EdgeInsets.only(left: 4.w, right: 4.w),
//                     child: Text(
//                       widget.item.description.toString(),
//                       textAlign: TextAlign.justify,
//                       style: FontManager.bodyText.copyWith(
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 4.h),
//             Padding(
//               padding: EdgeInsets.only(left: 12.w, right: 12.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       // Call Button
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(50.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               offset: Offset(0, 2),
//                               blurRadius: 6.r,
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                              Padding(
//                               padding: EdgeInsets.only(
//                                   left: 12.w, top: 8.h, bottom: 8.h),
//                               child: Text(
//                                 contactProvider.companyProfile?.name
//                                         ?.toString() ??
//                                     "",
//                                 style: FontManager.headline.copyWith(
//                                   color: Colors.green,
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () => _launchPhone(contactProvider
//                                       .companyProfile?.phone
//                                       ?.toString() ??
//                                   ""),
//                               child: Padding(
//                                 padding:
//                                     EdgeInsets.only(left: 12.w, right: 12.w),
//                                 child: Icon(
//                                   Icons.call,
//                                   size: 22.sp,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(
//                         height: 16.h,
//                       ),

//                       // Call Button
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(50.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               offset: Offset(0, 2),
//                               blurRadius: 6.r,
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                              Padding(
//                               padding: EdgeInsets.only(
//                                   left: 12.w, top: 8.h, bottom: 8.h),
//                               child: Text(
//                                 contactProvider.companyProfile?.name
//                                         ?.toString() ??
//                                     "",
//                                 style: FontManager.headline.copyWith(
//                                   color: Colors.green,
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             // InkWell(
//                             //   onTap: () => _launchPhone(contactProvider
//                             //           .contactModel?.contactNumbertwo
//                             //           ?.toString() ??
//                             //       ""),
//                             //   child: Padding(
//                             //     padding:
//                             //         EdgeInsets.only(left: 12.w, right: 12.w),
//                             //     child: Icon(
//                             //       Icons.call,
//                             //       size: 22.sp,
//                             //       color: Colors.green,
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   InkWell(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           final provider = Provider.of<CustomerProductBuyApi>(
//                               context,
//                               listen: false);
//                           return AlertDialog(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             title: Text(
//                               "Order Confirmation",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                                 fontSize: 22.sp,
//                               ),
//                             ),
//                             content: Text(
//                               "Are you sure you want to place this order?",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             actions: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(context); // Close dialog
//                                     },
//                                     child: Container(
//                                       height: 35.h,
//                                       width: 90.w,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue,
//                                         borderRadius:
//                                             BorderRadius.circular(5.r),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           "Cancel",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 14.sp,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Consumer<CustomerProductBuyApi>(
//                                     builder: (context, provider, child) {
//                                       return TextButton(
//                                         onPressed: provider.isLoading
//                                             ? null
//                                             : () {
//                                                 // Show loading dialog
//                                                 showDialog(
//                                                   context: context,
//                                                   barrierDismissible:
//                                                       false, // Prevent dismissing by tapping outside
//                                                   builder: (context) {
//                                                     return Center(
//                                                       child: SpinKitCircle(
//                                                         color: Colors.red,
//                                                         size: 50.0.sp,
//                                                       ),
//                                                     );
//                                                   },
//                                                 );

//                                                 provider
//                                                     .fetchCustomerCodeAndSendOrder(
//                                                   wallpostId: widget
//                                                       .item.productSlNo
//                                                       .toString(),
//                                                 )
//                                                     .then((_) {
//                                                   Navigator.pop(
//                                                       context); // Close loading dialog
//                                                   Navigator.pop(
//                                                       context); // Close order confirmation dialog
//                                                   if (provider.errorMessage ==
//                                                       null) {
//                                                     CustomToast.show(
//                                                       context: context,
//                                                       text:
//                                                           "Order completed successfully",
//                                                       isSuccess: true,
//                                                     );
//                                                   } else {
//                                                     CustomToast.show(
//                                                       context: context,
//                                                       text: provider
//                                                               .errorMessage ??
//                                                           "An error occurred",
//                                                       isSuccess: false,
//                                                     );
//                                                   }
//                                                 }).catchError((error) {
//                                                   Navigator.pop(
//                                                       context); // Close loading dialog
//                                                   CustomToast.show(
//                                                     context: context,
//                                                     text: "Error: $error",
//                                                     isSuccess: false,
//                                                   );
//                                                 });
//                                               },
//                                         child: Container(
//                                           height: 35.h,
//                                           width: 90.w,
//                                           decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.r),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               "Confirm Order",
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12.sp,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Card(
//                       elevation: 5,
//                       child: Container(
//                         height: 35.h,
//                         width: 120.w,
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(AppSize.s5.r),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Order Now",
//                             style: FontManager.bodyText.copyWith(
//                               color: ColorManager.white,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//           ],
//         ),
//       ),
//     );
//   }

//   void _openZoomView(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return Scaffold(
//           backgroundColor: Colors.black,
//           appBar: AppBar(
//             backgroundColor: Colors.black,
//             elevation: 0,
//             actions: [
//               Padding(
//                 padding: EdgeInsets.only(top: 10.h),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 30.sp,
//                   ),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//               ),
//             ],
//           ),
//           body: PhotoViewGallery.builder(
//             itemCount: widget.item.productGallery?.length ?? 0,
//             pageController: PageController(initialPage: _currentIndex),
//             onPageChanged: (index) => setState(() => _currentIndex = index),
//             builder: (context, index) {
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: NetworkImage(
//                   'https://soft.madicaltrade.com/uploads/product_gallery/${widget.item.productGallery?[index].productImage}',
//                 ),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//                 heroAttributes: PhotoViewHeroAttributes(tag: 'gallery_$index'),
//               );
//             },
//             loadingBuilder: (context, event) => Center(
//               child: CircularProgressIndicator(
//                 value: event == null
//                     ? null
//                     : event.cumulativeBytesLoaded /
//                         (event.expectedTotalBytes ?? 1),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _launchPhone(String phoneNumber) async {
//     final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
//     await launchUrl(launchUri);
//   }
// }

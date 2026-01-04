import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/slider_controller.dart';
import 'package:medical_trade/model/get_sales_old_machine_product_model.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:medical_trade/utilities/zoom_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SalesOldMachineDetailsView extends StatefulWidget {
  final GetSalesOldMachineModel item;
  const SalesOldMachineDetailsView({super.key, required this.item});

  @override
  State<SalesOldMachineDetailsView> createState() =>_SalesOldMachineDetailsViewState();
}
int _currentIndex = 0;
class _SalesOldMachineDetailsViewState extends State<SalesOldMachineDetailsView> {
  void _onAppBarTitleTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTap: _onAppBarTitleTap,
        title: "Sales Old Machine Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _openZoomView(context),
                child: CarouselSlider(
                  items: widget.item.images!.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          width: double.infinity.w,
                          'https://soft.madicaltrade.com/uploads/client_gallery/${item.clientpostImage}',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2.0,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      Provider.of<AppProvider>(context, listen: false).setCarouselIndex(index);
                    },
                  ),
                ),
              ),
              Consumer<AppProvider>(builder: (context, provider, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.item.images!.map((url) {
                    int index = widget.item.images!.indexOf(url);
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
                  }).toList(),
                );
              }),
              SizedBox(height: 40.h),
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
                                imageUrl:'https://soft.madicaltrade.com/uploads/client_gallery/${widget.item.images?[0].clientpostImage}'),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://soft.madicaltrade.com/uploads/client_gallery/${widget.item.images?[0].clientpostImage}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
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
                            widget.item.machineName.toString(),
                            textAlign: TextAlign.start,
                            style: FontManager.headline.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "BDT ${widget.item.machinePrice}",
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
                                "Condition :",
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.item.machineCondition.toString(),
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Text(
                                "Model :",
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.item.machineModel.toString(),
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Text(
                                "Origin :",
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.item.origin.toString(),
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Text(
                                "Cell :",
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: FontManager.headline.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: AutoSizeText(
                                  widget.item.mobile.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: FontManager.headline.copyWith(
                                    color: Colors.green,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => _launchPhone(
                                      widget.item.mobile.toString()),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 12.w),
                                    child: Container(
                                      height: 36.h,
                                      width: 36.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF46AB67),
                                        borderRadius: BorderRadius.circular(2.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0.r),
                                        child: Icon(
                                          Icons.call,
                                          size: 20.sp,
                                          color: const Color.fromARGB(255, 246, 250, 248),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _launchMessage(widget.item.mobile.toString()),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 12.w),
                                    child: Container(
                                      height: 36.h,
                                      width: 36.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF46AB67),
                                        borderRadius:BorderRadius.circular(2.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: Icon(
                                          Icons.message,
                                          size: 20.sp,
                                          color: const Color.fromARGB(255, 246, 250, 248),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                  style: FontManager.bodyText.copyWith(fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  void _launchMessage(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'sms', path: phoneNumber);
    await launchUrl(launchUri);
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
                  icon: Icon(Icons.close,color: Colors.white,size: 30.sp),
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
                  'https://soft.madicaltrade.com/uploads/client_gallery/${widget.item.images?[index].clientpostImage}',
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: PhotoViewHeroAttributes(tag: 'gallery_$index'),
              );
            },
            loadingBuilder: (context, event) => Center(
              child: CircularProgressIndicator(
                value: event == null ? null
                    : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
              ),
            ),
          ),
        );
      },
    );
  }
}

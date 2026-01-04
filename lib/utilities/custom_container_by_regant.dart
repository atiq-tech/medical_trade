import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';

class CustomConatinerByReagent extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const CustomConatinerByReagent({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8.r),
      child: Card(
        child: Container(
          height: AppSize.s200.h,
          width: AppSize.s160.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F8FF),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 12.r,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    ImageAssets.byReagent,
                    height: AppSize.s40.h,
                    width: AppSize.s40.w,
                  ),
                ),
                SizedBox(height: AppMargin.m4.w),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: FontManager.subheadingTwo.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

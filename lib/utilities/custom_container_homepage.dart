import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final Color? backgroundColor;
  final String text;
  final Color textColor;
  final String iconPath;
  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Container(
          height: 130.h,
          width: 130.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F8FF),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.3),
            //     blurRadius: 12.r,
            //     offset: const Offset(2, 2),
            //   ),
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.3),
            //     blurRadius: 12.r,
            //     offset: const Offset(-2, -2),
            //   ),
            // ],
          ),
          child: Padding(
            padding: EdgeInsets.all(6.0.r),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(iconPath,height: 35.h, width: 35.w),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor,fontSize: 15.sp,fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

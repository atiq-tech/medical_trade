import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final Color? backgroundColor;
  final String text;
  final Color textColor;
  final String? iconPath;
  final IconData? iconData;
  final String? networkImageUrl;
  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    this.iconPath,
    this.iconData,
    this.networkImageUrl,
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
          ),
          child: Padding(
            padding: EdgeInsets.all(6.r),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (networkImageUrl != null && networkImageUrl!.isNotEmpty)
                    Image.network(
                      networkImageUrl!,
                      height: 35.h,
                      width: 35.w,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          Icon(iconData, size: 35.sp, color: textColor),
                    )
                  else if (iconPath != null)
                    Image.asset(
                      iconPath!,
                      height: 35.h,
                      width: 35.w,
                    )
                  else if (iconData != null)
                    Icon(
                      iconData,
                      size: 35.sp,
                      color: textColor,
                    ),
                  SizedBox(height: 6.h),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
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

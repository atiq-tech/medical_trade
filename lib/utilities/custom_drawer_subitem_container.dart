import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawerSubitem extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String title;

  const CustomDrawerSubitem({
    required this.onTap,
    required this.color,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: color,
        height: 30.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, size: 18.sp, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/utilities/values_manager.dart';

class CustomTextFromfieldTwo extends StatelessWidget {
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CustomTextFromfieldTwo({
    super.key,
    required this.title,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          ":",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 8,
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSize.s5.r),
              border: Border.all(
                color: Colors.grey,
                width: 0.5.w,
              ),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 7.h,
                  horizontal: 8.w,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(AppSize.s8.r),
                ),
                filled: true,
                fillColor: Colors.white,
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

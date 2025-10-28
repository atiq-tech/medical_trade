import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontManager {
  // Font Sizes
  static const double size12 = 12.0;
  static const double size14 = 14.0;
  static const double size18 = 18.0;
  static const double size24 = 24.0;

  // Font Weights
  static const FontWeight w400 = FontWeight.w400;
  static const FontWeight w500 = FontWeight.w500;
  static const FontWeight w700 = FontWeight.w700; // Bold

  // Colors
  static const Color red = Colors.red;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color primaryBlue = Color(0xFF2B80EF);

  // Default Text Styles
  static TextStyle get headline => TextStyle(
        fontSize: size24.sp,
        fontWeight: w700,
        color: black,
      );

  static TextStyle get subheading => TextStyle(
        fontSize: size18.sp,
        fontWeight: w500,
        color: black,
      );
  static TextStyle get subheadingTwo => TextStyle(
        fontSize: size18.sp,
        fontWeight: w500,
        color: white,
      );

  static TextStyle get bodyText => TextStyle(
        fontSize: size14.sp,
        fontWeight: w400,
        color: black,
      );
  static TextStyle get appbarText => TextStyle(
        fontSize: size14.sp,
        fontWeight: w500,
        color: black,
      );
  static TextStyle get smallText => TextStyle(
        fontSize: size12.sp,
        fontWeight: w400,
        color: black,
      );
  static TextStyle get smallTextbottomnavigaton => TextStyle(
        fontSize: size12.sp,
        fontWeight: w700,
        color: black,
      );

  static TextStyle get errorText => TextStyle(
        fontSize: size14.sp,
        fontWeight: w400,
        color: red,
      );

  static TextStyle hintTextStyle = TextStyle(
    fontSize: 12.sp, // Adjust as needed
    color: Colors.grey, // Adjust color if needed
  );
}

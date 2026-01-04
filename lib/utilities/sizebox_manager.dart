import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:medical_trade/utilities/values_manager.dart';

class SizedBoxManager {
  static Widget height(double margin) {
    return SizedBox(height: margin.h); 
  }
  static Widget width(double margin) {
    return SizedBox(width: margin.w);
  }
  static Widget size({double? height, double? width}) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
    );
  }

  // Predefined SizedBox heights
  static Widget height4() => height(AppMargin.m4);
  static Widget height8() => height(AppMargin.m8);
  static Widget height10() => height(AppMargin.m10);
  static Widget height12() => height(AppMargin.m12);
  static Widget height16() => height(AppMargin.m16);
  static Widget height20() => height(AppMargin.m20);
  static Widget height24() => height(AppMargin.m24);
  static Widget height30() => height(AppMargin.m32);
  static Widget height32() => height(AppMargin.m32);

  // Predefined SizedBox widths
  static Widget width4() => width(AppMargin.m4);
  static Widget width8() => width(AppMargin.m8);
  static Widget width12() => width(AppMargin.m12);
  static Widget width16() => width(AppMargin.m16);
  static Widget width20() => width(AppMargin.m20);
  static Widget width24() => width(AppMargin.m24);
  static Widget width30() => width(AppMargin.m32);
  static Widget width32() => width(AppMargin.m32);

  // Predefined SizedBox sizes
  static Widget size4() => size(height: AppMargin.m4, width: AppMargin.m4);
  static Widget size8() => size(height: AppMargin.m8, width: AppMargin.m8);
  static Widget size12() => size(height: AppMargin.m12, width: AppMargin.m12);
  static Widget size16() => size(height: AppMargin.m16, width: AppMargin.m16);
  static Widget size20() => size(height: AppMargin.m20, width: AppMargin.m20);
  static Widget size24() => size(height: AppMargin.m24, width: AppMargin.m24);
  static Widget size30() => size(height: AppMargin.m32, width: AppMargin.m32);
}

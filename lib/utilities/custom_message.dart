import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToast {
  final BuildContext context;
  final String text;
  final bool isSuccess;

  CustomToast._(
      {required this.context, required this.text, required this.isSuccess});

  // Named constructor for creating and showing the custom toast
  factory CustomToast.show(
      {required BuildContext context,
      required String text,
      required bool isSuccess}) {
    final customToast =
        CustomToast._(context: context, text: text, isSuccess: isSuccess);
    customToast._show();
    return customToast;
  }

  void _show() {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Padding(
        padding: EdgeInsets.only(top: 30.h, left: 5.w, right: 5.w),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 12.0.h),
              decoration: BoxDecoration(
                color: isSuccess
                    ? const Color.fromARGB(255, 71, 184, 129)
                    : const Color.fromARGB(255, 240, 120, 120),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 10.0.r,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSuccess ? Icons.check_circle : Icons.error,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.0.w),
                  Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 12.0.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

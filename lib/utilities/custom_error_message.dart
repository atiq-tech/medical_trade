import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorToast {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static void show({
    required String text,
  }) {
    final overlay = _navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => Padding(
        padding: EdgeInsets.only(top: 30.h, left: 12.w, right: 12.w),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 120, 120),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 12.0.w),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 16.0.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}

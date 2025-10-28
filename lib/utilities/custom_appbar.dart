import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/utilities/font_manager.dart'; // Adjust import based on your project structure

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  final String? title;

  const CustomAppBar({super.key, this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.appbarColor,
      leading: InkWell(
        onTap: onTap,
        child: Icon(Icons.arrow_back, size: 20.r),
      ),
      title: Text(
        title ?? "No Data Found",
        style:FontManager.subheading,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

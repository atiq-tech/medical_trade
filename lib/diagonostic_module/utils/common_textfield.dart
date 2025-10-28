import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/diagonostic_module/utils/all_textstyle.dart';

class CommonTextFieldRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines; // ✅ Added

  const CommonTextFieldRow({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLines = 1, // ✅ Default 1 line
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: maxLines > 1
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center, // ✅ Proper alignment for multiline
      children: [
        Expanded(
          flex: 6,
          child: Text(
            label,
            style: AllTextStyle.textFieldHeadStyle,
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(":"),
        ),
        Expanded(
          flex: 16,
          child: SizedBox(
            // ✅ Height depends on number of lines
            height: (25.0.h * maxLines).clamp(25.0.h, 100.0.h),
            width: MediaQuery.of(context).size.width / 2,
            child: TextField(
              maxLines: maxLines, // ✅ Use maxLines
              style: AllTextStyle.dropDownlistStyle,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AllTextStyle.textValueStyle,
                contentPadding: EdgeInsets.only(left: 5.w, top: 4.h),
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                enabledBorder: TextFieldInputBorder.focusEnabledBorder,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


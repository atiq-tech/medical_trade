import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppFAB extends StatelessWidget {
  const WhatsAppFAB({super.key, this.phone});

  /// country code সহ number দিন (8801xxxxxxx)
  final String? phone;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 9,
      backgroundColor: Colors.transparent,
      onPressed: () {
        WhatsAppHelper.launchWhatsApp(phone: phone);
      },
      child: ClipOval(
        child: Image.asset(
          'assets/icons/wup.png',
          width: 56.w,
          height: 56.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class WhatsAppHelper {
  static Future<void> launchWhatsApp({String? phone}) async {
    final String url = phone == null || phone.isEmpty
        ? "https://wa.me/"
        : "https://wa.me/$phone";
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint("WhatsApp launch failed: $e");
    }
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppFAB extends StatelessWidget {
  const WhatsAppFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 9,
      backgroundColor: Colors.transparent,
      onPressed: () {
        WhatsAppHelper.launchWhatsApp();
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
  static Future<void> launchWhatsApp() async {
    const String url = "https://web.whatsapp.com/";
    //const String url = "https://wa.me/";
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch WhatsApp';
    }
  }
}

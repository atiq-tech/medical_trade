// text কে image বানাতে:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' as fw show FontLoader;
import 'package:flutter/widgets.dart' as fw;
import 'dart:ui' as ui;

Future<Uint8List> textToImage(
  String text, {
  double fontSize = 14,
  double maxWidth = 300,
}) async {
  final fontData = await rootBundle.load('assets/fonts/NotoSansBengali-Regular.ttf');
  final fontLoader = fw.FontLoader('NotoSansBengali');
  fontLoader.addFont(Future.value(fontData));
  await fontLoader.load();

  final recorder = ui.PictureRecorder();

  final textSpan = fw.TextSpan(
    text: text,
    style: fw.TextStyle(
      fontSize: fontSize,
      fontFamily: 'NotoSansBengali',
      color: Colors.black,
      fontWeight: fw.FontWeight.w900,
    ),
  );

  final painter = fw.TextPainter(
    text: textSpan,
    textDirection: fw.TextDirection.ltr,
    maxLines: 2, // ✅ সর্বোচ্চ ২ লাইনে কেটে দেবে
    ellipsis: '...', // ✅ বেশি হলে ... দেখাবে
  );

  painter.layout(maxWidth: maxWidth);

  final double textWidth = painter.width > 0 ? painter.width : maxWidth;
  final double textHeight =
      painter.height > 0 ? painter.height : fontSize * 2 + 10;

  final canvas = ui.Canvas(
    recorder,
    ui.Rect.fromLTWH(0, 0, textWidth, textHeight),
  );
  painter.paint(canvas, const ui.Offset(0, 0));

  final picture = recorder.endRecording();
  final img = await picture.toImage(
    textWidth.ceil(),
    textHeight.ceil(),
  );

  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}


// Future<Uint8List> textToImage(
//   String text, {
//   double fontSize = 22,
//   double maxWidth = 400,
// }) async {
//   // Font load
//   final fontData =
//       await rootBundle.load('assets/fonts/NotoSansBengali-Regular.ttf');
//   final fontLoader = fw.FontLoader('NotoSansBengali');
//   fontLoader.addFont(Future.value(fontData));
//   await fontLoader.load();

//   final recorder = ui.PictureRecorder();

//   // Text define
//   final textSpan = fw.TextSpan(
//     text: text,
//     style: fw.TextStyle(
//       fontSize: fontSize,
//       fontFamily: 'NotoSansBengali',
//       color: Colors.black,
//       fontWeight: fw.FontWeight.w900,
//     ),
//   );

//   final painter = fw.TextPainter(
//     text: textSpan,
//     textDirection: fw.TextDirection.ltr,
//     maxLines: null,
//   );

//   painter.layout(maxWidth: maxWidth);

//   // Dimension fix
//   final double textWidth = painter.width > 0 ? painter.width : maxWidth;
//   final double textHeight =
//       painter.height > 0 ? painter.height : fontSize + 10;

//   // Canvas draw
//   final canvas = ui.Canvas(
//     recorder,
//     ui.Rect.fromLTWH(0, 0, textWidth, textHeight),
//   );
//   painter.paint(canvas, const ui.Offset(0, 0));

//   final picture = recorder.endRecording();

//   // এখানে width/height কে int করে দিচ্ছি
//   final img = await picture.toImage(
//     textWidth.ceil(),
//     textHeight.ceil(),
//   );

//   final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//   return byteData!.buffer.asUint8List();
// }







// // text কে image বানাতে:
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/services.dart' as fw show FontLoader;
// import 'package:flutter/widgets.dart' as fw;
// import 'dart:ui' as ui;


// Future<Uint8List> textToImage(String text,
//     {double fontSize = 22, double maxWidth = 400}) async {
//   final fontData = await rootBundle.load('assets/fonts/NotoSansBengali-Regular.ttf');
//   final fontLoader = fw.FontLoader('NotoSansBengali');
//   fontLoader.addFont(Future.value(fontData));
//   await fontLoader.load();

//   final recorder = ui.PictureRecorder();

//   // First: measure painter
//   final textSpan = fw.TextSpan(
//     text: text,
//     style: fw.TextStyle(
//       fontSize: fontSize,
//       fontFamily: 'NotoSansBengali',
//       color: Colors.black,
//       fontWeight: fw.FontWeight.w900
//     ),
//   );

//   final painter = fw.TextPainter(
//     text: textSpan,
//     textDirection: fw.TextDirection.ltr,
//     maxLines: null,
//   );

//   painter.layout(maxWidth: maxWidth);

//   // Create canvas with exact size
//   final canvas = ui.Canvas(recorder, ui.Rect.fromLTWH(0, 0, painter.width, painter.height));
//   painter.paint(canvas, const ui.Offset(0, 0));

//   final picture = recorder.endRecording();
//   final img = await picture.toImage(painter.width.ceil(), painter.height.ceil());
//   final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//   return byteData!.buffer.asUint8List();
// }

///======

// Future<Uint8List> textToImage(String text, {double fontSize = 22, double maxWidth = 500}) async {
//   final fontData = await rootBundle.load('assets/fonts/NotoSansBengali-Regular.ttf');
//   final fontLoader = fw.FontLoader('NotoSansBengali');
//   fontLoader.addFont(Future.value(fontData));
//   await fontLoader.load();

//   // TextPainter with multi-line wrap
//   final recorder = ui.PictureRecorder();
//   final canvas = ui.Canvas(recorder);

//   final textSpan = fw.TextSpan(
//     text: text,
//     style: fw.TextStyle(
//       fontSize: fontSize,
//       fontFamily: 'NotoSansBengali',
//       color: fw.Color(0xFF000000),
//     ),
//   );

//   final painter = fw.TextPainter(
//     text: textSpan,
//     textDirection: fw.TextDirection.ltr,
//     maxLines: null, // unlimited lines
//   );

//   painter.layout(maxWidth: maxWidth); // wrap text if wider than maxWidth
//   painter.paint(canvas, const ui.Offset(0, 0));

//   final picture = recorder.endRecording();
//   final img = await picture.toImage(
//     painter.width.ceil(),
//     painter.height.ceil(),
//   );
//   final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//   return byteData!.buffer.asUint8List();
// }


// Future<Uint8List> textToImage(String text) async {
//   final recorder = ui.PictureRecorder();
//   final canvas = ui.Canvas(recorder);
//   final painter = fw.TextPainter(
//     text: fw.TextSpan(
//       text: text,
//       style: const fw.TextStyle(fontSize: 22, fontFamily: 'NotoSansBengali'),
//     ),
//     textDirection: fw.TextDirection.ltr,
//   );
//   painter.layout();
//   painter.paint(canvas, const ui.Offset(0, 0));

//   final picture = recorder.endRecording();
//   final img = await picture.toImage(painter.width.ceil(), painter.height.ceil());
//   final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//   return byteData!.buffer.asUint8List();
// }

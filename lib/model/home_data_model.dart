
import 'package:flutter/material.dart';

class HomeItem {
  final String text;
  final String iconPath;
  final Color backgroundColor;
  final Widget destination;

  HomeItem({
    required this.text,
    required this.iconPath,
    required this.backgroundColor,
    required this.destination,
  });
}

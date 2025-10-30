import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FancyNoDataDialog extends StatefulWidget {
  const FancyNoDataDialog({super.key});

  @override
  State<FancyNoDataDialog> createState() => _FancyNoDataDialogState();
}

class _FancyNoDataDialogState extends State<FancyNoDataDialog>
    with TickerProviderStateMixin {
  late AnimationController _textJumpController;
  late Animation<Offset> _jumpAnimation;

  late AnimationController _dotRotationController;
  late AnimationController _gradientAnimationController;

  final List<Color> rainbowColors = [
    Colors.indigo.shade900,
    Colors.red.shade900,
    Colors.green.shade900,
    Colors.blue.shade900,
    Colors.orange.shade900,
    Colors.cyan.shade900,
    Colors.purple.shade900,
  ];

  @override
  void initState() {
    super.initState();

    _textJumpController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _jumpAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.12),
    ).animate(CurvedAnimation(
      parent: _textJumpController,
      curve: Curves.easeInOut,
    ));

    _dotRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _textJumpController.dispose();
    _dotRotationController.dispose();
    _gradientAnimationController.dispose();
    super.dispose();
  }

  Widget _buildDot(double angle, Color color) {
    final double radius = 20.0.r;
    return Transform.translate(
      offset: Offset(
        radius * cos(angle),
        radius * sin(angle),
      ),
      child: Container(
        width: 12.w,
        height: 12.h,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.6), blurRadius: 6.r),
          ],
        ),
      ),
    );
  }

  Widget _buildRotatingDots() {
    return AnimatedBuilder(
      animation: _dotRotationController,
      builder: (_, child) {
        final double rotation = _dotRotationController.value * 2 * pi;

        return SizedBox(
          width: 60.w,
          height:60.h,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(rainbowColors.length, (index) {
              double angle =
                  rotation + (2 * pi * index / rainbowColors.length);
              return _buildDot(angle, rainbowColors[index]);
            }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: _gradientAnimationController,
          builder: (context, child) {
            return Container(
              height: 150.h,
              width: 280.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.lerp(
                      Colors.pink.shade100,
                      Colors.blue.shade200,
                      sin(_gradientAnimationController.value * 2 * pi) * 0.5 + 0.5,
                    )!,
                    Color.lerp(
                      Colors.blue.shade200,
                      Colors.pink.shade100,
                      sin(_gradientAnimationController.value * 2 * pi) * 0.5 + 0.5,
                    )!,
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20.r,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRotatingDots(),
                  SizedBox(height: 15.h),
                  SlideTransition(
                    position: _jumpAnimation,
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
                        letterSpacing: 3.3.w,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



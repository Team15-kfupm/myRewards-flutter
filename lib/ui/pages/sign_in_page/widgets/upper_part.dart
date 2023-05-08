import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import '../../../../utils/constants.dart';

class UpperPart extends StatefulWidget {
  const UpperPart({Key? key}) : super(key: key);

  @override
  State<UpperPart> createState() => _UpperPartState();
}

class _UpperPartState extends State<UpperPart> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          builder: (BuildContext context, double value, Widget? child) {
            return Opacity(
                opacity: value,
                child: Padding(
                  padding: EdgeInsets.only(top: value * 15),
                  child: child,
                ));
          },
          duration: const Duration(milliseconds: 1000),
          tween: Tween<double>(begin: 0, end: 1),
          child: Center(
            child: SvgPicture.asset(
              'assets/logo.svg',
              width: 80.w,
              height: 80.h,
            ),
          ),
        ),
        Text('My Rewards',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: whiteColor,
            )),
      ],
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  HalfCirclePainter({required this.color, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = math.pi / 2;
    const sweepAngle = math.pi;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

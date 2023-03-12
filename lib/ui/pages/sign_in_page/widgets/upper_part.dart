import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';

class UpperPart extends StatelessWidget {
  const UpperPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h,
      width: 375.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [blackColor.withOpacity(0.5), secondaryColor],
              begin: Alignment.topCenter,
              end: Alignment.center)),
      child: Center(
        child: Image.asset(
          'assets/app_logo.png',
          height: 142.h,
          width: 144.w,
        ),
      ),
    );
  }
}

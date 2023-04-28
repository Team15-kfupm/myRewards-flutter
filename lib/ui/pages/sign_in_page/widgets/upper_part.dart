import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';

class UpperPart extends StatelessWidget {
  const UpperPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Center(
            child: Image.asset(
              'assets/app_logo.png',
              height: 142.h,
              width: 144.w,
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

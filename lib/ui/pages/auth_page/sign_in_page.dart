import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sign In',
              style: titleTextStyle,
            ),
            InkWell(
                child: Icon(
              Icons.close,
              size: 24.r,
            ))
          ],
        ),
        58.verticalSpace,
        TextField(
          enabled: true,
          decoration: InputDecoration(
            fillColor: whiteColor,
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.r),
                ),
                borderSide: const BorderSide(color: primaryColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.r),
                ),
                borderSide: const BorderSide(color: primaryColor)),
            prefixIcon: const Icon(
              Icons.phone_iphone_outlined,
              color: Colors.black,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
            hintText: 'Phone number',
          ),
        ),
        60.verticalSpace,
        InkWell(
          onTap: () {},
          child: Container(
            height: 60.h,
            width: 318.w,
            decoration: signInButtonStyle,
            child: Center(
              child: Text(
                'SIGN IN',
                style: signInButtonTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Create Your Account',
              style: titleTextStyle,
            ),
            InkWell(
                child: Icon(
              Icons.close,
              size: 24.r,
            ))
          ],
        ),
        64.verticalSpace,
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
        52.verticalSpace,
        Text(
          'By creating account, you agree to our',
          style: smallTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {},
                child: Text(
                  'Terms',
                  style: smallPrimaryTextStyle,
                )),
            Text(
              ' and ',
              style: smallTextStyle,
            ),
            InkWell(
                onTap: () {},
                child: Text(
                  'Conditions',
                  style: smallPrimaryTextStyle,
                )),
          ],
        ),
        29.verticalSpace,
        InkWell(
          onTap: () {},
          child: Container(
            height: 60.h,
            width: 318.w,
            decoration: signInButtonStyle,
            child: Center(
              child: Text(
                'CREATE ACCOUNT',
                style: signInButtonTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';


class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({Key? key}) : super(key: key);

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
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
        contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
        hintText: 'Phone number',
      ),
    );
  }
}

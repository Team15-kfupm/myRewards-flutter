import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:myrewards_flutter/utils/constants.dart';
import '../../../main.dart';
import 'widgets/go_button.dart';
import 'widgets/phone_number_text_field.dart';
import 'widgets/upper_part.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  AuthStructurePageState createState() => AuthStructurePageState();
}

class AuthStructurePageState extends ConsumerState<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final verificationId = ref.watch(verificationIdProvider);
    
    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const UpperPart(),
          Container(
            height: 452.h,
            width: 375.w,
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topRight, child: CloseButton()),
                58.verticalSpace,
                const PhoneNumberTextField(),
                60.verticalSpace,
                const GoButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

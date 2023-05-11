import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:myrewards_flutter/utils/constants.dart';

import '../welcome_page/welcome_page.dart';
import 'widgets/go_button.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

final phoneProvider = StateProvider<String>((ref) => '');

class SignInPageState extends ConsumerState<SignInPage> {
  String _phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Align(alignment: Alignment.topRight, child: CloseButton()),
          25.verticalSpace,
          GestureDetector(
            onTap: () {
              ref.read(offsetProvider.notifier).state =
                  MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewInsets.bottom;
            },
            child: TextField(
              onChanged: (value) {
                _phoneNumber = value;
                setState(() {});
              },
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
                hintText: '05XXXXXXXX',
              ),
            ),
          ),
          60.verticalSpace,
          GoButton(phoneNumber: _phoneNumber.trim()),
        ],
      ),
    );
  }
}

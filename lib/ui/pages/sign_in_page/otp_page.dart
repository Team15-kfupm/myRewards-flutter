// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';
import 'package:myrewards_flutter/main.dart';
import 'package:myrewards_flutter/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:myrewards_flutter/ui/pages/sign_in_page/widgets/go_button.dart';
import 'package:myrewards_flutter/utils/constants.dart';

List<String> _otp = ['', '', '', '', '', ''];
String getOtp() {
  String otp = '';
  for (String character in _otp) {
    otp = otp + character;
  }
  return otp;
}

void setOtp(String otp, int index) {
  _otp[index] = otp;
}

final countDownProvider = StateProvider.autoDispose<int>((ref) => 50);

class OTPPage extends ConsumerStatefulWidget {
  const OTPPage({
    Key? key,
  }) : super(key: key);

  @override
  OTPPageState createState() => OTPPageState();
}

class OTPPageState extends ConsumerState<OTPPage> {
  @override
  void didChangeDependencies() {
    context.dependOnInheritedWidgetOfExactType();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (!ref.read(isLoadingProvider)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, color: blackColor)),
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: ref.watch(isLoadingProvider)
          ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: transparentColor,
                child: Center(
                  child: Container(
                    height: 180.w,
                    width: 180.w,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    ),
                    child: Lottie.asset('assets/lottie/loading.json',
                        height: 180.w, width: 180.w),
                  ),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Column(children: [
                    Text(
                        'Enter OTP sent to your mobile \n ${ref.read(phoneProvider)}',
                        textAlign: TextAlign.center,
                        style: oTPLabelTextStyle),
                    20.verticalSpace,
                    const OTPField(),
                    25.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //create countdown timer
                        Consumer(
                          builder: (context, ref, child) {
                            Future.delayed(const Duration(seconds: 1), () {
                              if (ref.read(countDownProvider.notifier).state >
                                  0) {
                                ref.read(countDownProvider.notifier).state--;
                              }
                            });

                            return Text("00:${ref.watch(countDownProvider)}s",
                                style: expireOTPCountdownTextStyle);
                          },
                        ),

                        TextButton(
                            onPressed: ref.watch(countDownProvider) == 0
                                ? () {
                                    ref.read(countDownProvider.notifier).state =
                                        50;

                                    AuthService().signInWithPhoneNumber(
                                        ref, ref.read(phoneProvider));
                                  }
                                : () {},
                            style: noBackgroundButtonStyle,
                            child: Text('Resend Code',
                                style: ref.watch(countDownProvider) == 0
                                    ? forgotPasswordTextStyle
                                    : expireOTPCountdownTextStyle))
                      ],
                    )
                  ]),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: InkWell(
                      onTap: () async {
                        try {
                          await AuthService().verifyOTP(
                              ref.read(verificationIdProvider),
                              getOtp(),
                              context);
                        } catch (e) {
                          log(e.toString());
                          Flushbar(
                            message: 'Please enter a valid OTP',
                            duration: const Duration(milliseconds: 1300),
                            flushbarStyle: FlushbarStyle.FLOATING,
                            backgroundColor: Colors.red,
                            flushbarPosition: FlushbarPosition.TOP,
                          ).show(context);
                          return;
                        }
                        Navigator.pop(context);
                      },
                      highlightColor: whiteColor,
                      child: Container(
                        width: 314.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Verify',
                              style: largeButtonTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class OTPField extends StatefulWidget {
  const OTPField({
    Key? key,
  }) : super(key: key);

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  List<bool> isEmpty = [true, true, true, true, true, true];
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: isEmpty[0] ? transparentColor : secondaryColor,
              border: Border.all(color: settingsTileArrowIconColor, width: 2.r),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: whiteColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  isEmpty[0] = false;
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                  isEmpty[0] = true;
                }
                setState(() {});
                setOtp(value, 0);
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: isEmpty[1] ? transparentColor : secondaryColor,
              border: Border.all(color: settingsTileArrowIconColor, width: 2.r),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: whiteColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  isEmpty[1] = false;
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                  isEmpty[1] = true;
                }
                setState(() {});
                setOtp(value, 1);
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: isEmpty[2] ? transparentColor : secondaryColor,
              border: Border.all(color: settingsTileArrowIconColor, width: 2.r),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: whiteColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  isEmpty[2] = false;
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                  isEmpty[2] = true;
                }
                setState(() {});
                setOtp(value, 2);
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: isEmpty[3] ? transparentColor : secondaryColor,
              border: Border.all(color: settingsTileArrowIconColor, width: 2.r),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: whiteColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  isEmpty[3] = false;
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                  isEmpty[3] = true;
                }
                setState(() {});
                setOtp(value, 3);
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: isEmpty[4] ? transparentColor : secondaryColor,
              border: Border.all(color: settingsTileArrowIconColor, width: 2.r),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: whiteColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  isEmpty[4] = false;
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                  isEmpty[4] = true;
                }
                setState(() {});
                setOtp(value, 4);
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: isEmpty[5] ? transparentColor : secondaryColor,
              border: Border.all(color: settingsTileArrowIconColor, width: 2.r),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: whiteColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  isEmpty[5] = false;
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                  isEmpty[5] = true;
                }
                setState(() {});
                setOtp(value, 5);
              },
            ),
          ),
        ],
      ),
    );
  }
}

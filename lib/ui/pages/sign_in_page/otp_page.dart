import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';
import 'package:myrewards_flutter/main.dart';
import 'package:myrewards_flutter/ui/pages/sign_in_page/sign_in_page.dart';
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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, color: blackColor)),
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: Padding(
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
                        if (ref.read(countDownProvider.notifier).state > 0) {
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
                              ref.read(countDownProvider.notifier).state = 50;
                              AuthService().signInWithPhoneNumber(
                                  ref, ref.read(phoneProvider).substring(1));
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
                    await AuthService()
                        .verifyOTP(ref.read(verificationIdProvider), getOtp());
                    await ref.read(userInfoProvider.notifier).verifyUser();
                  } catch (e) {
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
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: blackColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
                setOtp(value, 0);
              },
            ),
          ),
          Container(
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: blackColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
                setOtp(value, 1);
              },
            ),
          ),
          Container(
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: blackColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
                setOtp(value, 2);
              },
            ),
          ),
          Container(
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: blackColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
                setOtp(value, 3);
              },
            ),
          ),
          Container(
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: blackColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
                setOtp(value, 4);
              },
            ),
          ),
          Container(
            width: 40.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontSize: 24.r, color: blackColor),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
                setOtp(value, 5);
              },
            ),
          ),
        ],
      ),
    );
  }
}

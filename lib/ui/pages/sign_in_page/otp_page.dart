import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';
import 'package:myrewards_flutter/main.dart';
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

final _formKey = GlobalKey<FormState>();

class OTPPage extends ConsumerStatefulWidget {
  const OTPPage({
    Key? key,
  }) : super(key: key);

  @override
  OTPPageState createState() => OTPPageState();
}

class OTPPageState extends ConsumerState<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_rounded, color: blackColor),
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
              Text('Enter OTP sent to your mobile \n +966 123456789',
                  textAlign: TextAlign.center, style: oTPLabelTextStyle),
              20.verticalSpace,
              const OTPField(),
              25.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //create countdown timer
                  Text('Code expire in 00:30',
                      style: expireOTPCountdownTextStyle),

                  TextButton(
                      onPressed: () {},
                      style: noBackgroundButtonStyle,
                      child:
                          Text('Resend Code', style: forgotPasswordTextStyle))
                ],
              )
            ]),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    String errorMessage = await AuthService()
                        .verifyOTP(ref.read(verificationIdProvider), getOtp());
                    if (errorMessage.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid OTP'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context);
                  }
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
      key: _formKey,
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter OTP';
                }
                return null;
              },
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

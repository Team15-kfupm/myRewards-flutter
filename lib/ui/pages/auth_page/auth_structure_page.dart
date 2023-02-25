import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/auth_page/sign_in_page.dart';
import 'package:myrewards_flutter/ui/pages/auth_page/sign_up_page.dart';
import 'package:myrewards_flutter/utils/constants.dart';

class AuthStructurePage extends StatefulWidget {
  const AuthStructurePage({Key? key}) : super(key: key);

  @override
  State<AuthStructurePage> createState() => _AuthStructurePageState();
}

enum Stauts { signIn, signUp }

Stauts type = Stauts.signIn;

class _AuthStructurePageState extends State<AuthStructurePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          Container(
            height: 360.h,
            width: 375.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [blackColor.withOpacity(0.5), secondaryColor],
                    begin: Alignment.topCenter,
                    end: Alignment.center)),
            child: Center(
              child: Image.asset(
                'app_logo.png',
                height: 142.h,
                width: 144.w,
              ),
            ),
          ),
          Container(
            height: 450.h,
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
                if (type == Stauts.signIn) const SignInPage(),
                if (type == Stauts.signUp) const SignUpPage(),
                20.verticalSpace,
                if (type == Stauts.signIn)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New User?', style: normaGreylTextStyle),
                      5.horizontalSpace,
                      InkWell(
                        onTap: () {
                          setState(() {
                            type = Stauts.signUp;
                          });
                        },
                        child: Text(
                          'Create Account',
                          style: normaPrimarylTextStyle,
                        ),
                      ),
                    ],
                  ),
                if (type == Stauts.signUp)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already Have Account?', style: normaGreylTextStyle),
                      5.horizontalSpace,
                      InkWell(
                        onTap: () {
                          setState(() {
                            type = Stauts.signIn;
                          });
                        },
                        child: Text(
                          'Sign In',
                          style: normaPrimarylTextStyle,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

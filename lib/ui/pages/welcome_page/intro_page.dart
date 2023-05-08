import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:myrewards_flutter/utils/constants.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        controlsPadding: const EdgeInsets.all(50.0),
        globalBackgroundColor: whiteColor,
        pages: [
          PageViewModel(
            title: 'Welcome to MyRewards',
            body:
                'Now you will be able to get more rewards with each purchase you made!.',
            image: Lottie.asset(
              'assets/lottie/intro1.json',
              height: 250.h,
            ),
          ),
          PageViewModel(
            title: 'We provide stats about your Purchases',
            body: 'To be able to make better decision about your spending.',
            image: Lottie.asset(
              'assets/lottie/intro2.json',
              height: 300.h,
            ),
          ),
        ],
        onDone: () {
          Navigator.pop(context);
        },
        onSkip: () {},
        showSkipButton: false,
        baseBtnStyle: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 0,
          enableFeedback: false,
          foregroundColor: primaryColor,
          shadowColor: transparentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        next: const Text('Next', style: TextStyle(color: whiteColor)),
        done: const Text('Done', style: TextStyle(color: whiteColor)),
        dotsDecorator: DotsDecorator(
          activeColor: primaryColor,
          activeSize: Size(30.0.w, 10.0.w),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:myrewards_flutter/utils/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

int _initPage = 0;

class _IntroPageState extends State<IntroPage> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'TALjHCOPzY0',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isFullScreen
          ? YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                _initPage = 2;
                setState(() {});
              },
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                IconButton(
                    onPressed: () {
                      log(_controller.value.position.toString());

                      _controller.pause();
                      _controller.toggleFullScreenMode();
                    },
                    icon: const Icon(
                      Icons.fullscreen,
                      color: whiteColor,
                    )),
              ],
            )
          : IntroductionScreen(
              controlsPadding: const EdgeInsets.all(50.0),
              globalBackgroundColor: whiteColor,
              initialPage: _initPage,
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
                  body:
                      'To be able to make better decision about your spending.',
                  image: Lottie.asset(
                    'assets/lottie/intro2.json',
                    height: 300.h,
                  ),
                ),
                PageViewModel(
                  title: 'Walkthrough the app',
                  body: 'You can watch this video to know more about the app.',
                  image: Center(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: primaryColor,
                      progressColors: const ProgressBarColors(
                        playedColor: primaryColor,
                        handleColor: primaryColor,
                      ),
                      onReady: () {
                        _initPage = 2;

                        setState(() {});
                      },
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(isExpanded: true),
                        IconButton(
                            onPressed: () {
                              _controller.pause();
                              _controller.toggleFullScreenMode();
                            },
                            icon: const Icon(
                              Icons.fullscreen,
                              color: whiteColor,
                            )),
                      ],
                    ),
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

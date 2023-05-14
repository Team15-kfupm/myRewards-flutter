import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myrewards_flutter/ui/pages/home_page/home_page.dart';
import 'package:myrewards_flutter/ui/pages/welcome_page/intro_page.dart';

import 'package:myrewards_flutter/ui/pages/welcome_page/welcome_page.dart';

import '../../../../core/providers/auth_user_state_provider.dart';

import '../../../../core/providers/user_info_provider.dart';
import '../../../../utils/constants.dart';

import '../../../pages/sign_up_page/sign_up_page.dart';

class AuthChecker extends ConsumerStatefulWidget {
  const AuthChecker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StaState();
}

class _StaState extends ConsumerState<AuthChecker> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authUserProvider);

    return authState.when(
      data: (user) {
        final userData = ref.watch(userInfoProvider);

        return userData.when(
          data: (userInfo) {
            return const HomePage();
          },
          loading: () => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: whiteColor,
            child: Center(
              child: Container(
                height: 180.w,
                width: 180.w,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                child: Lottie.network(
                    'https://assets1.lottiefiles.com/packages/lf20_robeep7z.json',
                    height: 180.w,
                    width: 180.w),
              ),
            ),
          ),
          // should return a page that shows a form to fill in the user's info page
          error: (error, stack) {
            return const SignUpPage();
          },
        );
      },
      loading: () => Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
      )),
      error: (error, stack) => const WelcomePage(),
    );
  }
}

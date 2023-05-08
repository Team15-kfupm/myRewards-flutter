import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/utils/constants.dart';

import '../../../../core/providers/user_info_provider.dart';

class AvatarWithWelcome extends ConsumerStatefulWidget {
  const AvatarWithWelcome({Key? key}) : super(key: key);
  @override
  AvatarWithWelcomeState createState() => AvatarWithWelcomeState();
}

double begin = 0;

class AvatarWithWelcomeState extends ConsumerState<AvatarWithWelcome> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      begin = 1;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userInfoProvider);
    return user.when(
        data: (data) {
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: begin, end: 1),
            curve: Curves.ease,
            duration: const Duration(milliseconds: 1200),
            builder: (context, double value, Widget? child) {
              return Opacity(
                  opacity: value,
                  child: Padding(
                    padding: EdgeInsets.only(top: value * 12),
                    child: child,
                  ));
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: secondaryColor,
                  child: Text(
                    data.name[0].toUpperCase(),
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back,',
                      style: welcomeTextStyle,
                    ),
                    Text(
                      data.name,
                      style: welcomeNameTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        error: (e, s) => Text('avatar with welcome error: $e'),
        loading: () => const Text('loading'));
  }
}

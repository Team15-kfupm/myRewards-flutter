import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/main.dart';
import 'package:myrewards_flutter/utils/constants.dart';

class AvatarWithWelcome extends ConsumerWidget {
  const AvatarWithWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage: const AssetImage('assets/app_logo.png'),
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
              ref.read(userInfoProvider).asData?.value.name ?? '',
              style: welcomeNameTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/utils/constants.dart';

class AvatarWithWelcome extends StatelessWidget {
  const AvatarWithWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Ahmed',
              style: welcomeNameTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}

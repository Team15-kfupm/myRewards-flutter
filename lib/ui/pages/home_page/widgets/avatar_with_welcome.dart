import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/utils/constants.dart';

import '../../../../core/providers/user_info_provider.dart';

class AvatarWithWelcome extends ConsumerWidget {
  const AvatarWithWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userInfoProvider);
    return user.when(
        data: (data) {
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
                    data.name,
                    style: welcomeNameTextStyle,
                  ),
                ],
              ),
            ],
          );
        },
        error: (e, s) => Text('avatar with welcome error: $e'),
        loading: () => const Text('loading'));
  }
}

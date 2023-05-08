import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';
import 'package:myrewards_flutter/utils/constants.dart';

import '../../../core/providers/user_info_provider.dart';
import 'widgets/settings_tile.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: titleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparentColor,
        actions: [
          Row(
            children: [
              Container(
                width: 42.w,
                height: 42.h,
                decoration: const BoxDecoration(
                  color: settingsAppBarIconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    AuthService().signOut();
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: blackColor,
                    size: 22.r,
                  ),
                ),
              ),
              16.horizontalSpace
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                32.verticalSpace,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: secondaryColor,
                      child: Text(
                        ref.read(userInfoProvider).value!.name[0].toUpperCase(),
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    23.horizontalSpace,
                    Text(
                      ref.read(userInfoProvider).value!.name,
                      style: settingsUsernameTextStyle,
                    ),
                  ],
                ),
                37.verticalSpace,
                SettingsTile(
                  title: 'Profile',
                  icon: Icons.account_circle_outlined,
                  onClicked: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                SettingsTile(
                  title: 'Notifications',
                  icon: Icons.notifications_none_outlined,
                  onClicked: () {},
                ),
                SettingsTile(
                  title: 'Location',
                  icon: Icons.location_on_outlined,
                  onClicked: () {},
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'General',
                      style: settingsSectionTitleTextStyle,
                    )),
                30.verticalSpace,
                SettingsTile(
                  title: 'Language',
                  icon: Icons.language_outlined,
                  onClicked: () {},
                ),
                SettingsTile(
                  title: 'Contact Us',
                  icon: Icons.phone_outlined,
                  onClicked: () {},
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Security',
                      style: settingsSectionTitleTextStyle,
                    )),
                30.verticalSpace,
                SettingsTile(
                  title: 'Change Password',
                  icon: Icons.lock_outline,
                  onClicked: () {},
                ),
                SettingsTile(
                  title: 'Privacy Policy',
                  icon: Icons.description_outlined,
                  onClicked: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

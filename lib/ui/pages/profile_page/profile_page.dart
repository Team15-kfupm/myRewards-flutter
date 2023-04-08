import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/profile_page/widgets/profile_birth_date_tile.dart';
import 'package:myrewards_flutter/ui/pages/profile_page/widgets/profile_name_tile.dart';

import '../../../core/providers/user_info_provider.dart';
import '../../../utils/constants.dart';
import 'widgets/profile_email_tile.dart';
import 'widgets/profile_gender_tile.dart';
import 'widgets/profile_phone_tile.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: titleTextStyle,
        ),
        leadingWidth: 90.w,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparentColor,
        leading: Row(
          children: [
            10.horizontalSpace,
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  width: 42.w,
                  height: 42.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: settingsAppBarIconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: blackColor,
                    size: 20.r,
                  )),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(children: [
            Container(
                width: 90.w,
                height: 90.h,
                decoration: const BoxDecoration(
                  color: settingsAppBarIconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  color: blackColor,
                  size: 40.r,
                )),
            21.verticalSpace,
            Text(
              userInfo.asData!.value.name,
              style: settingsUsernameTextStyle,
            ),
            50.verticalSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 26.h),
                    decoration: BoxDecoration(
                      color: settingsAppBarIconBackgroundColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        const ProfileNameTile(),
                        40.verticalSpace,
                        const ProfileEmailTile(),
                        40.verticalSpace,
                        const ProfilePhoneTile(),
                        40.verticalSpace,
                        const ProfileBirthDateTile(),
                        40.verticalSpace,
                        const ProfileGenderTile(),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Joined',
                      style: joinedTextStyle,
                    ),
                    Text(
                      ' 28 Jan 2023',
                      style: joinedDateTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

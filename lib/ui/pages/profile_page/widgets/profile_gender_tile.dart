import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../../utils/constants.dart';

class ProfileGenderTile extends ConsumerStatefulWidget {
  const ProfileGenderTile({Key? key}) : super(key: key);

  @override
  ProfileGenderTileState createState() => ProfileGenderTileState();
}

class ProfileGenderTileState extends ConsumerState<ProfileGenderTile> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(userInfoProvider).gender;
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Gender', style: profileTileValueTextStyle),
        ToggleButtons(
          borderRadius: BorderRadius.circular(20.r),
          borderColor: primaryColor,
          selectedBorderColor: primaryColor,
          selectedColor: whiteColor,
          textStyle: profileUnSelectedGenderTextStyle,
          borderWidth: 2,
          constraints: BoxConstraints(
            minWidth: 90.w,
            minHeight: 40.h,
          ),
          color: greyColor,
          fillColor: primaryColor,
          splashColor: transparentColor,
          isSelected: [userInfo.gender == 'Male', userInfo.gender == 'Female'],
          onPressed: (index) {
            var userInfo = ref.read(userInfoProvider);

            userInfo =
                userInfo.copyWith(gender: index == 0 ? 'Male' : 'Female');

            ref.read(userInfoProvider.notifier).setUserInfo(userInfo);

            Flushbar(
              message: 'Gender Updated Successfully',
              duration: const Duration(milliseconds: 1100),
              flushbarStyle: FlushbarStyle.FLOATING,
              backgroundColor: Colors.green,
              flushbarPosition: FlushbarPosition.TOP,
            ).show(context);
          },
          children: const [
            Text(
              'Male',
            ),
            Text('Female'),
          ],
        ),
      ],
    );
  }
}

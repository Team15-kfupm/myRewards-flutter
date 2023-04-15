import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';

import '../../../../core/providers/user_info_provider.dart';
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
    _controller.text = ref.read(userInfoProvider).asData!.value.gender;
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
          isSelected: [
            userInfo.asData!.value.gender == 'Male',
            userInfo.asData!.value.gender == 'Female'
          ],
          onPressed: (index) async {
            log('index: $index');
            final gender = index == 0 ? 'Male' : 'Female';
            final isUpdated =
                await DB().updateGender(gender, userInfo.value!.uid);
            if (!isUpdated) {
              Flushbar(
                message: 'Something went wrong. Please try again',
                duration: const Duration(milliseconds: 2000),
                flushbarStyle: FlushbarStyle.FLOATING,
                backgroundColor: Colors.red,
                flushbarPosition: FlushbarPosition.TOP,
              ).show(context);
              return;
            }
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

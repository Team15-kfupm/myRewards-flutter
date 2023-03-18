import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../../utils/constants.dart';

class ProfileBirthDateTile extends ConsumerStatefulWidget {
  const ProfileBirthDateTile({Key? key}) : super(key: key);

  @override
  ProfileBirthDateTileState createState() => ProfileBirthDateTileState();
}

class ProfileBirthDateTileState extends ConsumerState<ProfileBirthDateTile> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text =
        ref.read(userInfoProvider).birthDate.toString().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Birth Date', style: profileTileValueTextStyle),
        Row(
          children: [
            SizedBox(
              width: 140.w,
              child: Text(
                userInfo.birthDate.toString().substring(0, 10),
                style: settingsTileTitleTextStyle,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            10.horizontalSpace,
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ).then((value) {
                  if (value == null) return;
                  if (DateTime.now().year - value.year < 18) {
                    Flushbar(
                      message: 'Date of birth must be 18 years or older',
                      duration: const Duration(milliseconds: 1000),
                      flushbarStyle: FlushbarStyle.FLOATING,
                      backgroundColor: Colors.red,
                      flushbarPosition: FlushbarPosition.TOP,
                    ).show(context);

                    return;
                  }
                  var userInfo = ref.read(userInfoProvider);

                  userInfo = userInfo.copyWith(birthDate: value);

                  ref.read(userInfoProvider.notifier).setUserInfo(userInfo);
                  Flushbar(
                    message: 'Birth Date Updated Successfully',
                    duration: const Duration(milliseconds: 1100),
                    flushbarStyle: FlushbarStyle.FLOATING,
                    backgroundColor: Colors.green,
                    flushbarPosition: FlushbarPosition.TOP,
                  ).show(context);
                });
              },
              child: Icon(
                Icons.edit_outlined,
                color: blackColor,
                size: 20.r,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

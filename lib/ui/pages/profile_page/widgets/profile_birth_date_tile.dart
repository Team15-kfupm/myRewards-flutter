// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';

import '../../../../core/providers/user_info_provider.dart';
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
    _controller.text = ref
        .read(userInfoProvider)
        .asData!
        .value
        .birthDate
        .toString()
        .substring(0, 10);
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
                userInfo.asData!.value.birthDate.toString().substring(0, 10),
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
                ).then((value) async {
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

                  final isUpdated = await DB().upDateBirthDate(
                      value.toString().substring(0, 10).trim(),
                      userInfo.value!.uid);
                  if (!isUpdated) {
                    Flushbar(
                      message: 'Birth Date Update Failed',
                      duration: const Duration(milliseconds: 2000),
                      flushbarStyle: FlushbarStyle.FLOATING,
                      backgroundColor: Colors.red,
                      flushbarPosition: FlushbarPosition.TOP,
                    ).show(context);
                    return;
                  }
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

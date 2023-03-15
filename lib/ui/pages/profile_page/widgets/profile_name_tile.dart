import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../../utils/constants.dart';

class ProfileNameTile extends ConsumerStatefulWidget {
  const ProfileNameTile({Key? key}) : super(key: key);

  @override
  ProfileNameTileState createState() => ProfileNameTileState();
}

class ProfileNameTileState extends ConsumerState<ProfileNameTile> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(userInfoProvider).name;
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Full Name', style: profileTileValueTextStyle),
        Row(
          children: [
            SizedBox(
              width: 140.w,
              child: Text(
                userInfo.name,
                style: settingsTileTitleTextStyle,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            10.horizontalSpace,
            InkWell(
              onTap: () {
                showBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          width: 375.w,
                          height: 200.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.verticalSpace,
                              Text(
                                'Enter your name',
                                style: profileTileValueTextStyle,
                              ),
                              13.verticalSpace,
                              TextField(
                                enabled: true,
                                controller: _controller,
                                autofocus: true,
                                decoration: InputDecoration(
                                  fillColor: whiteColor,
                                  focusColor: primaryColor,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.r),
                                      ),
                                      borderSide: const BorderSide(
                                          color: primaryColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.r),
                                      ),
                                      borderSide: const BorderSide(
                                          color: primaryColor)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 25.h, horizontal: 10.w),
                                ),
                              ),
                              8.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: smallPrimaryTextStyle,
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        if (_controller.text.isEmpty) {
                                          Flushbar(
                                            message:
                                                'Please enter a valid name',
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
                                            backgroundColor: Colors.red,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);

                                          return;
                                        }
                                        var userInfo =
                                            ref.read(userInfoProvider);

                                        userInfo = userInfo.copyWith(
                                            name: _controller.text);

                                        ref
                                            .read(userInfoProvider.notifier)
                                            .setUserInfo(userInfo);

                                        Navigator.pop(context);

                                        Flushbar(
                                          message: 'Name Updated Successfully',
                                          duration: const Duration(
                                              milliseconds: 1100),
                                          flushbarStyle: FlushbarStyle.FLOATING,
                                          backgroundColor: Colors.green,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        ).show(context);
                                      },
                                      child: Text(
                                        'Save',
                                        style: smallPrimaryTextStyle,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ));
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
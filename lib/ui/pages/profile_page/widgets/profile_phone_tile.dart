import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/providers/user_info_provider.dart';
import '../../../../utils/constants.dart';

class ProfilePhoneTile extends ConsumerStatefulWidget {
  const ProfilePhoneTile({Key? key}) : super(key: key);

  @override
  ProfilePhoneTileState createState() => ProfilePhoneTileState();
}

class ProfilePhoneTileState extends ConsumerState<ProfilePhoneTile> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(userInfoProvider).asData!.value.phone;
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Phone Number', style: profileTileValueTextStyle),
        Row(
          children: [
            SizedBox(
              width: 140.w,
              child: Text(
                userInfo.asData!.value.phone,
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
                                'Enter your phone number',
                                style: profileTileValueTextStyle,
                              ),
                              8.verticalSpace,
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
                              20.verticalSpace,
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
                                        if (!phoneNumberRegex
                                            .hasMatch(_controller.text)) {
                                          Flushbar(
                                            message:
                                                'Please enter a valid phone number',
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

                                        // ref
                                        //     .read(userInfoProvider)
                                        //     .copyWith(phone: _controller.text);

                                        Navigator.pop(context);
                                        Flushbar(
                                          message: 'Phone Updated Successfully',
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

// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';

import '../../../../core/providers/user_info_provider.dart';
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
    _controller.text = ref.read(userInfoProvider).asData!.value.name;
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
                userInfo.asData!.value.name,
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
                                      onPressed: () async {
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

                                        final isUpdated = await DB()
                                            .updateUserName(_controller.text,
                                                userInfo.value!.uid);

                                        Navigator.pop(context);
                                        if (!isUpdated) {
                                          Flushbar(
                                            message:
                                                'Something went wrong. Please try again later',
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
                                            backgroundColor: Colors.red,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                          return;
                                        }
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

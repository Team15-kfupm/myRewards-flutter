import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';

class SettingsTile extends StatefulWidget {
  final String title;
  final VoidCallback onClicked;
  final IconData icon;
  const SettingsTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onClicked})
      : super(key: key);

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onClicked,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: settingsTileIconColor,
                    size: 30.r,
                  ),
                  23.horizontalSpace,
                  Text(
                    widget.title,
                    style: settingsTileTitleTextStyle,
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: settingsTileArrowIconColor,
              ),
            ],
          ),
        ),
        12.verticalSpace,
        const Divider(
          color: lightGreyColor,
          thickness: 0.5,
        ),
        23.verticalSpace,
      ],
    );
  }
}

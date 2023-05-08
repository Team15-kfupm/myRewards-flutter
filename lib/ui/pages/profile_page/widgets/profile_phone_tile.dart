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
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/stores_page/widgets/store_card_grid_view.dart';

import '../../../utils/constants.dart';
import '../home_page/widgets/avatar_with_welcome.dart';

class StoresPage extends StatelessWidget {
  const StoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(right: 25, left: 25, bottom: 15, top: 15),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AvatarWithWelcome(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/searchPage');
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
                      Icons.search_rounded,
                      color: blackColor,
                      size: 20.r,
                    )),
              ),
            ],
          ),
          32.verticalSpace,
          SizedBox(
            height: 550.h,
            width: 375.w,
            child: const StoreCardGridVIew(),
          )
        ]));
  }
}

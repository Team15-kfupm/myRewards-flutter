import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants.dart';

class TopStoresShimmer extends StatelessWidget {
  const TopStoresShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          cacheExtent: 99999999999,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Shimmer(
                  gradient: LinearGradient(colors: [
                    firstShimmerColor,
                    secondShimmerColor,
                    firstShimmerColor,
                  ]),
                  child: Container(
                    width: 315.w,
                    height: 172.h,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  )),
            );
          }),
          separatorBuilder: (context, index) {
            return 16.verticalSpace;
          },
          itemCount: 5),
    );
  }
}

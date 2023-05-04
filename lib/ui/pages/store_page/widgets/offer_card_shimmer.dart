import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants.dart';

class OfferCardShimmer extends StatelessWidget {
  const OfferCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
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
        ));
  }
}

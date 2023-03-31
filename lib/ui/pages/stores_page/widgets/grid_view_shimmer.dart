import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class GridViewShimmer extends StatefulWidget {
  const GridViewShimmer({Key? key}) : super(key: key);

  @override
  State<GridViewShimmer> createState() => _GridViewShimmerState();
}

class _GridViewShimmerState extends State<GridViewShimmer> {
  Widget shimmerContainer = Shimmer(
      gradient: LinearGradient(colors: [
        firstShimmerColor,
        secondShimmerColor,
        firstShimmerColor,
      ]),
      child: Container(
        width: 168.w,
        height: 158.h,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(20)),
      ));
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        children: [
          shimmerContainer,
          shimmerContainer,
          shimmerContainer,
          shimmerContainer,
          shimmerContainer,
          shimmerContainer,
          shimmerContainer,
          shimmerContainer,
        ]);
  }
}

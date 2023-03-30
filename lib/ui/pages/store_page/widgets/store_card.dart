import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 199.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            offerCardprimaryColor,
            primaryColor,
          ],
          begin: Alignment.center,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -30.r,
            bottom: 140.h,
            child: Transform.rotate(
              angle: -0.6,
              child: Container(
                width: 109.r,
                height: 65.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: shapesInCardBackgroundColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: 130.r,
            top: -200.h,
            bottom: 0,
            child: Container(
              width: 98.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: shapesInCardBackgroundColor,
              ),
            ),
          ),
          Positioned(
            left: -35.r,
            top: 0,
            bottom: -100.h,
            child: Container(
              width: 98.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: shapesInCardBackgroundColor,
              ),
            ),
          ),
          Positioned(
            left: 200.r,
            bottom: -23.h,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 109.r,
                height: 65.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: shapesInCardBackgroundColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: -53.r,
            top: 30.h,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 98.r,
                height: 98.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: shapesInCardBackgroundColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlutterLogo(size: 100.r),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 350.w,
                    height: 60.h,
                    decoration: const BoxDecoration(
                      color: offerCardClaimBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '150',
                          style: welcomeNameTextStyle,
                        ),
                        Text(
                          'Total Points',
                          style: welcomeNameTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

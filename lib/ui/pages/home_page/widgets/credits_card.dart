import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';
import 'package:myrewards_flutter/utils/constants.dart';

class CreditsCard extends StatefulWidget {
  const CreditsCard({Key? key}) : super(key: key);

  @override
  State<CreditsCard> createState() => _CreditsCardState();
}

class _CreditsCardState extends State<CreditsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final totalPoints = ref
                              .watch(userInfoProvider)
                              .asData
                              ?.value
                              .totalPoints ??
                          0;
                      return Text(
                        totalPoints.toString(),
                        style: totalSpendingsAmountTextStyle,
                      );
                    },
                  ),
                  Text('Total Points', style: totalSpendingsTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

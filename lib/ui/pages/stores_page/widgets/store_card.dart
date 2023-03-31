import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';

import '../../../../utils/constants.dart';

class StoreCard extends ConsumerStatefulWidget {
  final StoreModel store;
  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  StoreCardState createState() => StoreCardState();
}

final currentStoreProvider = StateProvider(
    (ref) => StoreModel(id: '', location: '', name: '', offers: [], points: 0));

class StoreCardState extends ConsumerState<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ref.read(currentStoreProvider.notifier).state = widget.store;
        Navigator.pushNamed(context, '/storePage');
      },
      child: Container(
        width: 168.w,
        height: 158.h,
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
              left: -20.r,
              bottom: 110.h,
              child: Transform.rotate(
                angle: -0.6,
                child: Container(
                  width: 64.r,
                  height: 47.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: shapesInCardBackgroundColor,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 33.w,
              top: -210.h,
              bottom: 0,
              child: Container(
                width: 60.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: shapesInCardBackgroundColor,
                ),
              ),
            ),
            Positioned(
              left: -25.r,
              top: 0,
              bottom: -100.h,
              child: Container(
                width: 65.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: shapesInCardBackgroundColor,
                ),
              ),
            ),
            Positioned(
              left: 70.r,
              bottom: -23.h,
              child: Transform.rotate(
                angle: 0.4,
                child: Container(
                  width: 64.r,
                  height: 47.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: shapesInCardBackgroundColor,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -35.r,
              top: 40.h,
              child: Transform.rotate(
                angle: -0.5,
                child: Container(
                  width: 58.r,
                  height: 71.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: shapesInCardBackgroundColor,
                  ),
                ),
              ),
            ),
            // ProgressIndicator

            Padding(
              padding: EdgeInsets.only(left: 32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlutterLogo(
                    size: 80.r,
                  ),
                  Center(
                    child: Text(
                      widget.store.name,
                      style: totalSpendingsTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

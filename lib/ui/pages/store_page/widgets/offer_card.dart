import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/models/offer_model.dart';
import 'package:myrewards_flutter/core/providers/stores_provider.dart';

import '../../../../core/providers/offer_code_provider.dart';
import '../../../../core/providers/user_info_provider.dart';
import '../../../../core/services/db_services.dart';
import '../../../../utils/constants.dart';
import '../../stores_page/widgets/store_card.dart';

class OfferCard extends ConsumerStatefulWidget {
  final OfferModel offer;
  const OfferCard({Key? key, required this.offer}) : super(key: key);

  @override
  OfferCardState createState() => OfferCardState();
}

class OfferCardState extends ConsumerState<OfferCard> {
  @override
  Widget build(BuildContext context) {
    final storePoints = ref
        .watch(userInfoProvider)
        .value!
        .points[ref.read(currentStoreProvider).id];
    final offerCode = ref.watch(offerCodeProvider(widget.offer.id));

    bool isEnoughtPoints = storePoints >= widget.offer.points;
    return Container(
      width: 315.w,
      height: 172.h,
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
          // ProgressIndicator

          Positioned(
            bottom: -2.h,
            child: InkWell(
              onTap: () {
                if (!isEnoughtPoints) {
                  return;
                }
              },
              child: InkWell(
                onTap: () async {
                  if (!isEnoughtPoints || offerCode.asData != null) {
                    return;
                  }
                  final code = await DB().claimOffer(
                    ref.read(userInfoProvider).value!.uid,
                    widget.offer.id,
                  );

                  if (code.isEmpty) {
                    //TODO: show error
                    Flushbar(
                      message: 'Something went wrong :(',
                      duration: const Duration(milliseconds: 1000),
                      flushbarStyle: FlushbarStyle.FLOATING,
                      backgroundColor: Colors.red,
                      flushbarPosition: FlushbarPosition.TOP,
                    ).show(context);
                    return;
                  }
                  DB().updateStorePoints(ref.read(userInfoProvider).value!.uid,
                      ref.read(currentStoreProvider).id, widget.offer.points);
                  // ref
                  //     .read(storesProvider)
                  //     .value!
                  //     .where((store) =>
                  //         store.id == ref.read(currentStoreProvider).id)
                  //     .first;

                  Flushbar(
                    message: 'Offer claimed!',
                    duration: const Duration(milliseconds: 1000),
                    flushbarStyle: FlushbarStyle.FLOATING,
                    backgroundColor: Colors.green,
                    flushbarPosition: FlushbarPosition.TOP,
                  ).show(context);
                },
                child: ref
                            .watch(offerCodeProvider(
                              widget.offer.id,
                            ))
                            .asData
                            ?.value !=
                        null
                    ? Container(
                        width: 324.w,
                        height: 39.h,
                        decoration: const BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            offerCode.asData!.value,
                            style: welcomeNameTextStyle,
                          ),
                        ),
                      )
                    : Container(
                        width: 324.w,
                        height: 39.h,
                        decoration: BoxDecoration(
                          color: isEnoughtPoints
                              ? offerCardClaimBackgroundColor
                              : welcomeTextColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Claim',
                            style: welcomeNameTextStyle,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.offer.title,
                    style: totalSpendingsAmountTextStyle,
                  ),
                  Text('Points: ${widget.offer.points}',
                      style: totalSpendingsTextStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

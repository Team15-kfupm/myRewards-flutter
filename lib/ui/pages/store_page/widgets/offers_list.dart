import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'offer_card.dart';

class OffersList extends StatefulWidget {
  const OffersList({Key? key}) : super(key: key);

  @override
  State<OffersList> createState() => _OffersList();
}

class _OffersList extends State<OffersList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          cacheExtent: 99999999999,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: const OfferCard(),
            );
          }),
          separatorBuilder: (context, index) {
            return 16.verticalSpace;
          },
          itemCount: 5),
    );
  }
}
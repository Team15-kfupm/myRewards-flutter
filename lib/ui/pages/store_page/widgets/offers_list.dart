import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/stores_page/widgets/store_card.dart';

import 'offer_card.dart';

class OffersList extends ConsumerStatefulWidget {
  const OffersList({Key? key}) : super(key: key);

  @override
  OffersListState createState() => OffersListState();
}

class OffersListState extends ConsumerState<OffersList> {
  @override
  Widget build(BuildContext context) {
    final offers = ref.read(currentStoreProvider).offers;
    return Expanded(
      child: ListView.separated(
          cacheExtent: 99999999999,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: OfferCard(
                offer: offers[index],
              ),
            );
          }),
          separatorBuilder: (context, index) {
            return 16.verticalSpace;
          },
          itemCount: offers.length),
    );
  }
}

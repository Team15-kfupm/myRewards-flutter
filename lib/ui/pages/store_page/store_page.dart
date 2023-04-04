import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/store_page/widgets/offers_list.dart';
import '../../../utils/constants.dart';
import '../stores_page/widgets/store_card.dart';
import '../store_page/widgets/store_card.dart' as store_card;

class StorePage extends ConsumerWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(currentStoreProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            store.name,
            style: titleTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: transparentColor,
          leadingWidth: 90.w,
          leading: Row(
            children: [
              10.horizontalSpace,
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 42.w,
                    height: 42.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: settingsAppBarIconBackgroundColor,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: blackColor,
                      size: 20.r,
                    )),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: const BoxDecoration(
                    color: settingsAppBarIconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: blackColor,
                      size: 22.r,
                    ),
                  ),
                ),
                16.horizontalSpace
              ],
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const store_card.StoreCard(),
                  32.verticalSpace,
                  const OffersList()
                ])));
  }
}

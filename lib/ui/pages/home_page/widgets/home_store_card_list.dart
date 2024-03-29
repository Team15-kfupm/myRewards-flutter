import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/providers/top_stores_provider.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/home_store_card.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/top_stores_shimmer.dart';

import '../../../../core/providers/top_stores_points_provider.dart';
import '../../../../utils/constants.dart';

class HomeStoresCardList extends ConsumerStatefulWidget {
  const HomeStoresCardList({Key? key}) : super(key: key);

  @override
  HomeStoresCardListState createState() => HomeStoresCardListState();
}

class HomeStoresCardListState extends ConsumerState<HomeStoresCardList> {
  @override
  Widget build(BuildContext context) {
    final topStoresPoints = ref
        .watch(topStoresPointsProvider(ref.read(userInfoProvider).value!.uid));

    return topStoresPoints.when(
        data: (topStoresPointsMap) {
          final topStores = ref.watch(topStoresProvider(topStoresPointsMap));

          return topStores.when(
              data: (topStoresList) {
                log('top store card list points: ${topStoresPointsMap.toString()}',
                    name: 'HomeStoresCardListState');
                return Expanded(
                  child: topStoresList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                'You don\'t have any points in a store!',
                                style: statCategoryLabelTextStyle,
                              ),
                              Text(
                                'You need to allow the app to read SMS messages and make a purchase.',
                                style: settingsSectionTitleTextStyle,
                              ),
                            ])
                      : ListView.separated(
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9.w),
                              child: HomeStoreCard(
                                topStore: topStoresList[index],
                              ),
                            );
                          }),
                          separatorBuilder: (context, index) {
                            return 16.verticalSpace;
                          },
                          itemCount: topStoresList.length),
                );
              },
              error: (error, _) =>
                  Text('top store card list points: ${error.toString()}'),
              loading: () => const TopStoresShimmer());
        },
        error: (error, _) => Text('top store card list : ${error.toString()}'),
        loading: () => const TopStoresShimmer());
  }
}

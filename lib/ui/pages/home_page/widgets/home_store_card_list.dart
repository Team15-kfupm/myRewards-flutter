import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/providers/top_stores_provider.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/home_store_card.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/top_stores_shimmer.dart';

import '../../../../core/providers/top_stores_points_provider.dart';

class HomeStoresCardList extends ConsumerStatefulWidget {
  const HomeStoresCardList({Key? key}) : super(key: key);

  @override
  HomeStoresCardListState createState() => HomeStoresCardListState();
}

class HomeStoresCardListState extends ConsumerState<HomeStoresCardList> {
  @override
  Widget build(BuildContext context) {
    final topStoresPoints = ref.watch(topStoresPointsProvider);

    return topStoresPoints.when(
        data: (topStoresPointsMap) {
          topStoresPointsMap.forEach((key, value) {
            log('key: $key, value: $value');
          });
          final topStores = ref.watch(topStoresProvider(topStoresPointsMap));
          log('topStores: $topStores');
          return topStores.when(
              data: (topStoresList) {
                topStoresList.forEach((element) {
                  log(element.name);
                });
                return Expanded(
                  child: ListView.separated(
                      cacheExtent: 99999999999,
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

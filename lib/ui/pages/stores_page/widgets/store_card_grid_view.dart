import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/providers/stores_provider.dart';
import 'package:myrewards_flutter/ui/pages/stores_page/widgets/grid_view_shimmer.dart';

import 'store_card.dart';

class StoreCardGridVIew extends ConsumerStatefulWidget {
  const StoreCardGridVIew({Key? key}) : super(key: key);

  @override
  StoreCardGridVIewState createState() => StoreCardGridVIewState();
}

class StoreCardGridVIewState extends ConsumerState<StoreCardGridVIew> {
  @override
  Widget build(BuildContext context) {
    final storesList = ref.watch(storesProvider);
    List<Widget> storesCard = [];

    return storesList.when(
      data: (storesList) {
        for (var store in storesList) {
          storesCard.add(StoreCard(
            store: store,
          ));
        }
        return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            children: storesCard);
      },
      error: (error, stack) => Text(error.toString()),
      loading: () => const GridViewShimmer(),
    );
  }
}

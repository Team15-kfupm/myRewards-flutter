import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/providers/transactions_by_month_provider.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';

import '../../../../utils/constants.dart';

class TransactionsCategory extends ConsumerWidget {
  const TransactionsCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(
        transactionsByMonthProvider(ref.read(userInfoProvider).value!.uid));
    return categories.when(
        data: (data) {
          final categoriesList = data.last.categories.entries
              .where((spendings) => spendings.value > 0)
              .toList();

          categoriesList.sort((a, b) => b.value.compareTo(a.value));

          final totalSpendings = data.last.categories.values.reduce(
              (totalSpendings, categorySpendings) =>
                  totalSpendings + categorySpendings);
          return ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          color: firstShimmerColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${(categoriesList[index].value / totalSpendings * 100).toStringAsFixed(0)}%',
                          style: statCategoryPercentageTextStyle,
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        categoriesList[index].key,
                        style: statCategoryTypeTextStyle,
                      ),
                    ],
                  ),
                  Text(
                    '\$${categoriesList[index].value}',
                    style: statCategoryTypeTextStyle,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return 10.verticalSpace;
            },
            itemCount: categoriesList.length,
          );
        },
        error: (error, _) => Text(error.toString()),
        loading: () => const CircularProgressIndicator());
  }
}

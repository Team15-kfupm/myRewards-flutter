import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/providers/transactions_by_month_provider.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/donut_chart.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/widgets/sp_line_chart.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/widgets/transactions_category.dart';

import '../../../core/models/donut_chart_data_model.dart';
import '../../../core/providers/donut_chart_data_provider.dart';
import '../../../core/providers/user_info_provider.dart';
import '../../../core/services/db_services.dart';
import '../../../utils/constants.dart';
import '../home_page/widgets/avatar_with_welcome.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

final donutChartDataProvider =
    StateNotifierProvider<DonutChartDataNotifier, List<DonutChartDataModel>>(
        (ref) {
  return DonutChartDataNotifier();
});

class StatisticsPageState extends ConsumerState<StatisticsPage> {
  @override
  initState() {
    super.initState();
    DB().runOnceAfterInstallation();
    DB().initMessagesListener();
    DB().initBackgroundFetch();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsByMonth = ref.watch(
        transactionsByMonthProvider(ref.read(userInfoProvider).value!.uid));
    return transactionsByMonth.when(
      data: (monthsTransactionsList) {
        return Padding(
          padding:
              const EdgeInsets.only(right: 25, left: 25, bottom: 15, top: 15),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AvatarWithWelcome(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/searchPage');
                  },
                  child: Container(
                      width: 42.w,
                      height: 42.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: settingsAppBarIconBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search_rounded,
                        color: blackColor,
                        size: 20.r,
                      )),
                ),
              ],
            ),
            80.verticalSpace,

            // line chart with months as x axix and spendings as y axis
            const SpLineChart(),
            10.verticalSpace,
            // Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transactions Category',
                    overflow: TextOverflow.ellipsis,
                    style: statCategoryLabelTextStyle),
                InkWell(
                    onTap: () {
                      if (monthsTransactionsList.isEmpty) {
                        Flushbar(
                          message: 'Wait for transactions to load',
                          duration: const Duration(milliseconds: 2000),
                          backgroundColor: Colors.red,
                          flushbarPosition: FlushbarPosition.TOP,
                        ).show(context);
                        return;
                      }

                      final currentMonth = monthsTransactionsList.last;
                      final categoriesList = currentMonth.categories.entries
                          .where((spendings) => spendings.value > 0)
                          .map((category) => DonutChartDataModel(category.key,
                              category.value, donutChartcolors[category.key]!))
                          .toList();
                      ref
                          .read(donutChartDataProvider.notifier)
                          .updateData(categoriesList);
                      showModalBottomSheet(
                        context: context,
                        elevation: 0,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (BuildContext context) {
                          return Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: const DonutChartWidget(),
                          );
                        },
                      );
                    },
                    child: Text('See All', style: statSeeAllTextStyle))
              ],
            ),
            10.verticalSpace,
            const Expanded(
              child: TransactionsCategory(),
            ),
          ]),
        );
      },
      error: (error, _) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

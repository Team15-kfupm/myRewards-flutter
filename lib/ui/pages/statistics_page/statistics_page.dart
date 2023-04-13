import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/widgets/sp_line_chart.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/widgets/transactions_category.dart';

import '../../../core/services/db_services.dart';
import '../../../utils/constants.dart';
import '../home_page/widgets/avatar_with_welcome.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  initState() {
    super.initState();
    DB().runOnceAfterInstallation();
    // DB().initMessagesListener();
    // DB().initBackgroundFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, bottom: 15, top: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AvatarWithWelcome(),
            InkWell(
              onLongPress: () {},
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
        32.verticalSpace,
        Center(
            child: Text(
          'Total Spendings',
          style: statTotalSpendingsLabelTextStyle,
        )),
        Center(
          child: Text(
            '326.50 SAR',
            style: statTotalSpendingsTextStyle,
          ),
        ),

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
                onTap: () {},
                child: Text('See All', style: statSeeAllTextStyle))
          ],
        ),
        10.verticalSpace,
        const Expanded(
          child: TransactionsCategory(),
        ),
      ]),
    );
  }
}

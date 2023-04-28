import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myrewards_flutter/core/models/donut_chart_data_model.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/statistics_page.dart';
import 'package:myrewards_flutter/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/providers/transactions_for_month_provider.dart';

class DonutChartWidget extends ConsumerStatefulWidget {
  const DonutChartWidget({super.key});

  @override
  DonutChartWidgetState createState() => DonutChartWidgetState();
}

class DonutChartWidgetState extends ConsumerState<DonutChartWidget> {
  var prevIndex = -1;

  @override
  Widget build(BuildContext context) {
    final donutChartData = ref.watch(donutChartDataProvider);

    return Center(
      child: Column(
        children: [
          10.verticalSpace,
          Container(
            height: 10.h,
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: lightGreyColor,
            ),
          ),
          Stack(alignment: Alignment.center, children: [
            SizedBox(
              height: 400.h,
              child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    toggleSeriesVisibility: false,
                    overflowMode: LegendItemOverflowMode.wrap,
                    position: LegendPosition.bottom,
                    alignment: ChartAlignment.near,
                    textStyle: const TextStyle(color: Colors.black),
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<DonutChartDataModel, String>(
                      dataSource: donutChartData,
                      legendIconType: LegendIconType.values[0],
                      onPointTap: (pointInteractionDetails) {
                        // Get the index of the tapped data point
                        int index = pointInteractionDetails.pointIndex!;

                        // The if statement checks if the current tapped index is
                        // equal to the previous index,then it sets the color of all
                        // the data points to their original colors
                        // and updates the state.
                        if (prevIndex == index && prevIndex != -1) {
                          ref
                              .read(donutChartDataProvider.notifier)
                              .resetColors();
                          prevIndex = -1;
                          return;
                        }

                        // The current index is saved as the previous index.
                        prevIndex = index;

                        // The color of the tapped data point is set to its
                        //corresponding color in the 'colors' list.

                        ref.read(donutChartDataProvider.notifier).updateColor(
                            donutChartData[index].name,
                            donutChartcolors[donutChartData[index].name]!);

                        // All the other data points are set to a light grey color.
                        for (var i = 0; i < donutChartData.length; i++) {
                          if (donutChartData[i]
                                  .name
                                  .compareTo(donutChartData[index].name) ==
                              0) {
                            continue;
                          }

                          ref.read(donutChartDataProvider.notifier).updateColor(
                              donutChartData[i].name, unSelectedLegendGradient);
                        }
                      },
                      xValueMapper: (DonutChartDataModel data, _) => data.name,
                      yValueMapper: (DonutChartDataModel data, _) =>
                          data.amount,
                      pointShaderMapper: (datum, index, color, rect) {
                        // index switch
                        switch (index) {
                          case 0:
                            return datum.color.createShader(rect);

                          case 1:
                            return datum.color.createShader(rect);

                          case 2:
                            return datum.color.createShader(rect);

                          case 3:
                            return datum.color.createShader(rect);

                          case 4:
                            return datum.color.createShader(rect);

                          case 5:
                            return datum.color.createShader(rect);

                          default:
                            return LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: <Color>[color, color],
                            ).createShader(rect);
                        }
                      },
                      cornerStyle: CornerStyle.bothCurve,
                      innerRadius: '85%',
                    ),
                  ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                50.verticalSpace,
                Text(
                  '${donutChartData.fold(0.0, (previousValue, element) => previousValue + element.amount).toString()}\$',
                  style: donutTotalSpendingsAmountTextStyle,
                ),
                Text(
                  'Total Spendings',
                  style: donutTotalSpendingsLabelTextStyle,
                ),
                90.verticalSpace
              ],
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Transactions History',
                  overflow: TextOverflow.ellipsis,
                  style: statCategoryLabelTextStyle),
              // InkWell(
              //     onTap: () {},
              //     child: Text('See All', style: statSeeAllTextStyle))
            ],
          ),
          5.verticalSpace,
          Consumer(builder: (context, ref, child) {
            final transactionsForMonth =
                ref.watch(transactionsForMonthProvider);

            return transactionsForMonth.when(data: (transactionsList) {
              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: transactionsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.abc),
                      title: Text(transactionsList[index].storeName),
                      subtitle: Text(transactionsList[index].category),
                      trailing: Text(transactionsList[index].amount.toString()),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                      thickness: 1,
                    );
                  },
                ),
              );
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            });
          }),
        ],
      ),
    );
  }
}

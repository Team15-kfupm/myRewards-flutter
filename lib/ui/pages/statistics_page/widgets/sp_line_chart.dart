import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myrewards_flutter/core/models/sp_line_data_model.dart';
import 'package:myrewards_flutter/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

import '../../../../core/providers/transactions_by_month_provider.dart';
import '../../../../core/providers/user_info_provider.dart';

class SpLineChart extends ConsumerWidget {
  const SpLineChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(
        transactionsByMonthProvider(ref.read(userInfoProvider).value!.uid));
    return data.when(
      data: (data) {
        List<SpLineDataModel> spLineData = [];

        if (data.isNotEmpty) {
          spLineData = data
              .map((transactionsByMonthData) => SpLineDataModel(
                  month: DateFormat('MMM')
                      .format(DateTime(
                          2000, int.parse(transactionsByMonthData.month)))
                      .toString(), //transactionsByMonthData.month,
                  totalSpend: double.parse(transactionsByMonthData
                      .categories.values
                      .reduce((totalSpendings, categorySpendings) =>
                          totalSpendings + categorySpendings)
                      .toStringAsFixed(2))))
              .toList();
        }

        log('spLineData: ${spLineData}');

        return Container(
            height: 250.h,
            margin: const EdgeInsets.all(0),
            child: charts.SfCartesianChart(
                zoomPanBehavior: charts.ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    zoomMode: charts.ZoomMode.x),
                borderWidth: 0,
                borderColor: transparentColor,
                plotAreaBorderColor: transparentColor,
                primaryXAxis: charts.CategoryAxis(
                  desiredIntervals: 1,
                  interval: 1,
                  isVisible: true,
                  axisLine: const charts.AxisLine(
                    width: 1,
                  ),
                  visibleMaximum: 3,
                  rangePadding: charts.ChartRangePadding.none,
                  majorTickLines: const charts.MajorTickLines(
                    size: 0,
                  ),
                  axisLabelFormatter: (axisLabelRenderArgs) {
                    return charts.ChartAxisLabel(
                        axisLabelRenderArgs.text,
                        axisLabelRenderArgs.textStyle
                            .merge(xAxisLabelTextStyle));
                  },
                ),
                primaryYAxis: charts.NumericAxis(
                  isVisible: false,
                  visibleMaximum: spLineData.isNotEmpty
                      ? spLineData
                              .reduce((value, element) =>
                                  value.totalSpend > element.totalSpend
                                      ? value
                                      : element)
                              .totalSpend +
                          500
                      : 100,
                  visibleMinimum: 0,
                ),
                series: <charts.ChartSeries<SpLineDataModel, String>>[
                  charts.SplineAreaSeries(
                    dataSource: spLineData,
                    xValueMapper: (SpLineDataModel spend, _) => spend.month,
                    yValueMapper: (SpLineDataModel spend, _) =>
                        spend.totalSpend,
                    borderWidth: 2,
                    animationDuration: 2,
                    animationDelay: 2,
                    gradient: const LinearGradient(
                      colors: [
                        lineChartAreaColor,
                        secondlineChartAreaColor,
                        secondlineChartAreaColor,
                        whiteColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  charts.SplineSeries(
                    dataSource: spLineData,
                    xValueMapper: (SpLineDataModel spend, _) => spend.month,
                    yValueMapper: (SpLineDataModel spend, _) =>
                        spend.totalSpend,
                    color: primaryColor,
                    width: 4,
                    isVisible: true,
                    splineType: charts.SplineType.natural,
                    enableTooltip: true,
                    dataLabelSettings: const charts.DataLabelSettings(
                      isVisible: true,
                      color: primaryColor,
                      labelPosition: charts.ChartDataLabelPosition.outside,
                      labelAlignment: charts.ChartDataLabelAlignment.outer,
                      labelIntersectAction: charts.LabelIntersectAction.hide,
                    ),
                    dataLabelMapper: (datum, index) {
                      return datum.totalSpend.toString();
                    },
                    markerSettings: const charts.MarkerSettings(
                      isVisible: true,
                      color: whiteColor,
                      borderColor: primaryColor,
                      borderWidth: 3,
                      height: 10,
                      width: 10,
                    ),
                  ),
                ]));
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

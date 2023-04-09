import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:myrewards_flutter/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class SpLineChart extends StatefulWidget {
  const SpLineChart({super.key});

  @override
  State<SpLineChart> createState() => _SpLineChartState();
}

class _SpLineChartState extends State<SpLineChart> {
  // list of SpendData
  final List<SpendData> data = [
    SpendData('Jan', 35.8),
    SpendData('Feb', 42.3),
    SpendData('Mar', 30),
    SpendData('Apr', 22.0),
    SpendData('May', 9),
    SpendData('Jun', 12.0),
    SpendData('Jul', 35.8),
    SpendData('Aug', 42.3),
    SpendData('Sep', 30),
    SpendData('Oct', 22.0),
    SpendData('Nov', 9),
    SpendData('Dec', 12.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.h,
        margin: const EdgeInsets.all(0),
        child: charts.SfCartesianChart(
            zoomPanBehavior: charts.ZoomPanBehavior(
              enablePanning: true,
            ),
            borderWidth: 0,
            borderColor: transparentColor,
            plotAreaBorderColor: transparentColor,
            primaryXAxis: charts.CategoryAxis(
              desiredIntervals: 6,
              interval: 1,
              isVisible: true,
              visibleMaximum: 6,
              visibleMinimum: 3,
              rangePadding: charts.ChartRangePadding.none,
              majorTickLines: const charts.MajorTickLines(
                size: 0,
              ),
              axisLabelFormatter: (axisLabelRenderArgs) {
                return charts.ChartAxisLabel(axisLabelRenderArgs.text,
                    axisLabelRenderArgs.textStyle.merge(xAxisLabelTextStyle));
              },
            ),
            primaryYAxis: charts.NumericAxis(
              isVisible: false,
              visibleMaximum: 100,
              visibleMinimum: 0,
            ),
            series: <charts.ChartSeries<SpendData, String>>[
              charts.SplineAreaSeries(
                dataSource: data,
                xValueMapper: (SpendData spend, _) => spend.month,
                yValueMapper: (SpendData spend, _) => spend.spend,
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
                dataSource: data,
                xValueMapper: (SpendData spend, _) => spend.month,
                yValueMapper: (SpendData spend, _) => spend.spend,
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
                  return datum.spend.toString();
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
  }
}

class SpendData {
  SpendData(this.month, this.spend);
  final String month;
  final double spend;
}

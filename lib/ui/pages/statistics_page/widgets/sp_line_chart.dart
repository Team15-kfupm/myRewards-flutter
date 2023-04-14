import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/models/sp_line_data_model.dart';

import 'package:myrewards_flutter/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class SpLineChart extends StatefulWidget {
  const SpLineChart({super.key});

  @override
  State<SpLineChart> createState() => _SpLineChartState();
}

class _SpLineChartState extends State<SpLineChart> {
  // list of SpendData
  final List<SpLineDataModel> data = [
    SpLineDataModel(month: 'Jan', totalSpend: 33),
  ];

  @override
  Widget build(BuildContext context) {
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
                width: 0,
              ),
              visibleMaximum: 3,
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
            series: <charts.ChartSeries<SpLineDataModel, String>>[
              charts.SplineAreaSeries(
                dataSource: data,
                xValueMapper: (SpLineDataModel spend, _) => spend.month,
                yValueMapper: (SpLineDataModel spend, _) => spend.totalSpend,
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
                xValueMapper: (SpLineDataModel spend, _) => spend.month,
                yValueMapper: (SpLineDataModel spend, _) => spend.totalSpend,
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
  }
}

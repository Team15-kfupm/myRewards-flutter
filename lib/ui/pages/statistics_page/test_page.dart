import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DonutChartWidget extends StatefulWidget {
  const DonutChartWidget({super.key});

  @override
  DonutChartWidgetState createState() => DonutChartWidgetState();
}

class DonutChartWidgetState extends State<DonutChartWidget> {
  final List<charts.Series<Task, String>> _seriesList = [];

  var data = [
    Task('Coffe Shop', 35.8, coffeShopLegendGradient),
    Task('Restaurant', 42.3, restaurantLegendGradient),
    Task('Shopping', 30, shoppingLegendGradient),
    Task('Entertainment', 22.0, entertainmentLegendGradient),
    Task('Travel', 9, travelLegendGradient),
    Task('Other', 12.0, otherLegendGradient),
  ];

  var colors = [
    coffeShopLegendGradient,
    restaurantLegendGradient,
    shoppingLegendGradient,
    entertainmentLegendGradient,
    travelLegendGradient,
    otherLegendGradient,
  ];
  var prevIndex = -1;
  List<bool> explode = [];
  @override
  void initState() {
    super.initState();
    // Initialize the explode list with values indicating which data points to explode

    // _seriesList.add(
    //   charts.Series(
    //     data: data,
    //     domainFn: (Task task, _) => task.task,
    //     measureFn: (Task task, _) => task.taskValue,
    //     colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.color),
    //     id: 'Category',
    //     labelAccessorFn: (Task row, _) => '${row.task}: ${row.taskValue}%',
    //     insideLabelStyleAccessorFn: (Task row, _) {
    //       return charts.TextStyleSpec(
    //           color: charts.MaterialPalette.red.shadeDefault);
    //     },
    //     outsideLabelStyleAccessorFn: (Task row, _) {
    //       return charts.TextStyleSpec(
    //           color: charts.MaterialPalette.blue.shadeDefault);
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donut Chart'),
      ),
      body: Center(
        child: Column(
          children: [
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
                      DoughnutSeries<Task, String>(
                        dataSource: data,

                        legendIconType: LegendIconType.values[0],

                        onPointTap: (pointInteractionDetails) {
                          // Get the index of the tapped data point
                          int index = pointInteractionDetails.pointIndex!;

                          // The if statement checks if the current tapped index is
                          // equal to the previous index,then it sets the color of all
                          // the data points to their original colors
                          // and updates the state.
                          if (prevIndex == index && prevIndex != -1) {
                            for (var i = 0; i < data.length; i++) {
                              data[i].color = colors[i];
                            }
                            prevIndex = -1;
                            setState(() {});
                            return;
                          }

                          // The current index is saved as the previous index.
                          prevIndex = index;

                          // The color of the tapped data point is set to its
                          //corresponding color in the 'colors' list.
                          data[index].color = colors[index];

                          // All the other data points are set to a light grey color.
                          for (var i = 0; i < data.length; i++) {
                            if (data[i].task.compareTo(data[index].task) == 0) {
                              continue;
                            }

                            data[i].color = unSelectedLegendGradient;
                          }
                          setState(() {});
                        },
                        xValueMapper: (Task data, _) => data.task,
                        yValueMapper: (Task data, _) => data.taskValue,

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

                        // Explode the segments on tap
                      ),
                    ]),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '323\$',
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
                InkWell(
                    onTap: () {},
                    child: Text('See All', style: statSeeAllTextStyle))
              ],
            ),
            5.verticalSpace,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('Store Name'),
                    subtitle: Text('Category'),
                    trailing: Text('10.4 SAR'),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(charts.SelectionModel model) {
    if (model.hasDatumSelection) {
      final selectedDatum = model.selectedDatum[0];
      setState(() {
        selectedDatum.datum.color = Colors.red;
      });

      log('Selected ${model.selectedDatum.length} datum: ${selectedDatum.datum.task} ${selectedDatum.datum.taskValue}');
    }
  }
}

class Task {
  final String task;
  final double taskValue;
  LinearGradient color;

  Task(this.task, this.taskValue, this.color);
}

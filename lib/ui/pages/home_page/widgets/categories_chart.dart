import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:myrewards_flutter/data/bar_charts_data.dart';

class CategoriesChart extends StatefulWidget {
  const CategoriesChart({Key? key}) : super(key: key);

  @override
  State<CategoriesChart> createState() => _CategoriesChartState();
}

class _CategoriesChartState extends State<CategoriesChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: BarChart(BarChartData(
        backgroundColor: const Color.fromARGB(233, 17, 19, 44),
        gridData:
            FlGridData(drawVerticalLine: BarChartsData.interval % 10 == 0),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (id, value) {
                    return Text(
                      BarChartsData.barChartsData[id.toInt()].name,
                      style: const TextStyle(color: Colors.black),
                    );
                  })),
        ),
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 3000,
        minY: 0,
        groupsSpace: 12,
        barTouchData: BarTouchData(
          enabled: true,
        ),
        barGroups: BarChartsData.barChartsData
            .map((e) => BarChartGroupData(
                  x: e.id,
                  barRods: [
                    BarChartRodData(
                      fromY: 0,
                      toY: e.y,
                      color: e.color,
                      width: 20,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4)),
                    ),
                  ],
                ))
            .toList(),
      )),
    );
  }
}

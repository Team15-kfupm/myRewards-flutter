import 'package:flutter/material.dart';
import 'package:myrewards_flutter/core/models/bar_chart_data_model.dart';

class BarChartsData {
  static int interval = 5;

  static List<BarChartDataModel> barChartsData = [
    const BarChartDataModel(
        id: 0, name: 'Food', y: 1389, color: Color(0xff0293ee)),
    const BarChartDataModel(
        id: 1, name: 'Car', y: 426, color: Color(0xfff8b250)),
    const BarChartDataModel(
        id: 2, name: 'Clothes', y: 814, color: Color(0xff845bef)),
    const BarChartDataModel(
        id: 3, name: 'Learn', y: 1389, color: Color(0xff023e99)),
    const BarChartDataModel(
        id: 4, name: 'House', y: 1389, color: Color(0xf3e5631e)),
  ];
}

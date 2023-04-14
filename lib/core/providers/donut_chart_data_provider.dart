import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/utils/constants.dart';

import '../models/donut_chart_data_model.dart';

class DonutChartDataNotifier extends StateNotifier<List<DonutChartDataModel>> {
  DonutChartDataNotifier() : super([]);

  void updateData(List<DonutChartDataModel> data) {
    state = data;
  }

  void resetColors() {
    state = state.map((e) {
      e.color = donutChartcolors[e.name]!;
      return e;
    }).toList();
  }

  void updateColor(String name, LinearGradient color) {
    state = state.map((e) {
      if (e.name == name) {
        e.color = color;
      }
      return e;
    }).toList();
  }
}

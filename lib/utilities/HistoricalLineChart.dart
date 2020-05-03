// HistoricalLineChart Class with flutter_charts Library

import 'package:covid_19_tracker/models/timeline_date_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19_tracker/models/case_historical_data_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';

class HistoricalLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HistoricalLineChart(this.seriesList, {this.animate});

  // Creates a LineChart with data and animation
  factory HistoricalLineChart.withHistoricalData() {
    return HistoricalLineChart(_createHistoricalData(), animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList, animate: animate);
  }

  // Create series with historical data
  static List<charts.Series<CaseHistorical, String>> _createHistoricalData() {
    Future<List<TimelineDateModel>> timelineDataList;

    // Colors definition
    final activeColor = charts.ColorUtil.fromDartColor(Colors.blueAccent);
    final deathsColor = charts.ColorUtil.fromDartColor(Colors.redAccent);
    final recoveredColor = charts.ColorUtil.fromDartColor(Colors.green);

    timelineDataList = ApiResources().getTimelineResults();
    print(timelineDataList);
  }
}

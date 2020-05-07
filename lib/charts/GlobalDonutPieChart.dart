// GlobalDonutPieChart Class with flutter_charts Library

import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19_tracker/models/global_model.dart';
import 'package:covid_19_tracker/models/case_types_data_model.dart';

class GlobalDonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  GlobalStats snapshotData;
  final bool animate;

  GlobalDonutPieChart(this.seriesList, this.snapshotData, {this.animate});

  // Creates a PieChart with data and animation
  factory GlobalDonutPieChart.withCountsData(GlobalStats snapshotData) {
    return GlobalDonutPieChart(_createCountsData(snapshotData), snapshotData, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 70,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
            insideLabelStyleSpec: charts.TextStyleSpec(fontSize: 12, color: charts.ColorUtil.fromDartColor(Colors.grey[100])),
            outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 12, color: charts.ColorUtil.fromDartColor(Colors.grey[350]))
          )
        ]
      ),
    );
  }

  // Create series with counts data
  static List<charts.Series<CaseTypes, String>> _createCountsData(GlobalStats snapshotData) {
    // Colors definition
    final activeColor = charts.ColorUtil.fromDartColor(Colors.blueAccent);
    final deathsColor = charts.ColorUtil.fromDartColor(Colors.redAccent);
    final criticalColor = charts.ColorUtil.fromDartColor(Colors.deepOrangeAccent);
    final recoveredColor = charts.ColorUtil.fromDartColor(Colors.green);

    final totalCounts = Utilities().addTotalCounts(snapshotData.active, snapshotData.deaths, snapshotData.recovered);

    final data = [
      CaseTypes('Deaths', snapshotData.deaths, Utilities().convertCountsToPercentages(snapshotData.deaths, totalCounts)),
      CaseTypes('Critical', snapshotData.critical, Utilities().convertCountsToPercentages(snapshotData.critical, totalCounts)),
      CaseTypes('Recovered', snapshotData.recovered, Utilities().convertCountsToPercentages(snapshotData.recovered, totalCounts)),
      CaseTypes('Active', snapshotData.active, Utilities().convertCountsToPercentages(snapshotData.active, totalCounts)),
    ];

    return [
      charts.Series(
          id: 'Case Counts',
          data: data,
          domainFn: (CaseTypes caseTypes, _) => caseTypes.caseType,
          measureFn: (CaseTypes caseTypes, _) => caseTypes.count,
          labelAccessorFn: (CaseTypes caseTypes, _) =>
            '${caseTypes.percentage.toString()}%',
          colorFn: (CaseTypes caseTypes, _) {
            switch (caseTypes.caseType) {
              case 'Active':
                return activeColor;
              case 'Deaths':
                return deathsColor;
              case 'Critical':
                return criticalColor;
              case 'Recovered':
                return recoveredColor;
              default:
                return charts.MaterialPalette.white;
            }
          }),
    ];
  }
}
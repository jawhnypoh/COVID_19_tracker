// DonutPieChart Class with flutter_charts Library

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19_tracker/models/case_types_data_model.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  // Creates a PieChart with data and animation
  factory DonutPieChart.withCountsData() {
    return DonutPieChart(_createCountsData(), animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 95,
        arcRendererDecorators: [
          charts.ArcLabelDecorator()
        ]
      ),
    );
  }

  // Create one series with counts data
  static List<charts.Series<CaseTypes, String>> _createCountsData() {
    // Colors definition
    final activeColor = charts.ColorUtil.fromDartColor(Colors.blue);
    final deathsColor = charts.ColorUtil.fromDartColor(Colors.redAccent);
    final recoveredColor = charts.ColorUtil.fromDartColor(Colors.green);

    final data = [
      CaseTypes('Active', 2129700),
      CaseTypes('Deaths', 244761),
      CaseTypes('Recovered', 1108886),
    ];

    return [
      charts.Series(id: 'Case Counts', data: data,
          domainFn: (CaseTypes caseTypes, _) => caseTypes.caseType,
          measureFn: (CaseTypes caseTypes, _) => caseTypes.count,
          labelAccessorFn: (CaseTypes caseTypes, _) =>
            '${caseTypes.count.toString()}',
          colorFn: (CaseTypes caseTypes, _) {
            switch (caseTypes.caseType) {
              case 'Active':
                return activeColor;
              case 'Deaths':
                return deathsColor;
              case 'Recovered':
                return recoveredColor;
              default:
                return charts.MaterialPalette.white;
            }
          }),
    ];
  }
}
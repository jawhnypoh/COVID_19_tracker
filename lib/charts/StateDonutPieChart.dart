//// StateDonutPieChart Class with flutter_charts Library
//
//import 'package:covid_19_tracker/models/state_model.dart';
//import 'package:covid_19_tracker/utilities/utilities.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:covid_19_tracker/models/case_types_data_model.dart';
//
//class StateDonutPieChart extends StatelessWidget {
//  final List<charts.Series> seriesList;
//  StateStats snapshotData;
//  final bool animate;
//
//  StateDonutPieChart(this.seriesList, this.snapshotData, {this.animate});
//
//  // Creates a PieChart with data and animation
//  factory StateDonutPieChart.withCountsData(StateStats snapshotData) {
//    return StateDonutPieChart(_createCountsData(snapshotData), snapshotData, animate: true);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return charts.PieChart(
//      seriesList,
//      animate: animate,
//      defaultRenderer: charts.ArcRendererConfig(
//          arcWidth: 70,
//          arcRendererDecorators: [
//            charts.ArcLabelDecorator(
//                insideLabelStyleSpec: charts.TextStyleSpec(fontSize: 12, color: charts.ColorUtil.fromDartColor(Colors.grey[100])),
//                outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 12, color: charts.ColorUtil.fromDartColor(Colors.grey[350]))
//            )
//          ]
//      ),
//    );
//  }
//
//  // Create series with counts data
//  static List<charts.Series<CaseTypes, String>> _createCountsData(StateStats snapshotData) {
//    // Colors definition
//    final activeColor = charts.ColorUtil.fromDartColor(Colors.blueAccent);
//    final deathsColor = charts.ColorUtil.fromDartColor(Colors.redAccent);
//    final recoveredColor = charts.ColorUtil.fromDartColor(Colors.green);
//
//    final activeCases = Utilities().calculateActiveCases(snapshotData.positive, snapshotData.death, snapshotData.recovered);
//    final totalCounts = Utilities().addTotalCountsForState(activeCases, snapshotData.death, snapshotData.recovered);
//
//    final data = [
//      CaseTypes('Deaths', snapshotData.death, Utilities().convertCountsToPercentages(snapshotData.death, totalCounts)),
//      CaseTypes('Recovered', snapshotData.recovered, Utilities().convertCountsToPercentages(snapshotData.recovered, totalCounts)),
//      CaseTypes('Active', activeCases, Utilities().convertCountsToPercentages(activeCases, totalCounts)),
//    ];
//
//    return [
//      charts.Series(
//          id: 'Case Counts',
//          data: data,
//          domainFn: (CaseTypes caseTypes, _) => caseTypes.caseType,
//          measureFn: (CaseTypes caseTypes, _) => caseTypes.count,
//          labelAccessorFn: (CaseTypes caseTypes, _) =>
//          '${caseTypes.percentage.toString()}%',
//          colorFn: (CaseTypes caseTypes, _) {
//            switch (caseTypes.caseType) {
//              case 'Active':
//                return activeColor;
//              case 'Deaths':
//                return deathsColor;
//              case 'Recovered':
//                return recoveredColor;
//              default:
//                return charts.MaterialPalette.white;
//            }
//          }),
//    ];
//  }
//}
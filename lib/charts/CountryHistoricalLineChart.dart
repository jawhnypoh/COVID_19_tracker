// CountryHistoricalLineChart Class with flutter_charts Library

import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19_tracker/models/case_historical_data_model.dart';
import 'package:covid_19_tracker/models/country_model.dart';

class CountryHistoricalLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  CountryStats snapshotData;
  final bool animate;

  CountryHistoricalLineChart(this.seriesList, this.snapshotData, {this.animate});

  // Create HistoricalLineChart with data and animation
  factory CountryHistoricalLineChart.withCountsData(CountryStats snapshotData) {
    return CountryHistoricalLineChart(_createHistoricalData(snapshotData), snapshotData, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
            Utilities().convertNumberToReadable
        ),
        renderSpec: charts.GridlineRendererSpec(
            lineStyle: charts.LineStyleSpec(
                dashPattern: [4,4],
                color: charts.ColorUtil.fromDartColor(Colors.grey[600])
            ),
            labelStyle: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(Colors.grey[350])
            )
        ),
      ),
      domainAxis: charts.DateTimeAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(Colors.grey[350])
            ),
            lineStyle: charts.LineStyleSpec(
                dashPattern: [4,4],
                color: charts.ColorUtil.fromDartColor(Colors.grey[600])
            ),
          ),
          tickProviderSpec: const charts.DayTickProviderSpec(increments: [40]),
          tickFormatterSpec: const charts.AutoDateTimeTickFormatterSpec(
            day: charts.TimeFormatterSpec(
              format: 'MMM', transitionFormat: 'MMM dd',
            ),
          )
      ),
    );
  }

  // Create series with counts data
  static List<charts.Series<CaseHistorical, DateTime>> _createHistoricalData(CountryStats snapshotData) {
    List<CaseHistorical> confirmedHistoricalList = List();
    List<CaseHistorical> deathsHistoricalList = List();
    List<CaseHistorical> recoveredHistoricalList = List();

    // Colors definition
    final confirmedColor = charts.ColorUtil.fromDartColor(Colors.orangeAccent);
    final deathsColor = charts.ColorUtil.fromDartColor(Colors.redAccent);
    final recoveredColor = charts.ColorUtil.fromDartColor(Colors.green);

    // Confirmed Cases Timeline
    for(int i = 0; i < snapshotData.data.timeline.length; i++) {
      confirmedHistoricalList.add(CaseHistorical((snapshotData.data.timeline[i].date).toString() ,snapshotData.data.timeline[i].confirmed, [2,4]));
    }

    // Deaths Timeline
    for(int i = 0; i < snapshotData.data.timeline.length; i++) {
      deathsHistoricalList.add(CaseHistorical((snapshotData.data.timeline[i].date).toString() ,snapshotData.data.timeline[i].deaths, [2,4]));
    }

    // Recovered Timeline
    for(int i = 0; i < snapshotData.data.timeline.length; i++) {
      recoveredHistoricalList.add(CaseHistorical((snapshotData.data.timeline[i].date).toString() ,snapshotData.data.timeline[i].recovered, [2,4]));
    }

    return [
      charts.Series<CaseHistorical, DateTime>(
        id: 'Confirmed Timeline',
        domainFn: (CaseHistorical caseHistorical, _) => Utilities().convertStringToDateTime(caseHistorical.date),
        measureFn: (CaseHistorical caseHistorical, _) => caseHistorical.count,
        colorFn: (CaseHistorical caseHistorical, _) => confirmedColor,
//        dashPatternFn: (CaseHistorical caseHistorical, _) => caseHistorical.dashPattern,
        data: confirmedHistoricalList,
      ),
      charts.Series<CaseHistorical, DateTime>(
        id: 'Deaths Timeline',
        domainFn: (CaseHistorical caseHistorical, _) => Utilities().convertStringToDateTime(caseHistorical.date),
        measureFn: (CaseHistorical caseHistorical, _) => caseHistorical.count,
        colorFn: (CaseHistorical caseHistorical, _) => deathsColor,
//        dashPatternFn: (CaseHistorical caseHistorical, _) => caseHistorical.dashPattern,
        data: deathsHistoricalList,
      ),charts.Series<CaseHistorical, DateTime>(
        id: 'Recovered Timeline',
        domainFn: (CaseHistorical caseHistorical, _) => Utilities().convertStringToDateTime(caseHistorical.date),
        measureFn: (CaseHistorical caseHistorical, _) => caseHistorical.count,
        colorFn: (CaseHistorical caseHistorical, _) => recoveredColor,
//        dashPatternFn: (CaseHistorical caseHistorical, _) => caseHistorical.dashPattern,
        data: recoveredHistoricalList,
      )
    ];
  }
}
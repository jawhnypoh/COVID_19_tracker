// StateHistoricalLineChart Class with flutter_charts Library

import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19_tracker/models/case_historical_data_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:us_states/us_states.dart';

class StateHistoricalLineChart extends StatelessWidget {
  final String stateName;
  final List<charts.Series> seriesList;
  final bool animate;

  StateHistoricalLineChart(this.seriesList, this.stateName, {this.animate});

  // Creates a LineChart with data and animation
  factory StateHistoricalLineChart.withHistoricalData(String stateName) {
    return StateHistoricalLineChart(_createHistoricalData(), stateName, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiResources().getStateHistoricalDataResults(USStates.getName(stateName)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return charts.TimeSeriesChart(
              dataList(snapshot.data),
              animate: animate,
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
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
                  tickProviderSpec: const charts.DayTickProviderSpec(increments: [5]),
                  tickFormatterSpec: const charts.AutoDateTimeTickFormatterSpec(
                    day: charts.TimeFormatterSpec(
                      format: 'MMM dd', transitionFormat: 'MMM dd'
                    ),
                  )
              ),
            );
          }
          else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading Timeline Graph'),
            );
          }
          else {
            return _buildProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(100.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Create series with historical data
  static List<charts.Series<CaseHistorical, DateTime>> _createHistoricalData() {
    return [];
  }

  // Create series with historical data
  static List<charts.Series<CaseHistorical, DateTime>> dataList(List<dynamic> apiData) {
    List<CaseHistorical> confirmedHistoricalList = List();
    List<CaseHistorical> deathsHistoricalList = List();

    // Colors definition
    final confirmedColor = charts.ColorUtil.fromDartColor(Colors.orangeAccent);
    final deathsColor = charts.ColorUtil.fromDartColor(Colors.redAccent);

    // Confirmed Cases Timeline
    for(int i = 0; i < apiData.length; i++) {
      confirmedHistoricalList.add(CaseHistorical(apiData[i]['date'].toString(),
          apiData[i]['cases'], [2,4]));
    }

    // Deaths Timeline
    for(int i = 0; i < apiData.length; i++) {
      deathsHistoricalList.add(CaseHistorical(apiData[i]['date'],
          apiData[i]['deaths'], [2,4]));
    }

    return [
      new charts.Series<CaseHistorical, DateTime>(
        id: 'Confirmed',
        domainFn: (CaseHistorical caseHistorical, _) => Utilities().convertStringToDateTime(caseHistorical.date),
        measureFn: (CaseHistorical caseHistorical, _) => caseHistorical.count,
        colorFn: (CaseHistorical caseHistorical, _) => confirmedColor,
        data: confirmedHistoricalList),
      new charts.Series<CaseHistorical, DateTime>(
        id: 'Deaths',
        domainFn: (CaseHistorical caseHistorical, _) => Utilities().convertStringToDateTime(caseHistorical.date),
        measureFn: (CaseHistorical caseHistorical, _) => caseHistorical.count,
        colorFn: (CaseHistorical caseHistorical, _) => deathsColor,
        data: deathsHistoricalList)
    ];
  }
}
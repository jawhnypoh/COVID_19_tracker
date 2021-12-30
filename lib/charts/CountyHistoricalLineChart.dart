// CountyHistoricalLineChart Class with flutter_charts Library

import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19_tracker/models/case_historical_data_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';


class CountyHistoricalLineChart extends StatelessWidget {
  final String countyName;
  final List<charts.Series> seriesList;
  final bool animate;

  CountyHistoricalLineChart(this.seriesList, this.countyName, {this.animate});

  // Creates a LineChart with data and animation
  factory CountyHistoricalLineChart.withHistoricalData(String stateName) {
    return CountyHistoricalLineChart(_createHistoricalData(), stateName, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
//        future: ApiResources().,
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
      )
    ];
  }
}
// BarChart Class with flutter_charts Library

import 'package:covid_19_tracker/models/top_country_data_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  // Creates a BarChart with data and animation
  factory BarChart.withCountsData() {
    return BarChart(_createCountsData(), animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiResources().getCountryResults(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return charts.BarChart(
              dataList(snapshot.data),
              animate: animate,
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.grey[350])
                  )
                )
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  lineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.gray.shadeDefault
                  ),
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.grey[350])
                  ),
                ),
                tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 6)
              ),
            );
          }
          else if (snapshot.hasError) {
            return Text('Error loading graph');
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

  static List<charts.Series<TopCountry, String>> _createCountsData() {
    return [];
  }

  // Create series with counts data
  static List<charts.Series<TopCountry, String>> dataList(List<dynamic> apiData) {
    List<TopCountry> topCountries = new List();

    // Colors definition
    final barOne = charts.MaterialPalette.red;
    final barTwo = charts.MaterialPalette.pink;
    final barThree = charts.MaterialPalette.deepOrange;
    final barFour = charts.MaterialPalette.yellow;
    final barFive = charts.MaterialPalette.green;


    for (int i = 0; i < 5; i++) {
      topCountries.add(TopCountry(apiData[i]['country'], apiData[i]['cases']));
    }

    return [
      charts.Series<TopCountry, String>(
        id: 'Top Countries',
        domainFn: (TopCountry topCountry, _) => topCountry.countryName,
        measureFn: (TopCountry topCountry, _) => topCountry.count,
        data: topCountries,
        labelAccessorFn: (TopCountry topCountry, _) => '${topCountry.countryName}',
//        colorFn: (TopCountry topCountry, _) {
//          switch (topCountry.count) {
//
//          }
//        }
      )
    ];
  }
}
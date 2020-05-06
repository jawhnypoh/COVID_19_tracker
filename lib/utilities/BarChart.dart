// BarChart Class with flutter_charts Library

import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:covid_19_tracker/models/top_country_data_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
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
                    color: charts.ColorUtil.fromDartColor(Colors.grey[600])
                  ),
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.grey[350])
                  ),
                ),
                tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
                tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                    Utilities().convertNumberToReadable
                ),
              ),
            );
          }
          else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading Bar Graph'),
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

  static List<charts.Series<TopCountry, String>> _createCountsData() {
    return [];
  }

  // Create series with counts data
  static List<charts.Series<TopCountry, String>> dataList(List<dynamic> apiData) {
    List<TopCountry> topCountries = List();

    // Colors definition
    final barOne = charts.ColorUtil.fromDartColor(Colors.redAccent);
    final barTwo = charts.ColorUtil.fromDartColor(Colors.deepOrangeAccent);
    final barThree = charts.ColorUtil.fromDartColor(Colors.orangeAccent);
    final barFour = charts.ColorUtil.fromDartColor(Colors.amberAccent);
    final barFive = charts.ColorUtil.fromDartColor(Colors.yellow);

    for(int i = 0; i < 5; i++) {
      if (i == 0) {
        topCountries.add(TopCountry(apiData[i]['country'], apiData[i]['cases'], barOne));
      }
      else if (i == 1) {
        topCountries.add(TopCountry(apiData[i]['country'], apiData[i]['cases'], barTwo));
      }
      else if (i == 2) {
        topCountries.add(TopCountry(apiData[i]['country'], apiData[i]['cases'], barThree));
      }
      else if (i == 3) {
        topCountries.add(TopCountry(apiData[i]['country'], apiData[i]['cases'], barFour));
      }
      else {
        topCountries.add(TopCountry(apiData[i]['country'], apiData[i]['cases'], barFive));
      }
    }

    return [
      charts.Series<TopCountry, String>(
        id: 'Top Countries',
        domainFn: (TopCountry topCountry, _) => topCountry.countryName,
        measureFn: (TopCountry topCountry, _) => topCountry.count,
        data: topCountries,
        labelAccessorFn: (TopCountry topCountry, _) => '${topCountry.countryName}',
        colorFn: (TopCountry topCountry, _) => topCountry.barColor
      )
    ];
  }
}
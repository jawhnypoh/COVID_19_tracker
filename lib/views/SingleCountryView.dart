// Single Country Screen

import 'package:covid_19_tracker/charts/LegendColoredBox.dart';
import 'package:covid_19_tracker/charts/CountryDonutPieChart.dart';
import 'package:covid_19_tracker/charts/CountryHistoricalLineChart.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:covid_19_tracker/models/country_model.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SingleCountryViewState extends State<SingleCountryView> {
  var dio = Dio();
  String countryName, countryCode;
  int totalTested, totalActive;
  final numberFormatter = NumberFormat('#,###', 'en_US');
  var donutPieChart;
  var historicalLineChart;

  SingleCountryViewState(this.countryName, this.countryCode, this.totalTested, this.totalActive);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Utilities().convertToFullName(countryName)),
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
          child: FutureBuilder<CountryStats>(
            future: ApiResources().getSingleCountryResults(countryCode),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                donutPieChart = CountryDonutPieChart.withCountsData(snapshot.data, totalActive);
                historicalLineChart = CountryHistoricalLineChart.withCountsData(snapshot.data);
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      _buildTotalTestedWidget(snapshot),
                      const Padding(padding: EdgeInsets.only(top: 30.0)),
                      _buildTotalCasesWidget(snapshot),
                      const Padding(padding: EdgeInsets.only(top: 30.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildTotalDeaths(snapshot),
                          _buildTotalRecovered(snapshot),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildTotalActive(snapshot),
                          _buildTotalCritical(snapshot),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      const Divider(color: Colors.grey),
                      Container(
                        height: 300,
                        width: 400,
                        child: donutPieChart,
                      ),
                      _buildPieChartLegend(),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      Container(
                        height: 200,
                        width: 350,
                        child: historicalLineChart,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      _buildLineChartLegend(),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('country data updated ' + Utilities().convertDateTimeTimeStamp(snapshot.data.data.updatedAt),
                            style: const TextStyle(color: Colors.grey)),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                    ],
                  ),
                );
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(100.0),
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        )
      ),
    );
  }

  Widget _buildTotalTestedWidget(snapshot) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Tested', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(totalTested == 0
                      ? 'N/A'
                      : numberFormatter.format(totalTested).toString(),
                      style: TextStyle(fontSize: 60.0, color: Colors.lightBlueAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalCasesWidget(snapshot) {
    return Container(
        child: Center(
          child: Column(
              children: <Widget>[
                Text('Total Confirmed', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                Text(numberFormatter.format(snapshot.data.data.latestData.confirmed).toString(), style: TextStyle(fontSize: 60.0, color: Colors.orangeAccent)),
                Text('+' + numberFormatter.format(snapshot.data.data.today.confirmed).toString() + ' Today', style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent))
              ]
          )
        )
    );
  }

  Widget _buildTotalDeaths(snapshot) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 150.0,
            maxWidth: 150.0,
            minHeight: 80.0,
            maxHeight: 80.0
        ),
        child: Column(
          children: <Widget>[
            AutoSizeText('Total Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.data.latestData.deaths).toString(),
                style: TextStyle(fontSize: 40.0, color: Colors.redAccent), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRecovered(snapshot) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 150.0,
            maxWidth: 150.0,
            minHeight: 80.0,
            maxHeight: 80.0
        ),
        child: Column(
          children: <Widget>[
            Text('Total Recovered', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(numberFormatter.format(snapshot.data.data.latestData.recovered).toString(),
                style: TextStyle(fontSize: 40.0, color: Colors.green), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalActive(snapshot) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 80.0,
          maxHeight: 80.0
        ),
        child: Column(
          children: <Widget>[
            Text('Active Cases', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(numberFormatter.format(totalActive).toString(),
                style: TextStyle(fontSize: 40.0, color: Colors.blueAccent), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalCritical(snapshot) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 80.0,
          maxHeight: 80.0
        ),
        child: Column(
          children: <Widget>[
            Text('Critical Cases', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(numberFormatter.format(snapshot.data.data.latestData.critical).toString(),
                style: TextStyle(fontSize: 40.0, color: Colors.deepOrangeAccent), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartLegend() {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            LegendColoredBox(color: Colors.blueAccent, text: 'Active'),
            LegendColoredBox(color: Colors.redAccent, text: 'Deaths'),
            LegendColoredBox(color: Colors.deepOrangeAccent, text: 'Critical'),
            LegendColoredBox(color: Colors.green, text: 'Recovered'),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChartLegend() {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            LegendColoredBox(color: Colors.orangeAccent, text: 'Confirmed'),
            LegendColoredBox(color: Colors.redAccent, text: 'Deaths'),
            LegendColoredBox(color: Colors.green, text: 'Recovered'),
          ],
        ),
      ),
    );
  }
}

class SingleCountryView extends StatefulWidget {
  // Declare countryName that holds country name
  final String countryName, countryCode;
  final int totalTested, totalActive;

  // Require countryName in constructor
  SingleCountryView({Key key, @required this.countryName, @required this.countryCode, @required this.totalTested, @required this.totalActive}) : super(key : key);

  @override
  SingleCountryViewState createState() => SingleCountryViewState(countryName, countryCode, totalTested, totalActive);
}
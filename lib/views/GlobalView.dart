// Global Screen

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/models/global_model.dart';
import 'package:covid_19_tracker/charts/GlobalDonutPieChart.dart';
import 'package:covid_19_tracker/charts/GlobalHistoricalLineChart.dart';
import 'package:covid_19_tracker/charts/BarChart.dart';
import 'package:covid_19_tracker/charts/LegendColoredBox.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';

class GlobalViewState extends State<GlobalView> {
  final numberFormatter = NumberFormat('#,###', 'en_US');
  var donutPieChart;
  var historicalLineChart;
  var barChart;

  GlobalViewState() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Worldwide'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder<GlobalStats>(
            future: ApiResources().getGlobalResult(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                donutPieChart = GlobalDonutPieChart.withCountsData(snapshot.data);
                barChart = BarChart.withCountsData();
                historicalLineChart = GlobalHistoricalLineChart.withHistoricalData();
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      _buildTotalCasesWidget(snapshot),
                      const Padding(padding: EdgeInsets.only(top: 40.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                      Container(
                        height: 300,
                        width: 400,
                        child: donutPieChart,
                      ),
                      _buildPieChartLegend(),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      Container(
                        height: 200,
                        width: 350,
                        child: historicalLineChart,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      _buildLineChartLegend(),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      _buildAffectedCountries(snapshot),
                      Container(
                        height: 250,
                        width: 350,
                        child: barChart,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Center(
                        child: Text('Countries Most Affected', style: TextStyle(color: Colors.grey[350])),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('global data updated ' + Utilities().convertEpochTimeStamp(snapshot.data.updated),
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
              return _buildProgressIndicator();
            }
          ),
        ),
      )
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

  Widget _buildTotalCasesWidget(snapshot) {
    return Container(
      child: Center(
          child: Column(
              children: <Widget>[
                Text('Total Confirmed', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                Text(numberFormatter.format(snapshot.data.cases).toString(), style: TextStyle(fontSize: 60.0, color: Colors.orangeAccent)),
                Text('+' + numberFormatter.format(snapshot.data.todayCases).toString() + ' Today', style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent))
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
            Text('Total Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(numberFormatter.format(snapshot.data.deaths).toString(),
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
            AutoSizeText(numberFormatter.format(snapshot.data.recovered).toString(),
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
            AutoSizeText(numberFormatter.format(snapshot.data.active).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.blueAccent), maxLines: 1),
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
            AutoSizeText(numberFormatter.format(snapshot.data.critical).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.deepOrangeAccent), maxLines: 1),
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

  Widget _buildAffectedCountries(snapshot) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Countries Affected', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(snapshot.data.affectedCountries).toString(), style: TextStyle(fontSize: 60.0, color: Colors.purple)),
                ]
            )
        )
    );
  }
}

class GlobalView extends StatefulWidget {
  const GlobalView({Key key}) : super(key : key);

  @override
  GlobalViewState createState() => GlobalViewState();
}
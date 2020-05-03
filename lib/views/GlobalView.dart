// Global Screen

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/models/global_model.dart';
import 'package:covid_19_tracker/utilities/DonutPieChart.dart';
import 'package:covid_19_tracker/utilities/ColoredBox.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';

class GlobalViewState extends State<GlobalView> {
  Future<GlobalStats> globalStats;
  final numberFormatter = NumberFormat('#,###', 'en_US');
  var donutPieChart;
  var historicalLineChart;

  GlobalViewState() {}

  @override
  void initState() {
    ApiResources().getGlobalResult();
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
                donutPieChart = DonutPieChart.withCountsData(snapshot.data);
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
                      const Padding(padding: EdgeInsets.only(top: 40.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildTotalActive(snapshot),
                          _buildTotalCritical(snapshot),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey),
                      Container(
                        height: 300,
                        width: 300,
                        child: donutPieChart,
                      ),
                      _buildPieChartLegend(),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      Container(
                        height: 300,
                        width: 300,
                        child: historicalLineChart,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      const Divider(color: Colors.grey),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('API last updated ' + Utilities().convertTimeStamp(snapshot.data.updated)),
                      )
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
            }
          ),
        ),
      )
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
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Total Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.deaths).toString(), style: TextStyle(fontSize: 40.0, color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRecovered(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Total Recovered', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.recovered).toString(), style: TextStyle(fontSize: 40.0, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalActive(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Active Cases', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.active).toString(), style: TextStyle(fontSize: 35.0, color: Colors.blueAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalCritical(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Critical Cases', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.critical).toString(), style: TextStyle(fontSize: 35.0, color: Colors.deepOrangeAccent)),
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
            ColoredBox(color: Colors.blueAccent, text: 'Active'),
            ColoredBox(color: Colors.redAccent, text: 'Deaths'),
            ColoredBox(color: Colors.deepOrangeAccent, text: 'Critical'),
            ColoredBox(color: Colors.green, text: 'Recovered'),
          ],
        ),
      ),
    );
  }
}

class GlobalView extends StatefulWidget {
  const GlobalView({Key key}) : super(key : key);

  @override
  GlobalViewState createState() => GlobalViewState();
}
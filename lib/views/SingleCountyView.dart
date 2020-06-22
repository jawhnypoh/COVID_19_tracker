// Single County Screen

import 'package:covid_19_tracker/models/us_county_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleCountyViewState extends State<SingleCountyView> {
  USCountyStats countyStats;

  final numberFormatter = NumberFormat('#,###', 'en_US');

  SingleCountyViewState(this.countyStats);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(countyStats.countyName + ' County'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                _buildTotalCasesWidget(countyStats),
                const Padding(padding: EdgeInsets.only(top: 40.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildDeathsTodayWidget(countyStats),
                    _buildTotalDeathsWidget(countyStats),
                    _buildFatalityRateWidget(countyStats)
                  ],
                )
              ],
            ),
          ),
        ),
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

  Widget _buildTotalCasesWidget(countyStats) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Confirmed', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(countyStats.cases).toString(), style: TextStyle(fontSize: 70.0, color: Colors.orangeAccent)),
                  Text('+' + numberFormatter.format(countyStats.newCases).toString() + ' Today', style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent))
                ]
            )
        )
    );
  }

  Widget _buildDeathsTodayWidget(countyStats) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Deaths Today', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text('+' + numberFormatter.format(countyStats.newDeaths).toString(), style: TextStyle(fontSize: 40.0, color: Colors.redAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalDeathsWidget(countyStats) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(countyStats.deaths).toString(), style: TextStyle(fontSize: 40.0, color: Colors.redAccent)),
                ]
            )
        )
    );
  }

  Widget _buildFatalityRateWidget(countyStats) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Death Rate', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(countyStats.fatalityRate, style: TextStyle(fontSize: 40.0, color: Colors.deepPurpleAccent)),
                ]
            )
        )
    );
  }
}

class SingleCountyView extends StatefulWidget {
  // Declare countyStats that holds county info
  final USCountyStats countyStats;

  // Require countyStats in constructor
  SingleCountyView({Key key, @required this.countyStats}) : super(key : key);

  @override
  SingleCountyViewState createState() => SingleCountyViewState(countyStats);
}
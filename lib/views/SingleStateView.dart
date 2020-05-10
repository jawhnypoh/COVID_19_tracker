// Single State Screen

import 'dart:convert';
import 'package:covid_19_tracker/models/state_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:us_states/us_states.dart';

class SingleStateViewState extends State<SingleStateView> {
  var dio = Dio();
  StateStats stateStats;
  SingleStateViewState(this.stateStats);
//  Future<StateStats> stateStats;
  final numberFormatter = NumberFormat('#,###', 'en_US');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(USStates.getName(stateStats.state)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                _buildTotalTestedWidget(stateStats),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                _buildTotalCasesWidget(stateStats),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTotalActive(stateStats),
                    _buildTotalDeaths(stateStats),
                    _buildTotalRecovered(stateStats),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 40.0)),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    _buildCasesToday(stateStats),
//                    _buildDeathsToday(stateStats),
//                  ],
//                ),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
              ],
            ),
          )
        )
      )
    );
  }

  Widget _buildTotalTestedWidget(stateStat) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Tested', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(stateStat.totalTestResults).toString(), style: TextStyle(fontSize: 60.0, color: Colors.lightBlueAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalCasesWidget(stateStat) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Confirmed', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(stateStat.positive).toString(), style: TextStyle(fontSize: 60.0, color: Colors.orangeAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalActive(stateStat) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Active', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(Utilities().calculateTotalActiveCases(stateStat.positive, stateStat.death, stateStat.recovered)).toString(), style: TextStyle(fontSize: 35.0, color: Colors.blueAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRecovered(stateStat) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Total Recovered', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(stateStat.recovered).toString(), style: TextStyle(fontSize: 35.0, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalDeaths(stateStat) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(stateStat.death).toString(), style: TextStyle(fontSize: 35.0, color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }
}

class SingleStateView extends StatefulWidget {
  // Declare stateName that holds state name
  final StateStats stateStats;

  // Require stateName in constructor
  SingleStateView({Key key, @required this.stateStats}) : super(key : key);

  @override
  SingleStateViewState createState() => SingleStateViewState(stateStats);
}
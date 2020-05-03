// Single State Screen

import 'dart:convert';
import 'package:covid_19_tracker/models/state_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';

class SingleStateViewState extends State<SingleStateView> {
  var dio = Dio();
  String stateName;
  SingleStateViewState(this.stateName);
  final String _stateURL = "https://disease.sh/v2/states/";
  Future<StateStats> stateStats;
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
        title: Text(stateName),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder<StateStats>(
            future: getStateStats(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildTotalActive(snapshot),
                          _buildTotalDeaths(snapshot),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildCasesToday(snapshot),
                          _buildDeathsToday(snapshot),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30.0)),
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
        ),
      ),
    );
  }

  Widget _buildTotalTestedWidget(snapshot) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Tested', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(snapshot.data.tested).toString(), style: TextStyle(fontSize: 60.0, color: Colors.lightBlueAccent)),
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
                  Text(numberFormatter.format(snapshot.data.cases).toString(), style: TextStyle(fontSize: 60.0, color: Colors.orangeAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalActive(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Active', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.active).toString(), style: TextStyle(fontSize: 35.0, color: Colors.blueAccent)),
          ],
        ),
      ),
    );
  }



  Widget _buildTotalDeaths(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.deaths).toString(), style: TextStyle(fontSize: 35.0, color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildCasesToday(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Cases Today', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text('+' + numberFormatter.format(snapshot.data.todayCases).toString(), style: TextStyle(fontSize: 35.0, color: Colors.orangeAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildDeathsToday(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Deaths Today', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text('+' + numberFormatter.format(snapshot.data.todayDeaths).toString(), style: TextStyle(fontSize: 35.0, color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }

  // Append stateName to end of URL
  String addStateNameToURL(String stateName) {
      return _stateURL + stateName;
  }

  // Get results from disease.sh API for specific state
  Future<StateStats> getStateStats() async {
    try {
      final Response response = await dio.get(addStateNameToURL(stateName));
      final jsonResult = json.decode(response.toString());
      return StateStats.fromJson(jsonResult);
    } catch (e) {
      print(e);
    }
  }
}

class SingleStateView extends StatefulWidget {
  // Declare stateName that holds state name
  final String stateName;

  // Require stateName in constructor
  SingleStateView({Key key, @required this.stateName}) : super(key : key);

  @override
  SingleStateViewState createState() => SingleStateViewState(stateName);
}
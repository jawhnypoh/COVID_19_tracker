// Global Screen

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:covid_19_tracker/models/global_model.dart';
import 'package:covid_19_tracker/utilities/time_since_updated_converter.dart';

class GlobalViewState extends State<GlobalView> {
  var dio = Dio();
  final String _globalURL = 'https://disease.sh/v2/all';
  int updatedTimeFromJsonResponse = 0;
  Future<GlobalStats> globalStats;
  final numberFormatter = NumberFormat('#,###', 'en_US');

  GlobalViewState() {}

  @override
  void initState() {
    getGlobalResult();
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
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: FutureBuilder<GlobalStats>(
            future: getGlobalResult(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
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
//                      Expanded(child: Container()),
//                      Text('Updated ' + TimeSinceUpdatedConverter().convertTimeStamp(snapshot.data.updated)
//                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
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
            Text(numberFormatter.format(snapshot.data.active).toString(), style: TextStyle(fontSize: 35.0, color: Colors.deepOrangeAccent)),
          ],
        ),
      ),
    );
  }

  // Get results from disease.sh API for worldwide
  Future<GlobalStats> getGlobalResult() async {
    try {
      final Response response = await dio.get(_globalURL);
      final jsonResult = json.decode(response.toString());
      updatedTimeFromJsonResponse = jsonResult['updated'];
      print(TimeSinceUpdatedConverter().convertTimeStamp(updatedTimeFromJsonResponse));
      return GlobalStats.fromJson(jsonResult);
    } catch (e) {
      print(e);
    }
  }
}

class GlobalView extends StatefulWidget {
  const GlobalView({Key key}) : super(key : key);

  @override
  GlobalViewState createState() => GlobalViewState();
}
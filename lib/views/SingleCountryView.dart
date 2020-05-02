// Single Country Screen

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/models/country_model.dart';
import 'package:covid_19_tracker/utilities/countries_full_name_converter.dart';

class SingleCountryViewState extends State<SingleCountryView> {
  var dio = Dio();
  String countryName;
  SingleCountryViewState(this.countryName);
  final String _countryURL = "https://disease.sh/v2/countries/";
  Future<CountryStats> countryStats;
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
        title: Text(CountriesFullNameConverter().convertToFullName(countryName)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder<CountryStats>(
            future: getCountryResults(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildTotalActive(snapshot),
                          _buildTotalRecovered(snapshot),
                          _buildTotalDeaths(snapshot),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildCasesToday(snapshot),
                          _buildDeathsToday(snapshot,)
                        ],
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

  Widget _buildTotalRecovered(snapshot) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Recovered', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.recovered).toString(), style: TextStyle(fontSize: 35.0, color: Colors.green)),
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
            Text('Active', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            Text(numberFormatter.format(snapshot.data.active).toString(), style: TextStyle(fontSize: 35.0, color: Colors.blueAccent)),
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

  // Append countryName to end of URL
  String addCountryNameToURL(String countryName) {
    return _countryURL + countryName;
  }

  // Get results from diseaseh.sh API for specific country
  Future<CountryStats> getCountryResults() async {
    try {
      final Response response = await dio.get(addCountryNameToURL(countryName));
      final jsonResult = json.decode(response.toString());
      return CountryStats.fromJson(jsonResult);
    } catch (e) {
      print(e);
    }
  }
}

class SingleCountryView extends StatefulWidget {
  // Declare countryName that holds country name
  final String countryName;

  // Require countryName in constructor
  SingleCountryView({Key key, @required this.countryName}) : super(key : key);

  @override
  SingleCountryViewState createState() => SingleCountryViewState(countryName);
}
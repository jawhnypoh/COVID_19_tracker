// Countries Screen

import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:covid_19_tracker/views/SingleCountryView.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';

class CountriesViewState extends State<CountriesView> {
  var dio = Dio();
  ScrollController _scrollController = ScrollController();
  List countriesList = List();
  bool isLoading = true;
  final numberFormatter = new NumberFormat("#,###", "en_US");

  CountriesViewState() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: FutureBuilder(
        future: ApiResources().getCountryResults(),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? _buildCountriesResultsList(snapshot.data)
              : _buildProgressIndicator();
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text('Countries')
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildCountriesResultsList(List countriesList) {
    return ListView.separated(
      itemCount: countriesList == null ? 0 : countriesList.length,
      itemBuilder: (BuildContext context, int idx) {
        if (countriesList.isEmpty) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            leading: Image.network(countriesList[idx]['countryInfo']['flag'],
                width: 75.0, height: 50.0),
            title: Text(Utilities().convertToFullName(countriesList[idx]['country']),
                style: const TextStyle(fontSize: 25.0)),
            subtitle: Text(numberFormatter.format(countriesList[idx]['cases']).toString() + ' cases',
                style: const TextStyle(fontSize: 20.0, color: Colors.orangeAccent)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingleCountryView(countryName: countriesList[idx]['country']))
              );
            },
          );
        }
      },
      separatorBuilder: (context, idx) {
        return Divider();
      },
      controller: _scrollController,
    );
  }
}

class CountriesView extends StatefulWidget {
  const CountriesView({Key key}) : super(key : key);

  @override
  CountriesViewState createState() => CountriesViewState();
}
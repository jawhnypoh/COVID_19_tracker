// Countries Screen

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:covid_19_tracker/views/SingleCountryView.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';

class CountriesViewState extends State<CountriesView> {
  final String _countriesURL = 'https://disease.sh/v2/countries';
  var dio = Dio();

  ScrollController _scrollController = ScrollController();
  TextEditingController _editingController = new TextEditingController();

  Future _future;

  List countriesList = List();
  List searchCountriesList = List();

  final numberFormatter = new NumberFormat("#,###", "en_US");

  CountriesViewState() {}

  @override
  void initState() {
    super.initState();
    _future = getCountryResults();
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
        future: _future,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? _buildListAndSearchContainer(snapshot.data)
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
    return const Padding(
      padding: EdgeInsets.all(100.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  Widget _buildListAndSearchContainer(List countriesList) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterCountryResults(value);
              },
              controller: _editingController,
              decoration: InputDecoration(
                  hintText: 'Search for Country',
                  prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _buildCountriesResultsList(searchCountriesList),
          )
        ],
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
                  MaterialPageRoute(builder: (context) => SingleCountryView(
                      countryName: countriesList[idx]['country'],
                      countryCode: countriesList[idx]['countryInfo']['iso2'],
                      totalTested: countriesList[idx]['tests'],
                      totalActive: countriesList[idx]['active']))
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

  // Filter country results list based on querying value from search
  void filterCountryResults(String queryValue) {
    List duplicateCountryList = List();
    duplicateCountryList.addAll(searchCountriesList);

    if (queryValue.isNotEmpty) {
      List countriesSearchList = List();

      duplicateCountryList.forEach((country) {
        if (Utilities().convertToFullName(country['country']).toLowerCase().contains(queryValue.toLowerCase())) {
          print(country['country']);
          countriesSearchList.add(country);
        }
      });

      print(countriesSearchList.length);

      setState(() {
        searchCountriesList.clear();
        searchCountriesList.addAll(countriesSearchList);
      });
      return;
    } else {
      setState(() {
        searchCountriesList.clear();
        searchCountriesList.addAll(countriesList);
      });
    }
  }

  // Get results from disease.sh API for all countries
  Future<List> getCountryResults() async {
    final List resultsList = List();

    try {
      final Response response = await dio.get(_countriesURL);
      for(int i = 0; i <response.data.length; i++) {
        resultsList.add(response.data[i]);
      }
      resultsList.sort((b, a) => a['cases'].compareTo(b['cases']));

      setState(() {
        countriesList = resultsList;
        searchCountriesList.addAll(resultsList);
      });
      return resultsList;
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class CountriesView extends StatefulWidget {
  const CountriesView({Key key}) : super(key : key);

  @override
  CountriesViewState createState() => CountriesViewState();
}
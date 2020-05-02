// Countries Screen

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';


class CountriesViewState extends State<CountriesView> {
  var dio = Dio();
  ScrollController _scrollController = ScrollController();
  List countriesList = List();
  final String _countriesURL = "https://disease.sh/v2/countries";
  bool isLoading = true;
  final numberFormatter = new NumberFormat("#,###", "en_US");

  CountriesViewState() {}

  @override
  void initState() {
    getCountryResults();
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
      body: Container(
        child: _buildCountriesResultsList(),
      ),
      resizeToAvoidBottomPadding: false,
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

  Widget _buildCountriesResultsList() {
    return ListView.separated(
      itemCount: countriesList == null ? 0 : countriesList.length,
      itemBuilder: (BuildContext context, int idx) {
        if (idx == countriesList.length) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            leading: Image.network(countriesList[idx]['countryInfo']['flag'],
              width: 75.0, height: 50.0),
            title: Text(countriesList[idx]['country'], style: const TextStyle(fontSize: 25.0)),
            subtitle: Text(numberFormatter.format(countriesList[idx]['cases']).toString() + ' Cases',
                style: const TextStyle(fontSize: 20.0, color: Colors.orangeAccent)),
          );
        }
      },
      separatorBuilder: (context, idx) {
        return Divider();
      },
      controller: _scrollController,
    );
  }

  // Get results from disease.sh API for all countries
  Future<Response> getCountryResults() async {
    final List resultsList = List();

    try {
      final Response response = await dio.get(_countriesURL);
      for(int i = 0; i <response.data.length; i++) {
        resultsList.add(response.data[i]);
      }

      resultsList.sort((b, a) => a['cases'].compareTo(b['cases']));

      setState(() {
        countriesList = resultsList;
        isLoading = false;
      });
      return response;
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
